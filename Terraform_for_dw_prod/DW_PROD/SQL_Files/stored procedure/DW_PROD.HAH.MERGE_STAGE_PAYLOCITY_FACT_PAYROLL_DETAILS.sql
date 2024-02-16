CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_PAYLOCITY_FACT_PAYROLL_DETAILS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    MERGE INTO HAH.FACT_PAYROLL_DETAILS TGT USING STAGE.PAYLOCITY_FACT_PAYROLL_DETAILS STAGE 
ON TGT.PAYROLL_DETAIL_KEY = STAGE.PAYROLL_DETAIL_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.PAYROLL_KEY= STAGE.PAYROLL_KEY
   ,TGT.REPORT_DATE= STAGE.REPORT_DATE
   ,TGT.EMPLOYEE_KEY= STAGE.EMPLOYEE_KEY
   ,TGT.BRANCH_KEY= STAGE.BRANCH_KEY
   ,TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.PAYROLL_DATE= STAGE.PAYROLL_DATE
   ,TGT.EMPLOYEE_ID= STAGE.EMPLOYEE_ID
   ,TGT.BRANCH_NAME= STAGE.BRANCH_NAME
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.PAY_PERIOD_START_DATE= STAGE.PAY_PERIOD_START_DATE
   ,TGT.PAY_PERIOD_END_DATE= STAGE.PAY_PERIOD_END_DATE
   ,TGT.CHECK_NUMBER= STAGE.CHECK_NUMBER
   ,TGT.PAY_CODE= STAGE.PAY_CODE
   ,TGT.PAY_CODE_DESCRIPTION= STAGE.PAY_CODE_DESCRIPTION
   ,TGT.PAY_CODE_TYPE= STAGE.PAY_CODE_TYPE
   ,TGT.PAY_CODE_TYPE_DESCRIPTION= STAGE.PAY_CODE_TYPE_DESCRIPTION
   ,TGT.PAY_CODE_CATEGORY= STAGE.PAY_CODE_CATEGORY
   ,TGT.NUMBER_OF_UNITS= STAGE.NUMBER_OF_UNITS
   ,TGT.UNIT_TYPE_CODE= STAGE.UNIT_TYPE_CODE
   ,TGT.UNIT_TYPE_DESCRIPTION= STAGE.UNIT_TYPE_DESCRIPTION
   ,TGT.RATE= STAGE.RATE
   ,TGT.AMOUNT= STAGE.AMOUNT
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    PAYROLL_DETAIL_KEY
   ,PAYROLL_KEY
   ,REPORT_DATE
   ,EMPLOYEE_KEY
   ,BRANCH_KEY
   ,SOURCE_SYSTEM_ID
   ,PAYROLL_DATE
   ,EMPLOYEE_ID
   ,BRANCH_NAME
   ,SYSTEM_CODE
   ,PAY_PERIOD_START_DATE
   ,PAY_PERIOD_END_DATE
   ,CHECK_NUMBER
   ,PAY_CODE
   ,PAY_CODE_DESCRIPTION
   ,PAY_CODE_TYPE
   ,PAY_CODE_TYPE_DESCRIPTION
   ,PAY_CODE_CATEGORY
   ,NUMBER_OF_UNITS
   ,UNIT_TYPE_CODE
   ,UNIT_TYPE_DESCRIPTION
   ,RATE
   ,AMOUNT
   ,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_DATE
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
) 
VALUES (
    STAGE.PAYROLL_DETAIL_KEY
   ,STAGE.PAYROLL_KEY
   ,STAGE.REPORT_DATE
   ,STAGE.EMPLOYEE_KEY
   ,STAGE.BRANCH_KEY
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.PAYROLL_DATE
   ,STAGE.EMPLOYEE_ID
   ,STAGE.BRANCH_NAME
   ,STAGE.SYSTEM_CODE
   ,STAGE.PAY_PERIOD_START_DATE
   ,STAGE.PAY_PERIOD_END_DATE
   ,STAGE.CHECK_NUMBER
   ,STAGE.PAY_CODE
   ,STAGE.PAY_CODE_DESCRIPTION
   ,STAGE.PAY_CODE_TYPE
   ,STAGE.PAY_CODE_TYPE_DESCRIPTION
   ,STAGE.PAY_CODE_CATEGORY
   ,STAGE.NUMBER_OF_UNITS
   ,STAGE.UNIT_TYPE_CODE
   ,STAGE.UNIT_TYPE_DESCRIPTION
   ,STAGE.RATE
   ,STAGE.AMOUNT
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