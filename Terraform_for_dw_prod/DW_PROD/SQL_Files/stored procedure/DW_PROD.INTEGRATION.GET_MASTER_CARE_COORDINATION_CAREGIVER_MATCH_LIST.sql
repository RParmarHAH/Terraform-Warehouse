CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.GET_MASTER_CARE_COORDINATION_CAREGIVER_MATCH_LIST("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    INSERT OVERWRITE INTO APP_DB_PROD.CARE_COORDINATION.CAREGIVER_MATCH_LIST
    WITH PRIORITY_SOURCE AS (
     SELECT SOURCE,ID,EMPLOYEE_KEY,
     ROW_NUMBER() OVER (PARTITION BY CLUSTER_ID ORDER BY IFF(SOURCE = ''CARE_COORDINATION'',1,0) DESC) AS SRC_PRI, CLUSTER_ID
     FROM DW_PROD.INTEGRATION.CARE_COORDINATION_CAREGIVER_DEDUPE
     WHERE CLUSTER_ID IS NOT NULL
    )
    ,NEW AS (
     SELECT * FROM PRIORITY_SOURCE WHERE SRC_PRI >1
     )
    ,OLD AS (
    SELECT * FROM PRIORITY_SOURCE WHERE SRC_PRI =1
    ) --SELECT * FROM OLD;
    select O.SOURCE AS SOURCE,O.EMPLOYEE_KEY AS GATOR_EMPLOYEE_KEY,R.SOURCE AS ORIGINAL_SOURCE,R.EMPLOYEE_KEY AS DW_EMPLOYEE_KEY,
     CURRENT_DATE AS ETL_INSERTED_DATE
    FROM DW_PROD.INTEGRATION.CARE_COORDINATION_CAREGIVER_DEDUPE R
    LEFT JOIN OLD O ON O.CLUSTER_ID = R.CLUSTER_ID
    WHERE R.CLUSTER_ID IS NOT NULL;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';