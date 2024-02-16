resource "snowflake_procedure" "DISC_PUBLIC_GET_MASTER_FACT_DATABASE_USAGE_METRICS" {
	name ="GET_MASTER_FACT_DATABASE_USAGE_METRICS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "CALLER"
	statement = <<-EOT

DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
INSERT INTO DISC_${var.SF_ENVIRONMENT}.PUBLIC.FACT_DATABASE_USAGE_METRICS
SELECT DATABASE_NAME, USAGE_DATE, average_database_bytes/1024/1024/1024 as db_size_gb, average_failsafe_bytes/1024/1024/1024 as failsafe_size_gb from table(information_schema.database_storage_usage_history(current_date(),current_date(), ''DW_${var.SF_ENVIRONMENT}''))
union all
SELECT DATABASE_NAME, USAGE_DATE, average_database_bytes/1024/1024/1024 as db_size_gb, average_failsafe_bytes/1024/1024/1024 as failsafe_size_gb from table(information_schema.database_storage_usage_history(current_date(),current_date(), ''DW_${var.SF_ENVIRONMENT}''))
union all
SELECT DATABASE_NAME, USAGE_DATE, average_database_bytes/1024/1024/1024 as db_size_gb, average_failsafe_bytes/1024/1024/1024 as failsafe_size_gb from table(information_schema.database_storage_usage_history(current_date(),current_date(), ''DISC_${var.SF_ENVIRONMENT}''))
union all
SELECT DATABASE_NAME, USAGE_DATE, average_database_bytes/1024/1024/1024 as db_size_gb, average_failsafe_bytes/1024/1024/1024 as failsafe_size_gb from table(information_schema.database_storage_usage_history(current_date(),current_date(), ''DISC_${var.SF_ENVIRONMENT}''));
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

