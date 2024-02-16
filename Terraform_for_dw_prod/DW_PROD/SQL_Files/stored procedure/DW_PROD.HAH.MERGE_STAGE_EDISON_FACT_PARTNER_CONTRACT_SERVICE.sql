CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_EDISON_FACT_PARTNER_CONTRACT_SERVICE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    RETURN_RESULT VARCHAR;
BEGIN
MERGE INTO DW_PROD.HAH.FACT_PARTNER_CONTRACT_SERVICE AS tgt
USING DW_PROD.STAGE.EDISON_FACT_PARTNER_CONTRACT_SERVICE AS src
ON tgt.PARTNER_CONTRACT_SERVICE_KEY=src.PARTNER_CONTRACT_SERVICE_KEY
WHEN MATCHED
THEN UPDATE SET
	  tgt.SOURCE_SYSTEM_ID=src.SOURCE_SYSTEM_ID
	, tgt.SYSTEM_CODE=src.SYSTEM_CODE
	, TGT.STATE=SRC.STATE
	, tgt.PARTNER_CONTRACT_KEY=src.PARTNER_CONTRACT_KEY
	, tgt.PARTNER_CODE=src.PARTNER_CODE
	, tgt.PARTNER_NAME=src.PARTNER_NAME
	, tgt.CONTRACT_CODE=src.CONTRACT_CODE
	, tgt.CONTRACT_NAME=src.CONTRACT_NAME
	, tgt.SERVICE_KEY=src.SERVICE_KEY
	, tgt.SERVICE_CODE=src.SERVICE_CODE
	, tgt.SERVICE_NAME=src.SERVICE_NAME
	, tgt.BILLING_KEY=src.BILLING_KEY
	, tgt.BILL_CODE=src.BILL_CODE
	, tgt.BILL_NAME=src.BILL_NAME
	, tgt.BILLABLE_FLAG=src.BILLABLE_FLAG
	, tgt.BILL_TYPE=src.BILL_TYPE
	, tgt.BILL_UOM=src.BILL_UOM
	, tgt.SCHEDULE_TYPE=src.SCHEDULE_TYPE
	, tgt.SCHEDULE_UOM=src.SCHEDULE_UOM
	, tgt.AUTHORIZATION_REQUIRED_FLAG=src.AUTHORIZATION_REQUIRED_FLAG
	, tgt.PAYABLE_FLAG=src.PAYABLE_FLAG
	, tgt.EXPENSE_FLAG=src.EXPENSE_FLAG
	, tgt.MILEAGE_FLAG=src.MILEAGE_FLAG
	, tgt.ETL_TASK_KEY=src.ETL_TASK_KEY
	, tgt.ETL_INSERTED_TASK_KEY=src.ETL_INSERTED_TASK_KEY
	, tgt.ETL_INSERTED_DATE=src.ETL_INSERTED_DATE
	, tgt.ETL_INSERTED_BY=src.ETL_INSERTED_BY
	, tgt.ETL_LAST_UPDATED_DATE=src.ETL_LAST_UPDATED_DATE
	, tgt.ETL_LAST_UPDATED_BY=src.ETL_LAST_UPDATED_BY
	, tgt.ETL_DELETED_FLAG=src.ETL_DELETED_FLAG
WHEN NOT MATCHED
THEN INSERT (PARTNER_CONTRACT_SERVICE_KEY
	, SOURCE_SYSTEM_ID
	, SYSTEM_CODE
	, STATE
	, PARTNER_CONTRACT_KEY
	, PARTNER_CODE
	, PARTNER_NAME
	, CONTRACT_CODE
	, CONTRACT_NAME
	, SERVICE_KEY
	, SERVICE_CODE
	, SERVICE_NAME
	, BILLING_KEY
	, BILL_CODE
	, BILL_NAME
	, BILLABLE_FLAG
	, BILL_TYPE
	, BILL_UOM
	, SCHEDULE_TYPE
	, SCHEDULE_UOM
	, AUTHORIZATION_REQUIRED_FLAG
	, PAYABLE_FLAG
	, EXPENSE_FLAG
	, MILEAGE_FLAG
	, ETL_TASK_KEY
	, ETL_INSERTED_TASK_KEY
	, ETL_INSERTED_DATE
	, ETL_INSERTED_BY
	, ETL_LAST_UPDATED_DATE
	, ETL_LAST_UPDATED_BY
	, ETL_DELETED_FLAG)
VALUES (src.PARTNER_CONTRACT_SERVICE_KEY
	, src.SOURCE_SYSTEM_ID
	, src.SYSTEM_CODE
	, src.STATE
	, src.PARTNER_CONTRACT_KEY
	, src.PARTNER_CODE
	, src.PARTNER_NAME
	, src.CONTRACT_CODE
	, src.CONTRACT_NAME
	, src.SERVICE_KEY
	, src.SERVICE_CODE
	, src.SERVICE_NAME
	, src.BILLING_KEY
	, src.BILL_CODE
	, src.BILL_NAME
	, src.BILLABLE_FLAG
	, src.BILL_TYPE
	, src.BILL_UOM
	, src.SCHEDULE_TYPE
	, src.SCHEDULE_UOM
	, src.AUTHORIZATION_REQUIRED_FLAG
	, src.PAYABLE_FLAG
	, src.EXPENSE_FLAG
	, src.MILEAGE_FLAG  
	, src.ETL_TASK_KEY
	, src.ETL_INSERTED_TASK_KEY
	, src.ETL_INSERTED_DATE
	, src.ETL_INSERTED_BY
	, src.ETL_LAST_UPDATED_DATE
	, src.ETL_LAST_UPDATED_BY
	, src.ETL_DELETED_FLAG);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Inserted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';