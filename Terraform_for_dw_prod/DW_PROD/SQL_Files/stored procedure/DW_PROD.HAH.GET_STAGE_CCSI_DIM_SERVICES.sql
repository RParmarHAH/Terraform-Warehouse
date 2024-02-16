CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_CCSI_DIM_SERVICES("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
--*****************************************************************************************************************************
-- NAME: CCSI DIM SERVICES 
--
-- PURPOSE: Populates Stage DIM SERVICES for CCSI
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 11/08/23	   SANKET JAIN		 Initial Development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CCSI_DIM_SERVICES 

WITH CTE AS ( 
SELECT DISTINCT  
MD5(''CCSI'' || ''-'' || RAW.SERVICE_TYPE   || ''-'' || ''CCSI'') AS SERVICE_KEY,
''8'' AS SOURCE_SYSTEM_ID,
''CCSI'' AS SYSTEM_CODE,
RAW.SERVICE_TYPE AS SERVICE_CODE,
RAW.SERVICE_TYPE AS SERVICE_DESCRIPTION,
NULL  AS SERVICE_TYPE ,
NULL AS SERVICE_RATE_TYPE,
''HC'' AS REVENUE_CATEGORY ,
''HC'' AS REVENUE_SUBCATEGORY_CODE,
''HOME CARE'' AS REVENUE_SUBCATEGORY_NAME,
TRUE AS ACTIVE_FLAG
FROM DISC_PROD.CCSI.RAWVRFP RAW WHERE RAW.SERVICE_TYPE IS NOT NULL) SELECT *, :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
        CURRENT_USER as ETL_INSERTED_BY,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
        CURRENT_USER as ETL_LAST_UPDATED_BY,
        0 AS ETL_DELETED_FLAG FROM CTE;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
RETURN return_result;

END;

';