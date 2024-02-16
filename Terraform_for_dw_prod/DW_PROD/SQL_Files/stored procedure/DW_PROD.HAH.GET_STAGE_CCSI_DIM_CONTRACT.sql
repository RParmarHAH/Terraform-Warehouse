CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_CCSI_DIM_CONTRACT("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
        var sql = `
    --*****************************************************************************************************************************
-- NAME:  CCSI_DIM_BRANCH
--
-- PURPOSE: Creates one row per BRANCH according to CCSI
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/25/2021  JASHVANT PATEL        Initial development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CCSI_DIM_CONTRACT
WITH BILLABLE_RAW AS        -------- LOGIC FOR BILLABLE FLAG
(
	SELECT DISTINCT  UPPER (TRIM (CONTRACT_NO)) AS CONTRACT_NO 
	,CASE WHEN COUNT (DISTINCT PAY_EMPLOYEE) > 1 THEN                                  
		CASE WHEN PAY_EMPLOYEE IN (''Y'') OR PAY_EMPLOYEE IN (''N'') THEN TRUE END
		WHEN 	COUNT (DISTINCT PAY_EMPLOYEE) = 1 THEN 
		CASE WHEN PAY_EMPLOYEE IN (''Y'') THEN TRUE 
		 WHEN PAY_EMPLOYEE IN (''N'') THEN FALSE END 
	END AS BILLABLE_FLAG
			FROM DISC_PROD.CCSI.RAWVRFP 
	WHERE CONTRACT_NO IS NOT NULL 
	GROUP BY CONTRACT_NO ,PAY_EMPLOYEE
	ORDER BY 1
)
, BILLABLE AS 
(
	SELECT CONTRACT_NO , BILLABLE_FLAG,
	ROW_NUMBER() OVER (PARTITION BY CONTRACT_NO ORDER BY BILLABLE_FLAG DESC) AS ROW_NO
	FROM BILLABLE_RAW
)
SELECT DISTINCT 
 MD5( ''CCSI'' || B.CONTRACT_NO || ''-'' || ''CCSI'') AS CONTRACT_KEY ,
 B.CONTRACT_NO AS  CONTRACT_CODE,  
''CCSI'' AS SYSTEM_CODE,
8 AS SOURCE_SYSTEM_ID,
B.CONTRACT_NO AS CONTRACT_NAME,
NULL AS  SERVICE_CODE_ID,
NULL AS SERVICE_KEY,                                 
NULL AS DEFAULT_BILL_CODE,
NULL AS PAYROLL_CODE,
''HC'' AS REVENUE_CATEGORY,
''HC'' AS REVENUE_SUBCATEGORY_CODE,
''HC'' AS REVENUE_SUBCATEGORY_NAME,
''HC'' AS PAYOR_CODE,
''HC - Home Care'' AS PAYOR_DESCRIPTION,
''HC'' AS SERVICE_LINE_CODE,
''HC'' AS SERVICE_LINE_DESCRIPTION,
''IL'' AS CONTRACT_STATE_CODE,
''1HR'' AS TIME_TRANSLATION_CODE,
1 AS TIME_TRANSLATION_DIVIDER,
NULL AS PAY_TRAVELS_CODE,
NULL AS MILEAGE_FLAG,
TRUE AS PAYABLE_FLAG,
B.BILLABLE_FLAG,
FALSE AS BILLED_BY_QUARTER_HOURS,
FALSE AS BILLED_BY_HALF_HOURS,
 	  TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
      TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
	  
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_TASK_KEY,
        
	  
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_INSERTED_TASK_KEY,
        
	  convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	  CURRENT_USER as ETL_INSERTED_BY ,
	  convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	  CURRENT_USER as ETL_LAST_UPDATED_BY,
	  0 as ETL_DELETED_FLAG,
	  0 as ETL_INFERRED_MEMBER_FLAG
FROM DISC_PROD.CCSI.RAWVRFP  R
JOIN BILLABLE B ON UPPER (TRIM (R.CONTRACT_NO)) = B.CONTRACT_NO 
WHERE R.CONTRACT_NO IS NOT NULL
AND ROW_NO IN (1)
`;
          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          ';