CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_SANDATAIMPORT_FACT_ADMISSION()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result varchar(1000);
BEGIN
    MERGE INTO HAH.FACT_ADMISSION TGT
USING STAGE.SANDATAIMPORT_FACT_ADMISSION STAGE
ON TGT.CLIENT_ADMISSION_KEY = STAGE.CLIENT_ADMISSION_KEY
WHEN MATCHED THEN
UPDATE SET
   TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
   ,TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
   ,TGT.CLIENT_KEY= STAGE.CLIENT_KEY
   ,TGT.REFERRER_KEY= STAGE.REFERRER_KEY
   ,TGT.SERVICE_KEY= STAGE.SERVICE_KEY
   ,TGT.PARTNER_CONTRACT_KEY = STAGE.PARTNER_CONTRACT_KEY
   ,TGT.PRIMARY_DIAGNOSIS_KEY= STAGE.PRIMARY_DIAGNOSIS_KEY
   ,TGT.REFERRAL_DATE= STAGE.REFERRAL_DATE
   ,TGT.REFERRAL_INTAKE_BY_EMP_KEY= STAGE.REFERRAL_INTAKE_BY_EMP_KEY
   ,TGT.REFERRAL_ACCEPTED_SERVICES= STAGE.REFERRAL_ACCEPTED_SERVICES
   ,TGT.REFERRAL_CAMPAIGN= STAGE.REFERRAL_CAMPAIGN
   ,TGT.PREVIOUS_PROVIDER= STAGE.PREVIOUS_PROVIDER
   ,TGT.ADMISSION_DATE= STAGE.ADMISSION_DATE
   ,TGT.STATUS= STAGE.STATUS
   ,TGT.PRIMARY_DIAGNOSIS= STAGE.PRIMARY_DIAGNOSIS
   ,TGT.DIAGNOSIS_NOTES= STAGE.DIAGNOSIS_NOTES
   ,TGT.DISCHARGE_DATE= STAGE.DISCHARGE_DATE
   ,TGT.DISCHARGE_REASON= STAGE.DISCHARGE_REASON
   ,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
   ,TGT.ETL_INSERTED_TASK_KEY= STAGE.ETL_INSERTED_TASK_KEY
   ,TGT.ETL_INSERTED_DATE= STAGE.ETL_INSERTED_DATE
   ,TGT.ETL_INSERTED_BY= STAGE.ETL_INSERTED_BY
   ,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
   ,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
   ,TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG
WHEN NOT MATCHED THEN
INSERT (
    CLIENT_ADMISSION_KEY
   ,SOURCE_SYSTEM_ID
   ,SYSTEM_CODE
   ,CLIENT_KEY
   ,REFERRER_KEY
   ,SERVICE_KEY
   ,PARTNER_CONTRACT_KEY
   ,PRIMARY_DIAGNOSIS_KEY
   ,REFERRAL_DATE
   ,REFERRAL_INTAKE_BY_EMP_KEY
   ,REFERRAL_ACCEPTED_SERVICES
   ,REFERRAL_CAMPAIGN
   ,PREVIOUS_PROVIDER
   ,ADMISSION_DATE
   ,STATUS
   ,PRIMARY_DIAGNOSIS
   ,DIAGNOSIS_NOTES
   ,DISCHARGE_DATE
   ,DISCHARGE_REASON
   ,ETL_TASK_KEY
   ,ETL_INSERTED_TASK_KEY
   ,ETL_INSERTED_DATE
   ,ETL_INSERTED_BY
   ,ETL_LAST_UPDATED_DATE
   ,ETL_LAST_UPDATED_BY
   ,ETL_DELETED_FLAG
)
VALUES (
    STAGE.CLIENT_ADMISSION_KEY
   ,STAGE.SOURCE_SYSTEM_ID
   ,STAGE.SYSTEM_CODE
   ,STAGE.CLIENT_KEY
   ,STAGE.REFERRER_KEY
   ,STAGE.SERVICE_KEY
   ,STAGE.PARTNER_CONTRACT_KEY
   ,STAGE.PRIMARY_DIAGNOSIS_KEY
   ,STAGE.REFERRAL_DATE
   ,STAGE.REFERRAL_INTAKE_BY_EMP_KEY
   ,STAGE.REFERRAL_ACCEPTED_SERVICES
   ,STAGE.REFERRAL_CAMPAIGN
   ,STAGE.PREVIOUS_PROVIDER
   ,STAGE.ADMISSION_DATE
   ,STAGE.STATUS
   ,STAGE.PRIMARY_DIAGNOSIS
   ,STAGE.DIAGNOSIS_NOTES
   ,STAGE.DISCHARGE_DATE
   ,STAGE.DISCHARGE_REASON
   ,STAGE.ETL_TASK_KEY
   ,STAGE.ETL_INSERTED_TASK_KEY
   ,STAGE.ETL_INSERTED_DATE
   ,STAGE.ETL_INSERTED_BY
   ,STAGE.ETL_LAST_UPDATED_DATE
   ,STAGE.ETL_LAST_UPDATED_BY
   ,STAGE.ETL_DELETED_FLAG
);

SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Inserted &'' ,"number of rows updated", ''Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';