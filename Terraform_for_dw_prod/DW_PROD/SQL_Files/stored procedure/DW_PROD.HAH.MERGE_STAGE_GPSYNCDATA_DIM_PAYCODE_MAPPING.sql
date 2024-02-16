CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_GPSYNCDATA_DIM_PAYCODE_MAPPING()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    MERGE INTO HAH.DIM_PAYCODE_MAPPING TGT 
USING STAGE.GPSYNCDATA_DIM_PAYCODE_MAPPING STAGE 
ON TGT.PAYCODE_MAPPING_KEY = STAGE.PAYCODE_MAPPING_KEY
WHEN MATCHED THEN 
UPDATE SET 
   TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.STATE_CODE= STAGE.STATE_CODE
   ,TGT.PAY_CODE= STAGE.PAY_CODE
   ,TGT.PAY_CODE_DESCRIPTION= STAGE.PAY_CODE_DESCRIPTION
   ,TGT.PAY_CODE_TYPE= STAGE.PAY_CODE_TYPE
   ,TGT.PAY_CODE_CATEGORY= STAGE.PAY_CODE_CATEGORY
   ,TGT.FINANCE_CATEGORY= STAGE.FINANCE_CATEGORY
   ,TGT.REVENUE_CATEGORY= STAGE.REVENUE_CATEGORY
   ,TGT.REVENUE_SUBCATEGORY_CODE= STAGE.REVENUE_SUBCATEGORY_CODE
   ,TGT.REVENUE_SUBCATEGORY_NAME= STAGE.REVENUE_SUBCATEGORY_NAME
   ,TGT.FIRST_USED_DATE= STAGE.FIRST_USED_DATE
   ,TGT.MOST_RECENT_USED_DATE= STAGE.MOST_RECENT_USED_DATE
   ,TGT.NUMBER_EMPLOYEES_USED= STAGE.NUMBER_EMPLOYEES_USED
   ,TGT.ACTIVE_FLAG= STAGE.ACTIVE_FLAG
   ,TGT.ADMIN_PAY_RATE_FLAG= STAGE.ADMIN_PAY_RATE_FLAG
   ,TGT.FIELD_PAY_RATE_FLAG= STAGE.FIELD_PAY_RATE_FLAG
   ,TGT.INCLUDE_SALARY_PAYRATE_CALC_FLAG=STAGE.INCLUDE_SALARY_PAYRATE_CALC_FLAG
   ,TGT.INCLUDE_FULL_TIME_HOURS_CALC_FLAG=STAGE.INCLUDE_FULL_TIME_HOURS_CALC_FLAG
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
   
WHEN NOT MATCHED THEN 
INSERT ( 
  PAYCODE_MAPPING_KEY
   ,SOURCE_SYSTEM_ID
   ,SYSTEM_CODE
   ,STATE_CODE
   ,PAY_CODE
   ,PAY_CODE_DESCRIPTION
   ,PAY_CODE_TYPE
   ,PAY_CODE_CATEGORY
   ,FINANCE_CATEGORY
   ,REVENUE_CATEGORY
   ,REVENUE_SUBCATEGORY_CODE
   ,REVENUE_SUBCATEGORY_NAME
   ,FIRST_USED_DATE
   ,MOST_RECENT_USED_DATE
   ,NUMBER_EMPLOYEES_USED
   ,ACTIVE_FLAG
   ,ADMIN_PAY_RATE_FLAG
   ,FIELD_PAY_RATE_FLAG
   ,INCLUDE_SALARY_PAYRATE_CALC_FLAG
   ,INCLUDE_FULL_TIME_HOURS_CALC_FLAG
   ,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_DATE
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
  
) 
VALUES (
   STAGE.PAYCODE_MAPPING_KEY
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.SYSTEM_CODE
   ,STAGE.STATE_CODE
   ,STAGE.PAY_CODE
   ,STAGE.PAY_CODE_DESCRIPTION
   ,STAGE.PAY_CODE_TYPE
   ,STAGE.PAY_CODE_CATEGORY
   ,STAGE.FINANCE_CATEGORY
   ,STAGE.REVENUE_CATEGORY
   ,STAGE.REVENUE_SUBCATEGORY_CODE
   ,STAGE.REVENUE_SUBCATEGORY_NAME
   ,STAGE.FIRST_USED_DATE
   ,STAGE.MOST_RECENT_USED_DATE
   ,STAGE.NUMBER_EMPLOYEES_USED
   ,STAGE.ACTIVE_FLAG
   ,STAGE.ADMIN_PAY_RATE_FLAG
   ,STAGE.FIELD_PAY_RATE_FLAG
   ,STAGE.INCLUDE_SALARY_PAYRATE_CALC_FLAG
   ,STAGE.INCLUDE_FULL_TIME_HOURS_CALC_FLAG
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