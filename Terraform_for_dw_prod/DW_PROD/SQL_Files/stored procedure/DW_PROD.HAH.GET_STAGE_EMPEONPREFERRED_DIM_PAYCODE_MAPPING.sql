CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_EMPEONPREFERRED_DIM_PAYCODE_MAPPING("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

--*****************************************************************************************************************************
-- NAME: EMPEONPREFERRED_DIM_PAYCODE_MAPPING
--
-- PURPOSE: Creates one row for each each database (DB), paycode and assigns a paycode category according TO EMPEON-PREFERRED
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR                					NOTES:
-- ----------		--------------------------------		-------------------------------------------------------------------
-- 18/10/2022		Aditya Shukla / Jigar Prajapati			Initial Development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.EMPEONPREFERRED_DIM_PAYCODE_MAPPING

WITH PAYCODES AS (
	SELECT DISTINCT 
		CO AS CO ,
		UPPER(TRIM(DCODE)) AS PAYCODE ,
		UPPER(TRIM(DESCRIPTION)) AS PAYCODE_DESCRIPTION,
		UPPER(TRIM(DEDTYPE)) AS PAYCODE_TYPE
	FROM DISC_PROD.EMPEONPREFERRED.CDED
	UNION
	SELECT DISTINCT 
		CO AS CO ,
		UPPER(TRIM(ECODE)) AS PAYCODE,
		UPPER(TRIM(DESCRIPTION)) AS PAYCODE_DESCRIPTION,
		UPPER(TRIM(EARNTYPE)) AS PAYCODE_TYPE
	FROM DISC_PROD.EMPEONPREFERRED.CEARN
	UNION 
	SELECT DISTINCT 
		NULL AS CO,
		UPPER(TRIM(TCODE)) AS PAYCODE,
		NULL AS DESCRIPTION,
		NULL AS PAYCODE_TYPE
	FROM DISC_PROD.EMPEONPREFERRED.ETAX
), -- SELECT DISTINCT PAYCODE, PAYCODE_TYPE, PAYCODE_DESCRIPTION FROM PAYCODES;
USAGE_DATES AS (
	SELECT DISTINCT
		UPPER(ED.DETCODE) AS PAY_CODE,
		ED.DET AS PAY_CODE_TYPE,
		MIN(EH.CHECKDATE)::DATE AS FIRST_USED_DATE,
		MAX(EH.CHECKDATE)::DATE AS MOST_RECENT_USED_DATE,
		COUNT(ED.TRANS) AS NUMBER_EMPLOYEES_USED
	FROM DISC_PROD.EMPEONPREFERRED.EPAYHISTDETAIL ED
	LEFT JOIN DISC_PROD.EMPEONPREFERRED.EPAYHIST EH 
		ON ED.TRANS = EH.TRANS
	GROUP BY 1, 2
)
SELECT DISTINCT 
	MD5(22 || PAYCODE || NVL(PAYCODE_TYPE, ''UNKNOWN'') || NVL(PAYCODE_DESCRIPTION, ''UNKNOWN'') || ''-'' || ''EMPEONPREFERRED'') AS PAYCODE_MAPPING_KEY,
	22 AS SOURCE_SYSTEM_ID,
	''EMPEONPREFERRED'' AS SYSTEM_CODE,
	''NY'' AS STATE_CODE,
	PAYCODE AS PAY_CODE,
	PAYCODE_DESCRIPTION AS PAY_CODE_DESCRIPTION,
	PAYCODE_TYPE AS PAY_CODE_TYPE,
	CASE 
		WHEN PAYCODE_DESCRIPTION LIKE ''%401%K%'' OR PAYCODE_DESCRIPTION LIKE ''%DENTAL%'' OR PAYCODE_DESCRIPTION LIKE ''%ACCIDENT%'' OR PAYCODE_DESCRIPTION LIKE ''%CRITIC%I%'' OR PAYCODE_DESCRIPTION LIKE ''%VISION%'' OR PAYCODE_DESCRIPTION LIKE ''%LOAN%'' OR PAYCODE_DESCRIPTION LIKE ''%FLEX%SPEND%'' OR PAYCODE_DESCRIPTION LIKE ''%DEDUCT%'' OR PAYCODE_DESCRIPTION LIKE ''%HEALTH%INS%'' OR PAYCODE_DESCRIPTION LIKE ''%INSUR%'' OR PAYCODE_DESCRIPTION LIKE ''%DISABILITY%'' OR PAYCODE_DESCRIPTION LIKE ''%UNITED%HEALTH%'' OR PAYCODE_DESCRIPTION LIKE ''%GARNISH%'' THEN ''Benefits & Deductions''
		WHEN PAYCODE_DESCRIPTION LIKE ''%ADVANCE%'' OR PAYCODE_DESCRIPTION LIKE ''%ADJ%'' OR PAYCODE_DESCRIPTION LIKE ''%REFUND%'' OR PAYCODE_DESCRIPTION LIKE ''%COVID%'' OR PAY_CODE_DESCRIPTION LIKE ''%SEVER%'' OR PAYCODE_DESCRIPTION LIKE ''%PREMIUM%'' THEN ''Adjustment''
		WHEN PAYCODE_DESCRIPTION LIKE ''%UNION%'' THEN ''Union''
		WHEN PAYCODE_DESCRIPTION LIKE ''%HOLID%'' THEN ''Holiday''
		WHEN PAYCODE_DESCRIPTION LIKE ''%SICK%'' THEN ''Sick''
		WHEN PAYCODE_DESCRIPTION LIKE ''%TRANS%'' OR PAYCODE_DESCRIPTION LIKE ''% RN %'' OR PAYCODE_DESCRIPTION LIKE ''%REGULAR%'' OR PAYCODE_DESCRIPTION LIKE ''%HOME%'' OR PAYCODE_DESCRIPTION LIKE ''%SERVICE%'' THEN ''Regular Pay''
		WHEN PAYCODE_DESCRIPTION LIKE ''%OVER%TIME%'' THEN ''Overtime''
		WHEN PAYCODE_DESCRIPTION LIKE ''%REGULAR%'' THEN ''Regular Pay''
		WHEN PAYCODE_DESCRIPTION LIKE ''%BONUS%'' THEN ''Bonus''
		WHEN PAYCODE_DESCRIPTION LIKE ''%VAC%'' OR PAYCODE_DESCRIPTION LIKE ''%PTO%'' OR PAYCODE_DESCRIPTION LIKE ''%BEREAV%'' OR PAYCODE_DESCRIPTION LIKE ''%PAID%TIME%OFF%'' THEN ''PTO''
		WHEN PAYCODE_DESCRIPTION LIKE ''%ON%CALL%'' THEN ''On-Call''
		WHEN PAYCODE_DESCRIPTION LIKE ''%SUPERV%'' THEN ''Supervisor''
		WHEN PAY_CODE_DESCRIPTION LIKE ''%TRAVEL%TIME%'' THEN ''Travel Time & Mileage''
		WHEN PAYCODE_DESCRIPTION LIKE ''%REIMB%'' THEN ''Reimbursement''
		WHEN PAYCODE_DESCRIPTION LIKE ''%TAX%'' THEN ''Tax''
	END AS PAY_CODE_CATEGORY,
	NULL AS FINANCE_CATEGORY,
	NULL AS REVENUE_CATEGORY,
	NULL AS REVENUE_SUBCATEGORY_CODE,
	NULL AS REVENUE_SUBCATEGORY_NAME,
	UD.FIRST_USED_DATE AS FIRST_USED_DATE,
	UD.MOST_RECENT_USED_DATE AS MOST_RECENT_USED_DATE,
	UD.NUMBER_EMPLOYEES_USED AS NUMBER_EMPLOYEES_USED,
	CASE 
		WHEN DATEADD(''YEAR'', 1, UD.MOST_RECENT_USED_DATE) >= CURRENT_DATE() THEN TRUE ELSE FALSE
	END AS ACTIVE_FLAG,
	NULL AS ADMIN_PAY_RATE_FLAG,
	NULL AS FIELD_PAY_RATE_FLAG,
	NULL AS INCLUDE_SALARY_PAYRATE_CALC_FLAG,
	NULL AS INCLUDE_FULL_TIME_HOURS_CALC_FLAG,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'',
		CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
		CURRENT_USER AS ETL_INSERTED_BY,
		convert_timezone(''UTC'',
		CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
		CURRENT_USER AS ETL_LAST_UPDATED_BY,
		FALSE AS ETL_DELETED_FLAG
FROM PAYCODES PC
LEFT JOIN USAGE_DATES UD
	ON UD.PAY_CODE = UPPER(PC.PAYCODE);
	
END;
';