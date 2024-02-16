resource "snowflake_procedure" "DW_HAH_MERGE_STAGE_MATRIXCARE_FACT_CLIENT_SERVICE" {
	name ="MERGE_STAGE_MATRIXCARE_FACT_CLIENT_SERVICE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN
MERGE INTO DW_${var.SF_ENVIRONMENT}.HAH.FACT_CLIENT_SERVICE AS tgt
	USING STAGE.MATRIXCARE_FACT_CLIENT_SERVICE STAGE
	ON TGT.CLIENT_SERVICE_KEY = STAGE.CLIENT_SERVICE_KEY
	WHEN MATCHED THEN
	UPDATE SET
	TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE
	,TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID
	,TGT.PARTNER_CONTRACT_SERVICE_KEY= STAGE.PARTNER_CONTRACT_SERVICE_KEY
	,TGT.CLIENT_ADMISSION_KEY= STAGE.CLIENT_ADMISSION_KEY
	,TGT.SERVICE_KEY= STAGE.SERVICE_KEY
	,TGT.CLIENT_KEY= STAGE.CLIENT_KEY
	,TGT.BILL_CODE= STAGE.BILL_CODE
	,TGT.BILL_TYPE= STAGE.BILL_TYPE
	,TGT.BILL_UOM= STAGE.BILL_UOM
	,TGT.SCHEDULE_TYPE= STAGE.SCHEDULE_TYPE
	,TGT.SCHEDULE_UOM= STAGE.SCHEDULE_UOM
	,TGT.AUTHORIZATION_DISCIPLINE= STAGE.AUTHORIZATION_DISCIPLINE
	,TGT.AUTHORIZATION_DATE= STAGE.AUTHORIZATION_DATE
	,TGT.AUTHORIZATION_PERIOD_START_DATE= STAGE.AUTHORIZATION_PERIOD_START_DATE
	,TGT.AUTHORIZATION_PERIOD_END_DATE= STAGE.AUTHORIZATION_PERIOD_END_DATE
    ,TGT.EFFECTIVE_DAYS= STAGE.EFFECTIVE_DAYS 
	,TGT.AUTHORIZATION_TYPE= STAGE.AUTHORIZATION_TYPE
	,TGT.AUTHORIZATION_UOM= STAGE.AUTHORIZATION_UOM
    ,TGT.AUTH_INFO = STAGE.AUTH_INFO
	,TGT.AUTHORIZATION_MAX_UNITS_BY_UOM= STAGE.AUTHORIZATION_MAX_UNITS_BY_UOM
	,TGT.AUTHORIZATION_MAX_UNITS= STAGE.AUTHORIZATION_MAX_UNITS
	,TGT.AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM= STAGE.AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM
	,TGT.AUTHORIZATION_MAX_UNITS_ADJUSTED= STAGE.AUTHORIZATION_MAX_UNITS_ADJUSTED
	,TGT.CANCELLED_FLAG= STAGE.CANCELLED_FLAG
	,TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY
	,TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE
	,TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY
	,TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG
	WHEN NOT MATCHED THEN
	INSERT (
	CLIENT_SERVICE_KEY
	,SYSTEM_CODE
	,SOURCE_SYSTEM_ID
	,PARTNER_CONTRACT_SERVICE_KEY
	,CLIENT_ADMISSION_KEY
	,SERVICE_KEY
	,CLIENT_KEY
	,BILL_CODE
	,BILL_TYPE
	,BILL_UOM
	,SCHEDULE_TYPE
	,SCHEDULE_UOM
	,AUTHORIZATION_DISCIPLINE
	,AUTHORIZATION_DATE
	,AUTHORIZATION_PERIOD_START_DATE
	,AUTHORIZATION_PERIOD_END_DATE
    ,EFFECTIVE_DAYS
	,AUTHORIZATION_TYPE
	,AUTHORIZATION_UOM
    ,AUTH_INFO
	,AUTHORIZATION_MAX_UNITS_BY_UOM
	,AUTHORIZATION_MAX_UNITS
	,AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM
	,AUTHORIZATION_MAX_UNITS_ADJUSTED
	,ACTIVE_FLAG
	,CANCELLED_FLAG
	,ETL_TASK_KEY
	,ETL_INSERTED_TASK_KEY
	,ETL_INSERTED_DATE
	,ETL_INSERTED_BY
	,ETL_LAST_UPDATED_DATE
	,ETL_LAST_UPDATED_BY
	,ETL_DELETED_FLAG
	)
	VALUES (
	STAGE.CLIENT_SERVICE_KEY
	,STAGE.SYSTEM_CODE
	,STAGE.SOURCE_SYSTEM_ID
	,STAGE.PARTNER_CONTRACT_SERVICE_KEY
	,STAGE.CLIENT_ADMISSION_KEY
	,STAGE.SERVICE_KEY
	,STAGE.CLIENT_KEY
	,STAGE.BILL_CODE
	,STAGE.BILL_TYPE
	,STAGE.BILL_UOM
	,STAGE.SCHEDULE_TYPE
	,STAGE.SCHEDULE_UOM
	,STAGE.AUTHORIZATION_DISCIPLINE
	,STAGE.AUTHORIZATION_DATE
	,STAGE.AUTHORIZATION_PERIOD_START_DATE
	,STAGE.AUTHORIZATION_PERIOD_END_DATE
    ,STAGE.EFFECTIVE_DAYS
	,STAGE.AUTHORIZATION_TYPE
	,STAGE.AUTHORIZATION_UOM
    ,STAGE.AUTH_INFO
	,STAGE.AUTHORIZATION_MAX_UNITS_BY_UOM
	,STAGE.AUTHORIZATION_MAX_UNITS
	,STAGE.AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM
	,STAGE.AUTHORIZATION_MAX_UNITS_ADJUSTED
	,STAGE.ACTIVE_FLAG
	,STAGE.CANCELLED_FLAG
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

 EOT
}

