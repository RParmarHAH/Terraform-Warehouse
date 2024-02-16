resource "snowflake_procedure" "DW_HAH_GET_STAGE_EMPEONPREFERRED_FACT_PAYROLL_DETAILS" {
	name ="GET_STAGE_EMPEONPREFERRED_FACT_PAYROLL_DETAILS"
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
-- NAME: EMPEONPREFERRED_FACT_PAYROLL_DETAILS
--
-- PURPOSE: Creates one row for each paycode according TO EMPEON-PREFERRED
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR                					NOTES:
-- ----------		--------------------------------		-------------------------------------------------------------------
-- 18/10/2022		Aditya Shukla / Jigar Prajapati			Initial Development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.EMPEONPREFERRED_FACT_PAYROLL_DETAILS

WITH EMPLOYEE AS (
	SELECT * FROM (
		SELECT  
			--TRIM(ID) AS ID, 
			CO, TRIM(ID) AS CAREGIVER_ID, MASTER_ID, MD5(''EMPEON'' || ''-'' || MASTER_ID || ''EMPEONPREFERRED'') AS EMPLOYEE_KEY
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.EMPLOYEE_MASTER_LIST
	)
	UNION
	SELECT * FROM (
		SELECT 
			--TRIM(EML.ID) AS ID, 
			CO AS CO, TRIM(CAREGIVER_ID) AS CAREGIVER_ID, MASTER_ID, MD5(''EMPEON'' || ''-'' || MASTER_ID || ''EMPEONPREFERRED'') AS EMPLOYEE_KEY
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.EMPLOYEE_MATCH_LIST EML
		WHERE CO || TRIM(CAREGIVER_ID) NOT IN (SELECT CO||TRIM(ID) AS MASTER_ID  FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.EMPLOYEE_MASTER_LIST)
	)
),
PAYCODE AS (
	SELECT
		DISTINCT CO AS CO ,
		DCODE AS PAYCODE ,
		DESCRIPTION AS PAYCODE_DESCRIPTION ,
		DEDTYPE AS PAYCODE_TYPE
	FROM
		DISC_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.CDED
	UNION
	SELECT DISTINCT 
		CO AS CO ,
		ECODE AS PAYCODE,
		DESCRIPTION AS PAYCODE_DESCRIPTION,
		EARNTYPE AS PAYCODE_TYPE
	FROM DISC_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.CEARN
	WHERE PAYCODE <> ''GTL''
),
REPORT_DATE AS (
	SELECT DISTINCT 
		P.TRANS,
		P.ID,
		P.CO,
		P.CHECKNUMBER,
		MAX(P.CHECKDATE) AS REPORT_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.EPAYHIST P
	GROUP BY P.TRANS, P.ID, P.CO, P.CHECKNUMBER
)
--SELECT * FROM ;
SELECT DISTINCT
	MD5(22 || ''-'' || PD.TRANS || TRIM(COALESCE(EMP.MASTER_ID, PH.ID)) || PD.SUBTRANS || ''EMPEONPREFERRED'') AS PAYROLL_DETAIL_KEY ,
	MD5(PH.TRANS || ''-'' || TRIM(COALESCE(EMP.MASTER_ID, PH.ID)) || ''EMPEONPREFERRED'') AS PAYROLL_KEY ,
	RD.REPORT_DATE::DATE AS REPORT_DATE ,
	COALESCE(EMP.EMPLOYEE_KEY, MD5(''EMPEON'' || ''-'' || TRIM(PH.ID) || ''EMPEONPREFERRED'')) AS EMPLOYEE_KEY ,
	MD5(22 || ''-'' || TRIM(COALESCE(emp.CO, PD.CO)) || ''-'' || ''EMPEONPREFERRED'') AS BRANCH_KEY ,
	22 AS SOURCE_SYSTEM_ID ,
	RD.REPORT_DATE::DATE AS PAYROLL_DATE,
	TRIM(RD.ID) AS EMPLOYEE_ID ,
	TRIM(COALESCE(emp.CO, PD.CO)) AS BRANCH_NAME ,
	''EMPEONPREFERRED'' || ''-'' || TRIM(PD.CO) AS SYSTEM_CODE ,
	PD.BEGINDATE::DATE AS PAY_PERIOD_START_DATE ,
	PD.ENDDATE::DATE AS PAY_PERIOD_END_DATE ,
	RD.CHECKNUMBER AS CHECK_NUMBER ,
	DETCODE AS PAY_CODE ,
	PAYCODE_DESCRIPTION AS PAY_CODE_DESCRIPTION ,
	DET AS PAY_CODE_TYPE ,
	PAYCODE_TYPE AS PAY_CODE_TYPE_DESCRIPTION ,
	NULL AS PAY_CODE_CATEGORY ,
	PD.HOURS AS NUMBER_OF_UNITS ,
	''H'' AS UNIT_TYPE_CODE ,
	''Hourly'' AS UNIT_TYPE_DESCRIPTION ,
	RATE AS RATE ,
	AMOUNT AS AMOUNT,
		-1 AS ETL_TASK_KEY,
		-1 AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'',
		CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
		CURRENT_USER AS ETL_INSERTED_BY,
		convert_timezone(''UTC'',
		CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
		CURRENT_USER AS ETL_LAST_UPDATED_BY,
		FALSE AS ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.EPAYHISTDETAIL PD
LEFT JOIN REPORT_DATE RD ON
	RD.TRANS = PD.TRANS
LEFT JOIN PAYCODE P ON
	P.PAYCODE = PD.DETCODE
	AND P.CO = RD.CO
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.EMPEONPREFERRED.EPAYHIST PH
	ON PH.TRANS = PD.TRANS
LEFT JOIN EMPLOYEE EMP
	ON TRIM(EMP.CO)||TRIM(EMP.CAREGIVER_ID) = TRIM(PH.CO)||TRIM(PH.ID);
	
END;

 EOT
}

