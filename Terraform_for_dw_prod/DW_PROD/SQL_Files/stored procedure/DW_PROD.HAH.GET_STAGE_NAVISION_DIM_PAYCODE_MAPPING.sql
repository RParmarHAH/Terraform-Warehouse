CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_NAVISION_DIM_PAYCODE_MAPPING("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

--*****************************************************************************************************************************
-- NAME: NAVISION_DIM_PAYCODE_MAPPING
--
-- PURPOSE: Creates one row per PAYCODE as per Navision
--
-- DEVELOPMENT LOG:
	
-- DATE        AUTHOR                				NOTES:
-- --------    -------------------------------   	--------------------------------------------------------------------------
-- 10/12/22    Aditya Shukla / Jigar Prajapati      Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.NAVISION_DIM_PAYCODE_MAPPING

WITH PAYCODE_USAGE_DATES AS (
	SELECT DISTINCT 
		21 AS SOURCE_SYSTEM_ID,
		PAYROLL_CONTROL_NAME,
		PAYROLL_CONTROL_TYPE, 
		COUNTY,
		MIN(PAY_DATE) AS FIRST_USED_DATE,
		MAX(PAY_DATE) AS MOST_RECENT_USED_DATE,
		COUNT(DISTINCT EMPLOYEE_NO_) AS NUMBER_EMPLOYEES_USED
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY
	GROUP BY 2, 3, 4
)
SELECT DISTINCT
	MD5(21 || PLE.COUNTY || COALESCE(PLE.PAYROLL_POSTING_GROUP, ''UNKNOWN'') || PLE.PAYROLL_CONTROL_TYPE || PLE.PAYROLL_CONTROL_NAME || ''-'' || ''NAVISION'') AS PAYCODE_MAPPING_KEY,
	21 AS SOURCE_SYSTEM_ID,
	''NAVISION'' AS SYSTEM_CODE,
	PLE.COUNTY AS STATE_CODE,
	UPPER(COALESCE(PAYROLL_POSTING_GROUP, PLE.PAYROLL_CONTROL_NAME)) AS PAY_CODE,
	NULL AS PAY_CODE_DESCRIPTION,
	PLE.PAYROLL_CONTROL_TYPE AS PAY_CODE_TYPE,
	CASE WHEN UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%VAC%'' THEN ''PTO''
            WHEN UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%HOLID%'' THEN ''HOLIDAY''
            WHEN UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%TRAIN%'' THEN ''TRAINING''
            WHEN UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%SICK%'' THEN ''SICK''
            WHEN UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%UNION%'' OR UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%DUE%'' THEN ''UNION''
            WHEN UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%OVER%TIME%'' THEN ''OVERTIME''
            WHEN UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%MILE%'' THEN ''TRAVEL TIME & MILEAGE''
            WHEN UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%HEALTH%INS%'' OR UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%DENTAL%'' OR UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%VISION%'' OR UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%DISABILITY%'' OR UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%LIFE%INS%'' OR UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%MEDIC%INS%'' OR UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%401%K%'' OR UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%CRITIC%I%'' OR UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%DEDUCT%'' OR UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%GARNISH%'' OR UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%ACCIDENT%'' OR UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%LOAN%'' THEN ''BENEFITS & DEDUCTIONS''
            WHEN UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%REIMB%'' THEN ''REIMBURSEMENT''
            WHEN UPPER( PLE.PAYROLL_CONTROL_NAME) LIKE ''%TAX%'' OR (UPPER(PLE.PAYROLL_CONTROL_NAME) LIKE ''%FICA%'' OR UPPER(PLE.PAYROLL_POSTING_GROUP) LIKE ''%FICA%'') THEN ''TAX''
            WHEN UPPER( PLE.PAYROLL_POSTING_GROUP) LIKE ''%GARN%'' THEN ''BENEFITS & DEDUCTIONS''
            WHEN UPPER( PLE.PAYROLL_POSTING_GROUP) LIKE ''%UNION%'' THEN ''UNION''
       END AS PAY_CODE_CATEGORY,
	NULL AS FINANCE_CATEGORY,
	NULL AS REVENUE_CATEGORY,
	NULL AS REVENUE_SUBCATEGORY_CODE,
	NULL AS REVENUE_SUBCATEGORY_NAME,
	PUD.FIRST_USED_DATE AS FIRST_USED_DATE,
	PUD.MOST_RECENT_USED_DATE AS MOST_RECENT_USED_DATE,
	PUD.NUMBER_EMPLOYEES_USED AS NUMBER_EMPLOYEES_USED,
	CASE 
		WHEN DATEADD(''YEAR'', 1, PUD.MOST_RECENT_USED_DATE) >= CURRENT_DATE 
		THEN TRUE 
		ELSE FALSE 
	END AS ACTIVE_FLAG,
	NULL AS ADMIN_PAY_RATE_FLAG,
	NULL AS FIELD_PAY_RATE_FLAG,
	NULL AS INCLUDE_SALARY_PAYRATE_CALC_FLAG,
	NULL AS INCLUDE_FULL_TIME_HOURS_CALC_FLAG,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
		CURRENT_USER AS ETL_INSERTED_BY,
		CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
		CURRENT_USER AS ETL_LAST_UPDATED_BY,
		FALSE AS ETL_DELETED_FLAG
FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
LEFT JOIN PAYCODE_USAGE_DATES PUD 
	ON PUD.SOURCE_SYSTEM_ID = 21 AND PUD.PAYROLL_CONTROL_NAME = PLE.PAYROLL_CONTROL_NAME AND PUD.COUNTY = PLE.COUNTY AND PUD.PAYROLL_CONTROL_TYPE = PLE.PAYROLL_CONTROL_TYPE;
END;
';