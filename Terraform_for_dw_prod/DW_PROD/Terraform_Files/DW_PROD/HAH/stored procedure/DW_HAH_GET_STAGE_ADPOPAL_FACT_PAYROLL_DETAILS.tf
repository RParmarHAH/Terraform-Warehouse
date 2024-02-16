resource "snowflake_procedure" "DW_HAH_GET_STAGE_ADPOPAL_FACT_PAYROLL_DETAILS" {
	name ="GET_STAGE_ADPOPAL_FACT_PAYROLL_DETAILS"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN

--*****************************************************************************************************************************
-- NAME: ADPOPAL_FACT_PAYROLL_DETAILS
--
-- PURPOSE: Creates one row for each PAYCODE according to ADP-OPAL
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR                					NOTES:
-- ----------		--------------------------------		-------------------------------------------------------------------
-- 27/12/2022		Aditya Shukla							Initial Development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ADPOPAL_FACT_PAYROLL_DETAILS

WITH EMPLOYEE AS (
	SELECT DISTINCT 
		MASTER_ID, FILE_NUMBER, PAYROLL_COMPANY_CODE AS COMPANY_CODE, HOME_DEPARTMENT_CODE, HOME_DEPARTMENT_DESCRIPTION 
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ADP.OPAL_EMPLOYEE_MASTER_LIST
	UNION
	SELECT DISTINCT 
		MASTER_ID, FILE_NUMBER, COMPANY_CODE, HOME_DEPARTMENT_CODE, HOME_DEPARTMENT_DESCRIPTION 
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ADP.OPAL_EMPLOYEE_MATCH_LIST 
	WHERE FILE_NUMBER NOT IN (SELECT DISTINCT FILE_NUMBER FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ADP.OPAL_EMPLOYEE_MASTER_LIST)
), 
PAY_CODE_TYPE AS (
	SELECT DISTINCT 
		CASE WHEN PAY_CODE_TYPE = ''TAXABLE EARNINGS'' THEN ''T''
			WHEN PAY_CODE_TYPE = ''NON-TAXABLE REIMBURSEMENT'' THEN ''R''
		END AS PAY_CODE_TYPE,
		PAY_CODE_TYPE AS PAY_CODE_TYPE_DESC
	FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_PAYCODE_MAPPING PCM 
	WHERE PCM.SYSTEM_CODE ILIKE ''%OPAL%''
), PAY_DETAIL AS (
	SELECT DISTINCT 
		PAY.COMPANY_CODE,
		PAY.FILE_NUMBER,
		PAY_DATE,
		WORKED_IN_STATE,
		CHECK_VOUCHER_NUMBER,
		PERIOD_BEGINNING_DATE,
		PERIOD_ENDING_DATE,
		RATE,
		RATE_TYPE,
		PAYCODES,
		COALESCE(EMP.HOME_DEPARTMENT_CODE, PAY.WORKED_IN_DEPARTMENT) AS WORKED_IN_DEPARTMENT,
		SUM(NVL(TOTAL_HOURS, 0)) AS TOTAL_HOURS,
		SUM(REPLACE(REPLACE(AMOUNT, '',''), ''$'')) AS AMOUNT
	FROM DISC_${var.SF_ENVIRONMENT}.ADP.OPALPAYROLLDETAIL PAY
	LEFT JOIN EMPLOYEE EMP
		ON EMP.FILE_NUMBER::INT = PAY.FILE_NUMBER AND EMP.COMPANY_CODE = PAY.COMPANY_CODE
	GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
) --SELECT * FROM PAY_DETAIL;
SELECT DISTINCT 
	MD5(18 || PAY.COMPANY_CODE || COALESCE(EMP.MASTER_ID, PAY.FILE_NUMBER) || PAY.PAY_DATE || PAY.CHECK_VOUCHER_NUMBER || PAY.PERIOD_BEGINNING_DATE || COALESCE(PAY.WORKED_IN_STATE, ''UNKNOWN'') || COALESCE(PAY_CODE, ''UNKNOWN'') || ''OPAL'') AS PAYROLL_DETAIL_KEY,
	MD5(18 || PAY.COMPANY_CODE || PAY.PAY_DATE || PAY.CHECK_VOUCHER_NUMBER || COALESCE(EMP.MASTER_ID, PAY.FILE_NUMBER) || PAY.PERIOD_BEGINNING_DATE || ''OPAL'') AS PAYROLL_KEY,
	PAY_DATE::DATE AS REPORT_DATE,
	MD5(18 || PAY.COMPANY_CODE || COALESCE(EMP.MASTER_ID, PAY.FILE_NUMBER) || ''OPAL'') AS EMPLOYEE_KEY,
	BRANCH.BRANCH_KEY AS BRANCH_KEY,
	18 AS SOURCE_SYSTEM_ID,
	PAY_DATE::DATE AS PAYROLL_DATE,
	RIGHT(''000000'' || COALESCE(EMP.FILE_NUMBER, PAY.FILE_NUMBER), 6) AS EMPLOYEE_ID,
	BRANCH.BRANCH_NAME AS BRANCH_NAME,
	''ADP-OPAL-'' || PAY.COMPANY_CODE AS SYSTEM_CODE,
	PERIOD_BEGINNING_DATE::DATE AS PAY_PERIOD_START_DATE,
	PERIOD_ENDING_DATE::DATE AS PAY_PERIOD_END_DATE,
	CHECK_VOUCHER_NUMBER AS CHECK_NUMBER,
	PCM.PAY_CODE AS PAY_CODE,
	PCM.PAY_CODE_DESCRIPTION AS PAY_CODE_DESCRIPTION,
	PCT.PAY_CODE_TYPE AS PAY_CODE_TYPE,
	PCM.PAY_CODE_TYPE AS PAY_CODE_TYPE_DESCRIPTION,
	PCM.PAY_CODE_CATEGORY AS PAY_CODE_CATEGORY,
	TOTAL_HOURS AS NUMBER_OF_UNITS,
	CASE WHEN PAY.RATE_TYPE = ''Hourly'' THEN ''H''
		WHEN PAY.RATE_TYPE = ''Salary'' THEN ''S''
		WHEN PAY.RATE_TYPE = ''Daily'' THEN ''D''
		ELSE NULL 
	END AS UNIT_TYPE_CODE,
	UPPER(PAY.RATE_TYPE) AS UNIT_TYPE_DESCRIPTION,
	REPLACE(REPLACE(RATE, '',''), ''$'') AS RATE,
	PAY.AMOUNT AS AMOUNT,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		CURRENT_DATE() AS ETL_INSERTED_DATE,
		CURRENT_USER() AS ETL_INSERTED_BY,
		CURRENT_DATE() AS ETL_LAST_UPDATED_DATE,
		CURRENT_USER() AS ETL_LAST_UPDATED_BY,
		FALSE ETL_DELETED_FLAG
FROM PAY_DETAIL AS PAY
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_PAYCODE_MAPPING PCM
	ON PCM.PAYCODE_MAPPING_KEY = MD5(18 || PAYCODES || COALESCE(PAY.WORKED_IN_STATE, ''UNKNOWN'') || PAY.COMPANY_CODE || ''OPAL'')
	AND PCM.SYSTEM_CODE ILIKE ''%ADP-OPAL%''
LEFT JOIN PAY_CODE_TYPE PCT 
	ON PCT.PAY_CODE_TYPE_DESC = PCM.PAY_CODE_TYPE
LEFT JOIN EMPLOYEE EMP
	ON EMP.FILE_NUMBER::INT = PAY.FILE_NUMBER AND EMP.COMPANY_CODE = PAY.COMPANY_CODE
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH BRANCH
	ON BRANCH.OFFICE_NUMBER = COALESCE(EMP.HOME_DEPARTMENT_CODE, PAY.WORKED_IN_DEPARTMENT)::NUMBER
	AND BRANCH.SYSTEM_CODE ILIKE ''%ADP-OPAL%'';

RETURN ''SUCESS'';

END;

 EOT
}

