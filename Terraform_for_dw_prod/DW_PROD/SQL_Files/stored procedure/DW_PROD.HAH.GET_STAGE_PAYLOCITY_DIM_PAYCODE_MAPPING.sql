CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_PAYLOCITY_DIM_PAYCODE_MAPPING("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result varchar(1000);
BEGIN

--*****************************************************************************************************************************
-- NAME: PAYLOCITY_DIM_PAYCODE_MAPPING
--
-- PURPOSE: Creates one row for each database (DB), paycode and assigns a paycode category according to Great Plains
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR                NOTES:
-- ----------		----------------- 	  -------------------------------------------------------------------------------------        
-- 08/02/2022		Aditya Shukla 		  Initial Development
--*****************************************************************************************************************************
--

INSERT OVERWRITE INTO STAGE.PAYLOCITY_DIM_PAYCODE_MAPPING
WITH paycode_usage_dates AS (
	SELECT DISTINCT ''10'' AS Source_System_ID,
	COMPANYID AS System_Code, --, E.WORK_STATE AS State_Code,
	UPPER(trim(psd.DETCODE)) AS Pay_Code,
	UPPER(TRIM(psd.DET)) AS Code_Types,
	MIN(psd.CHECKDATE)::DATE AS First_Used_Date,
	MAX(psd.CHECKDATE)::DATE AS Most_Recent_Used_Date,
	CAST(COUNT(DISTINCT psd.EMPLOYEEID) AS INTEGER) AS Number_Employees_Used
FROM DISC_PROD.PAYLOCITY.PAY_STATEMENT_DETAILS psd
GROUP BY upper(trim(psd.DETCODE)),COMPANYID, UPPER(TRIM(psd.DET))
) --SELECT * FROM paycode_usage_dates WHERE Pay_Code = ''REIMB'';
SELECT DISTINCT
	MD5(''10'' || COMPANYID || psd.DETCODE || psd.DET || ''-'' || ''PAYLOCITY'' )AS PAYCODE_MAPPING_KEY,
	''10'' AS SOURCE_SYSTEM_ID,
	COMPANYID AS SYSTEM_CODE,
	NULL AS STATE_CODE,
	DETCODE AS PAY_CODE,
	NULL AS PAY_CODE_DESCRIPTION,
	DET AS PAY_CODE_TYPE,
	NULL AS PAY_CODE_CATEGORY, --NULL
	NULL AS FINANCE_CATEGORY, -- NULL
	NULL AS REVENUE_CATEGORY, -- NULL
	NULL AS REVENUE_SUBCATEGORY_CODE, --NULL
	NULL AS REVENUE_SUBCATEGORY_NAME, --NULL
	pud.First_Used_Date AS FIRST_USED_DATE,
	pud.Most_Recent_Used_Date AS MOST_RECENT_USED_DATE,
	pud.Number_Employees_Used AS NUMBER_EMPLOYEES_USED,
	CAST(CASE WHEN DATEADD(''YEAR'', 1, pud.Most_Recent_Used_Date) >= CURRENT_DATE THEN ''TRUE'' ELSE FALSE END AS Boolean) AS ACTIVE_FLAG,
	NULL AS ADMIN_PAY_RATE_FLAG, -- null paycode_admin_usage -- FIELD_WORKER_FLAG CAN USE TO IDENTIFY ADMIN AND FIELD WORKER --null
	NULL AS FIELD_PAY_RATE_FLAG, -- null paycode_FIELD_usage
	NULL AS INCLUDE_SALARY_PAYRATE_CALC_FLAG,
	NULL AS INCLUDE_FULL_TIME_HOURS_CALC_FLAG, --SALARY_HOURS_USAGE
	
   :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
   :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
       
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY ,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY,
	0 as ETL_DELETED_FLAG
FROM DISC_PROD.PAYLOCITY.PAY_STATEMENT_DETAILS psd
LEFT OUTER JOIN paycode_usage_dates pud
	ON upper(trim(pud.PAY_CODE)) = upper(trim(psd.DETCODE))
	AND upper(trim(pud.System_Code)) = upper(trim(psd.COMPANYID)) AND pud.Code_Types =UPPER(TRIM(psd.DET))
WHERE PSD.COMPANYID NOT IN (''33978'');

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';