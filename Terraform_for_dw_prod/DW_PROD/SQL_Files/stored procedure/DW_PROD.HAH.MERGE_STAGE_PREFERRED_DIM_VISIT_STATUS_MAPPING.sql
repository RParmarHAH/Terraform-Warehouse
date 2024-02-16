CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_PREFERRED_DIM_VISIT_STATUS_MAPPING()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result varchar(1000);
BEGIN
    MERGE INTO HAH.DIM_VISIT_STATUS_MAPPING TGT 
USING STAGE.PREFERRED_DIM_VISIT_STATUS_MAPPING STAGE 
ON TGT.VISIT_STATUS_KEY = STAGE.VISIT_STATUS_KEY
WHEN MATCHED THEN 
UPDATE SET 
    TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.DERIVED_DISC_STATUS= STAGE.DERIVED_DISC_STATUS
   ,TGT.DISC_SCHEDULE_STATUS= STAGE.DISC_SCHEDULE_STATUS
   ,TGT.DISC_VISIT_STATUS= STAGE.DISC_VISIT_STATUS
   ,TGT.DISC_INVOICE_STATUS= STAGE.DISC_INVOICE_STATUS
   ,TGT.DISC_PAYROLL_STATUS= STAGE.DISC_PAYROLL_STATUS
   ,TGT.SCHEDULE_STATUS_CODE= STAGE.SCHEDULE_STATUS_CODE
   ,TGT.SCHEDULE_STATUS_NAME= STAGE.SCHEDULE_STATUS_NAME
   ,TGT.SCHEDULE_STATUS_DESCRIPTION= STAGE.SCHEDULE_STATUS_DESCRIPTION
   ,TGT.VISIT_STATUS_CODE= STAGE.VISIT_STATUS_CODE
   ,TGT.VISIT_STATUS_NAME= STAGE.VISIT_STATUS_NAME
   ,TGT.VISIT_STATUS_DESCRIPTION= STAGE.VISIT_STATUS_DESCRIPTION
   ,TGT.INVOICE_STATUS_CODE= STAGE.INVOICE_STATUS_CODE
   ,TGT.INVOICE_STATUS_NAME= STAGE.INVOICE_STATUS_NAME
   ,TGT.INVOICE_STATUS_DESCRIPTION= STAGE.INVOICE_STATUS_DESCRIPTION
   ,TGT.PAYROLL_STATUS_CODE= STAGE.PAYROLL_STATUS_CODE
   ,TGT.PAYROLL_STATUS_NAME= STAGE.PAYROLL_STATUS_NAME
   ,TGT.PAYROLL_STATUS_DESCRIPTION= STAGE.PAYROLL_STATUS_DESCRIPTION
   ,TGT.CONFIRMED_FLAG= STAGE.CONFIRMED_FLAG
   ,TGT.CONSISTENT_FLAG= STAGE.CONSISTENT_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
    VISIT_STATUS_KEY
   ,SOURCE_SYSTEM_ID
   ,SYSTEM_CODE
   ,DERIVED_DISC_STATUS
   ,DISC_SCHEDULE_STATUS
   ,DISC_VISIT_STATUS
   ,DISC_INVOICE_STATUS
   ,DISC_PAYROLL_STATUS
   ,SCHEDULE_STATUS_CODE
   ,SCHEDULE_STATUS_NAME
   ,SCHEDULE_STATUS_DESCRIPTION
   ,VISIT_STATUS_CODE
   ,VISIT_STATUS_NAME
   ,VISIT_STATUS_DESCRIPTION
   ,INVOICE_STATUS_CODE
   ,INVOICE_STATUS_NAME
   ,INVOICE_STATUS_DESCRIPTION
   ,PAYROLL_STATUS_CODE
   ,PAYROLL_STATUS_NAME
   ,PAYROLL_STATUS_DESCRIPTION
   ,CONFIRMED_FLAG
   ,CONSISTENT_FLAG
) 
VALUES (
    STAGE.VISIT_STATUS_KEY
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.SYSTEM_CODE
   ,STAGE.DERIVED_DISC_STATUS
   ,STAGE.DISC_SCHEDULE_STATUS
   ,STAGE.DISC_VISIT_STATUS
   ,STAGE.DISC_INVOICE_STATUS
   ,STAGE.DISC_PAYROLL_STATUS
   ,STAGE.SCHEDULE_STATUS_CODE
   ,STAGE.SCHEDULE_STATUS_NAME
   ,STAGE.SCHEDULE_STATUS_DESCRIPTION
   ,STAGE.VISIT_STATUS_CODE
   ,STAGE.VISIT_STATUS_NAME
   ,STAGE.VISIT_STATUS_DESCRIPTION
   ,STAGE.INVOICE_STATUS_CODE
   ,STAGE.INVOICE_STATUS_NAME
   ,STAGE.INVOICE_STATUS_DESCRIPTION
   ,STAGE.PAYROLL_STATUS_CODE
   ,STAGE.PAYROLL_STATUS_NAME
   ,STAGE.PAYROLL_STATUS_DESCRIPTION
   ,STAGE.CONFIRMED_FLAG
   ,STAGE.CONSISTENT_FLAG
);

SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Inserted &'' ,"number of rows updated", ''Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';