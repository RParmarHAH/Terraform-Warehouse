CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_SANDATAIMPORT_FACT_EVV_VISIT_EXCEPTIONS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    MERGE INTO HAH.FACT_EVV_VISIT_EXCEPTIONS TGT 
USING STAGE.SANDATAIMPORT_FACT_EVV_VISIT_EXCEPTIONS STAGE 
ON TGT.VISIT_KEY = STAGE.VISIT_KEY AND TGT.EXCEPTION_REASON_CODE = STAGE.EXCEPTION_REASON_CODE
WHEN MATCHED THEN 
UPDATE SET 
TGT.REPORT_DATE= STAGE.REPORT_DATE,  
TGT.BRANCH_KEY= STAGE.BRANCH_KEY,
TGT.CLIENT_KEY= STAGE.CLIENT_KEY,
TGT.CONTRACT_KEY= STAGE.CONTRACT_KEY,
TGT.EMPLOYEE_KEY= STAGE.EMPLOYEE_KEY, 
TGT.SUPERVISOR_KEY= STAGE.SUPERVISOR_KEY,
TGT.SERVICE_DATE= STAGE.SERVICE_DATE,
TGT.CLIENT_NUMBER= STAGE.CLIENT_NUMBER,
TGT.CONTRACT_CODE= STAGE.CONTRACT_CODE,
TGT.EMPLOYEE_ID= STAGE.EMPLOYEE_ID,
TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE,
TGT.EXCEPTION_REASON_DESCRIPTION= STAGE.EXCEPTION_REASON_DESCRIPTION
,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
VISIT_KEY,
EXCEPTION_REASON_CODE,
REPORT_DATE,  
BRANCH_KEY,
CLIENT_KEY,
CONTRACT_KEY,
EMPLOYEE_KEY, 
SUPERVISOR_KEY,
SERVICE_DATE,
CLIENT_NUMBER,
CONTRACT_CODE,
EMPLOYEE_ID,
SYSTEM_CODE,
EXCEPTION_REASON_DESCRIPTION
,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_DATE
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
) 
VALUES (
STAGE.VISIT_KEY,
STAGE.EXCEPTION_REASON_CODE,
STAGE.REPORT_DATE,  
STAGE.BRANCH_KEY,
STAGE.CLIENT_KEY,
STAGE.CONTRACT_KEY,
STAGE.EMPLOYEE_KEY, 
STAGE.SUPERVISOR_KEY,
STAGE.SERVICE_DATE,
STAGE.CLIENT_NUMBER,
STAGE.CONTRACT_CODE,
STAGE.EMPLOYEE_ID,
STAGE.SYSTEM_CODE,
STAGE.EXCEPTION_REASON_DESCRIPTION
,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Insrted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
    ';