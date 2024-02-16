CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_EDISON_FACT_CLIENT_SERVICE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
MERGE INTO DW_PROD.HAH.FACT_CLIENT_SERVICE AS tgt
USING STAGE.EDISON_FACT_CLIENT_SERVICE AS src
ON tgt.CLIENT_SERVICE_KEY=src.CLIENT_SERVICE_KEY
WHEN MATCHED
THEN UPDATE SET
	  tgt.SOURCE_SYSTEM_ID=src.SOURCE_SYSTEM_ID
	, tgt.SYSTEM_CODE=src.SYSTEM_CODE
	, tgt.PARTNER_CONTRACT_SERVICE_KEY=src.PARTNER_CONTRACT_SERVICE_KEY
	, tgt.CLIENT_ADMISSION_KEY=src.CLIENT_ADMISSION_KEY
	, tgt.CLIENT_KEY=src.CLIENT_KEY
	, tgt.SERVICE_KEY=src.SERVICE_KEY
	, tgt.BILL_CODE=src.BILL_CODE
	, tgt.BILL_TYPE=src.BILL_TYPE
	, tgt.BILL_UOM=src.BILL_UOM
	, tgt.SCHEDULE_TYPE=src.SCHEDULE_TYPE
	, tgt.SCHEDULE_UOM=src.SCHEDULE_UOM
	, tgt.AUTHORIZATION_DISCIPLINE=src.AUTHORIZATION_DISCIPLINE
	, tgt.AUTHORIZATION_DATE=src.AUTHORIZATION_DATE
	, tgt.AUTHORIZATION_PERIOD_START_DATE=src.AUTHORIZATION_PERIOD_START_DATE
	, tgt.AUTHORIZATION_PERIOD_END_DATE=src.AUTHORIZATION_PERIOD_END_DATE
	, tgt.EFFECTIVE_DAYS=src.EFFECTIVE_DAYS
	, tgt.AUTHORIZATION_TYPE=src.AUTHORIZATION_TYPE
	, tgt.AUTHORIZATION_UOM=src.AUTHORIZATION_UOM
	, tgt.AUTH_INFO=src.AUTH_INFO
	, tgt.AUTHORIZATION_MAX_UNITS_BY_UOM=src.AUTHORIZATION_MAX_UNITS_BY_UOM
	, tgt.AUTHORIZATION_MAX_UNITS=src.AUTHORIZATION_MAX_UNITS
	, tgt.AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM=src.AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM
	, tgt.AUTHORIZATION_MAX_UNITS_ADJUSTED=src.AUTHORIZATION_MAX_UNITS_ADJUSTED
	, tgt.ACTIVE_FLAG=src.ACTIVE_FLAG
	, tgt.CANCELLED_FLAG=src.CANCELLED_FLAG
	, tgt.ETL_TASK_KEY=src.ETL_TASK_KEY
	, tgt.ETL_INSERTED_TASK_KEY=src.ETL_INSERTED_TASK_KEY
	, tgt.ETL_INSERTED_DATE=src.ETL_INSERTED_DATE
	, tgt.ETL_INSERTED_BY=src.ETL_INSERTED_BY
	, tgt.ETL_LAST_UPDATED_DATE=src.ETL_LAST_UPDATED_DATE
	, tgt.ETL_LAST_UPDATED_BY=src.ETL_LAST_UPDATED_BY
	, tgt.ETL_DELETED_FLAG=src.ETL_DELETED_FLAG
WHEN NOT MATCHED
THEN INSERT (CLIENT_SERVICE_KEY
	, SOURCE_SYSTEM_ID
	, SYSTEM_CODE
	, PARTNER_CONTRACT_SERVICE_KEY
	, CLIENT_ADMISSION_KEY
	, CLIENT_KEY
	, SERVICE_KEY
	, BILL_CODE
	, BILL_TYPE
	, BILL_UOM
	, SCHEDULE_TYPE
	, SCHEDULE_UOM
	, AUTHORIZATION_DISCIPLINE
	, AUTHORIZATION_DATE
	, AUTHORIZATION_PERIOD_START_DATE
	, AUTHORIZATION_PERIOD_END_DATE
	, EFFECTIVE_DAYS
	, AUTHORIZATION_TYPE
	, AUTHORIZATION_UOM
	, AUTH_INFO
	, AUTHORIZATION_MAX_UNITS_BY_UOM
	, AUTHORIZATION_MAX_UNITS
	, AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM
	, AUTHORIZATION_MAX_UNITS_ADJUSTED
	, ACTIVE_FLAG
	, CANCELLED_FLAG
	, ETL_TASK_KEY
	, ETL_INSERTED_TASK_KEY
	, ETL_INSERTED_DATE
	, ETL_INSERTED_BY
	, ETL_LAST_UPDATED_DATE
	, ETL_LAST_UPDATED_BY
	, ETL_DELETED_FLAG)
VALUES (src.CLIENT_SERVICE_KEY
	, src.SOURCE_SYSTEM_ID
	, src.SYSTEM_CODE
	, src.PARTNER_CONTRACT_SERVICE_KEY
	, src.CLIENT_ADMISSION_KEY
	, src.CLIENT_KEY
	, src.SERVICE_KEY
	, src.BILL_CODE
	, src.BILL_TYPE
	, src.BILL_UOM
	, src.SCHEDULE_TYPE
	, src.SCHEDULE_UOM
	, src.AUTHORIZATION_DISCIPLINE
	, src.AUTHORIZATION_DATE
	, src.AUTHORIZATION_PERIOD_START_DATE
	, src.AUTHORIZATION_PERIOD_END_DATE
	, src.EFFECTIVE_DAYS
	, src.AUTHORIZATION_TYPE
	, src.AUTHORIZATION_UOM
	, src.AUTH_INFO
	, src.AUTHORIZATION_MAX_UNITS_BY_UOM
	, src.AUTHORIZATION_MAX_UNITS
	, src.AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM
	, src.AUTHORIZATION_MAX_UNITS_ADJUSTED
	, src.ACTIVE_FLAG
	, src.CANCELLED_FLAG
	, src.ETL_TASK_KEY
	, src.ETL_INSERTED_TASK_KEY
	, src.ETL_INSERTED_DATE
	, src.ETL_INSERTED_BY
	, src.ETL_LAST_UPDATED_DATE
	, src.ETL_LAST_UPDATED_BY
	, src.ETL_DELETED_FLAG);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Insrted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';