CREATE OR REPLACE PROCEDURE DISC_PROD.PUBLIC.GET_MASTER_FACT_DATABASE_USAGE_METRICS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS CALLER
AS '
DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
INSERT INTO DISC_PROD.PUBLIC.FACT_DATABASE_USAGE_METRICS
SELECT DATABASE_NAME, USAGE_DATE, average_database_bytes/1024/1024/1024 as db_size_gb, average_failsafe_bytes/1024/1024/1024 as failsafe_size_gb from table(information_schema.database_storage_usage_history(current_date(),current_date(), ''DW_DEV''))
union all
SELECT DATABASE_NAME, USAGE_DATE, average_database_bytes/1024/1024/1024 as db_size_gb, average_failsafe_bytes/1024/1024/1024 as failsafe_size_gb from table(information_schema.database_storage_usage_history(current_date(),current_date(), ''DW_PROD''))
union all
SELECT DATABASE_NAME, USAGE_DATE, average_database_bytes/1024/1024/1024 as db_size_gb, average_failsafe_bytes/1024/1024/1024 as failsafe_size_gb from table(information_schema.database_storage_usage_history(current_date(),current_date(), ''DISC_DEV''))
union all
SELECT DATABASE_NAME, USAGE_DATE, average_database_bytes/1024/1024/1024 as db_size_gb, average_failsafe_bytes/1024/1024/1024 as failsafe_size_gb from table(information_schema.database_storage_usage_history(current_date(),current_date(), ''DISC_PROD''));
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    ';