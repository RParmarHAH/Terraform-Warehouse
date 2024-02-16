resource "snowflake_procedure" "DW_HAH_GET_STAGE_ADPANSWERCARE_FACT_PAYROLL_DETAILS" {
	name ="GET_STAGE_ADPANSWERCARE_FACT_PAYROLL_DETAILS"
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
-- NAME: ADPANSWERCARE_FACT_PAYROLL_DETAILS
--
-- PURPOSE: Creates one row for each PAYCODE according to ADP-ANSWERCARE
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR                					NOTES:
-- ----------		--------------------------------		-------------------------------------------------------------------
-- 18/10/2022		Aditya Shukla / Jigar Prajapati			Initial Development
--*****************************************************************************************************************************


INSERT OVERWRITE INTO STAGE.ADPANSWERCARE_FACT_PAYROLL_DETAILS

WITH EMPLOYEE AS (
	SELECT 
		ID, MASTER_ID, MD5(''ADP'' || ''-'' || MASTER_ID || ''ANSWERCARE'') AS EMPLOYEE_KEY
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ADP.ANSWERCARE_EMPLOYEE_MASTER_LIST
	UNION
	SELECT
		ID, MASTER_ID, MD5(''ADP'' || ''-'' || MASTER_ID || ''ANSWERCARE'')
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ADP.ANSWERCARE_EMPLOYEE_MATCH_LIST
	WHERE ID NOT IN (SELECT DISTINCT ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ADP.ANSWERCARE_EMPLOYEE_MASTER_LIST)
)
SELECT DISTINCT
	MD5(18 || EMP.ID || APD.CHECK_VOUCHER_NUMBER || NVL(APD.PAYCODES, ''UNKNOWN'') || APD.PERIOD_BEGINNING_DATE || ''ANSWERCARE'') AS PAYROLL_DETAIL_KEY,
	MD5(18 || CAST(APD.PAY_DATE AS DATE) || ''-'' || EMP.MASTER_ID || ''-'' || APD.CHECK_VOUCHER_NUMBER || ''ANSWERCARE'') AS PAYROLL_KEY,
	PAY_DATE::DATE AS REPORT_DATE,
	COALESCE(EMP.EMPLOYEE_KEY, MD5(''ADP'' || ''-'' || EMP.MASTER_ID || ''ANSWERCARE'')) AS EMPLOYEE_KEY,
	COALESCE(CDE.PRIMARY_BRANCH_KEY, ''UNKNOWN'') AS BRANCH_KEY,
	18 AS SOURCE_SYSTEM_ID,
	PAY_DATE::DATE AS PAYROLL_DATE,
	FILE_NUMBER AS EMPLOYEE_ID,
	COALESCE(CDE.PRIMARY_BRANCH_NAME, ''UNKNOWN'') AS BRANCH_NAME,
	COMPANY_CODE AS SYSTEM_CODE,
	PERIOD_BEGINNING_DATE::DATE AS PAY_PERIOD_START_DATE,
	PERIOD_ENDING_DATE::DATE AS PAY_PERIOD_END_DATE,
	CHECK_VOUCHER_NUMBER AS CHECK_NUMBER,
	PCM.PAY_CODE AS PAY_CODE,
	PCM.PAY_CODE_DESCRIPTION AS PAY_CODE_DESCRIPTION,
	NULL AS PAY_CODE_TYPE,
	NULL AS PAY_CODE_TYPE_DESCRIPTION,
	PCM.PAY_CODE_CATEGORY AS PAY_CODE_CATEGORY,
	REPLACE(TOTAL_HOURS, '','') AS NUMBER_OF_UNITS,
	CASE 
		WHEN PCM.PAY_CODE_CATEGORY IN (''REIMBURSEMENT'') THEN ''R''
		WHEN PCM.PAY_CODE_CATEGORY IN (''DAILY'') THEN ''D''
		WHEN PCM.PAY_CODE_CATEGORY IN (''TRAVEL TIME & MILEAGE'') THEN ''M''
		ELSE ''H''
	END AS UNIT_TYPE_CODE,
	CASE WHEN PAY_CODE_CATEGORY IN (''REIMBURSEMENT'', ''DAILY'') THEN PAY_CODE_CATEGORY
			 WHEN PAY_CODE_CATEGORY IN (''TRAVEL TIME & MILEAGE'') THEN ''MILEAGE''
			 ELSE ''HOURLY'' 
	END AS UNIT_TYPE_DESCRIPTION,
	REPLACE(REPLACE(RATE, ''$''), '','') AS RATE,
	REPLACE(AMOUNT, '','') AS AMOUNT,
		-1 AS ETL_TASK_KEY,
		-1 AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_INSERTED_DATE,
		CURRENT_USER AS ETL_INSERTED_BY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_LAST_UPDATED_DATE,
		CURRENT_USER AS ETL_LAST_UPDATED_BY,
		FALSE AS ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.ADP.ANSWERCARE_PAYROLL_DETAIL AS APD
LEFT JOIN STAGE.ADPANSWERCARE_DIM_PAYCODE_MAPPING PCM
	ON PCM.PAYCODE_MAPPING_KEY = MD5(18 || APD.PAYCODES || ''ANSWERCARE'')
LEFT JOIN EMPLOYEE EMP
	ON TRIM(APD.FILE_NUMBER) = TRIM(EMP.ID)
LEFT JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.ADP.ANSWERCARE_EMPLOYEE_MASTER_LIST EML
	ON EML.EMPLOYEE_SSN = REPLACE(APD.TAX_ID, ''-'')
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_EMPLOYEE CDE
	ON CDE.SOURCE_SYSTEM_ID = 16 AND 
	CASE WHEN EML.EMPLOYEE_FIRST_NAME = ''TALISHA''
		THEN ''TALISHIA'' 
		ELSE REPLACE(EML.EMPLOYEE_FIRST_NAME, '''')
	END 
	|| 
	REPLACE(EML.EMPLOYEE_LAST_NAME, '''')
	= 
	CASE WHEN RIGHT(TRIM(UPPER(cde.EMPLOYEE_FIRST_NAME)), 3) = ''LOA'' THEN SUBSTRING(TRIM(UPPER(CDE.EMPLOYEE_FIRST_NAME)), 0, LENGTH(CDE.EMPLOYEE_FIRST_NAME) - 3) ELSE TRIM(UPPER(CDE.EMPLOYEE_FIRST_NAME)) END 
	|| 
	CASE WHEN RIGHT(TRIM(UPPER(CDE.EMPLOYEE_LAST_NAME)), 3) = ''LOA'' THEN SUBSTRING(TRIM(UPPER(CDE.EMPLOYEE_LAST_NAME)), 0, LENGTH(CDE.EMPLOYEE_LAST_NAME) - 3) ELSE TRIM(UPPER(CDE.EMPLOYEE_LAST_NAME)) END;

END;

 EOT
}

