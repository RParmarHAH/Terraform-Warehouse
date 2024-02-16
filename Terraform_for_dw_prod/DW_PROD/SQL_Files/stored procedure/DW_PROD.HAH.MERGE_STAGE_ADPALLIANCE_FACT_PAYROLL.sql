CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_ADPALLIANCE_FACT_PAYROLL()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

MERGE INTO HAH.FACT_PAYROLL TGT 
USING STAGE.ADPALLIANCE_FACT_PAYROLL STAGE 
ON TGT.PAYROLL_KEY = STAGE.PAYROLL_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.REPORT_DATE= STAGE.REPORT_DATE
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
   ,TGT.PAY_HOURS= STAGE.PAY_HOURS
   ,TGT.SERVICE_HOURS= STAGE.SERVICE_HOURS
   ,TGT.OVERTIME_HOURS= STAGE.OVERTIME_HOURS
   ,TGT.NON_SERVICE_UNITS= STAGE.NON_SERVICE_UNITS
   ,TGT.SICK_HOURS= STAGE.SICK_HOURS
   ,TGT.VACATION_HOURS= STAGE.VACATION_HOURS
   ,TGT.PAY_RATE= STAGE.PAY_RATE
   ,TGT.OVERTIME_RATE= STAGE.OVERTIME_RATE
   ,TGT.GROSS_PAY_AMOUNT= STAGE.GROSS_PAY_AMOUNT
   ,TGT.SERVICE_PAY_AMOUNT= STAGE.SERVICE_PAY_AMOUNT
   ,TGT.OVERTIME_PAY_AMOUNT= STAGE.OVERTIME_PAY_AMOUNT
   ,TGT.NON_SERVICE_PAY_AMOUNT= STAGE.NON_SERVICE_PAY_AMOUNT
   ,TGT.TAX_AMOUNT= STAGE.TAX_AMOUNT
   ,TGT.NET_PAY_AMOUNT= STAGE.NET_PAY_AMOUNT
   ,TGT.OTHER_DEDUCTIONS_AMOUNT= STAGE.OTHER_DEDUCTIONS_AMOUNT
   ,TGT.UNION_DUES_AMOUNT= STAGE.UNION_DUES_AMOUNT
   ,TGT.REINBURSMENT_AMOUNT= STAGE.REINBURSMENT_AMOUNT
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    PAYROLL_KEY
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
   ,PAY_HOURS
   ,SERVICE_HOURS
   ,OVERTIME_HOURS
   ,NON_SERVICE_UNITS
   ,SICK_HOURS
   ,VACATION_HOURS
   ,PAY_RATE
   ,OVERTIME_RATE
   ,GROSS_PAY_AMOUNT
   ,SERVICE_PAY_AMOUNT
   ,OVERTIME_PAY_AMOUNT
   ,NON_SERVICE_PAY_AMOUNT
   ,TAX_AMOUNT
   ,NET_PAY_AMOUNT
   ,OTHER_DEDUCTIONS_AMOUNT
   ,UNION_DUES_AMOUNT
   ,REINBURSMENT_AMOUNT
   ,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_DATE
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
) 
VALUES (
    STAGE.PAYROLL_KEY
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
   ,STAGE.PAY_HOURS
   ,STAGE.SERVICE_HOURS
   ,STAGE.OVERTIME_HOURS
   ,STAGE.NON_SERVICE_UNITS
   ,STAGE.SICK_HOURS
   ,STAGE.VACATION_HOURS
   ,STAGE.PAY_RATE
   ,STAGE.OVERTIME_RATE
   ,STAGE.GROSS_PAY_AMOUNT
   ,STAGE.SERVICE_PAY_AMOUNT
   ,STAGE.OVERTIME_PAY_AMOUNT
   ,STAGE.NON_SERVICE_PAY_AMOUNT
   ,STAGE.TAX_AMOUNT
   ,STAGE.NET_PAY_AMOUNT
   ,STAGE.OTHER_DEDUCTIONS_AMOUNT
   ,STAGE.UNION_DUES_AMOUNT
   ,STAGE.REINBURSMENT_AMOUNT
   ,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
);

END;
';