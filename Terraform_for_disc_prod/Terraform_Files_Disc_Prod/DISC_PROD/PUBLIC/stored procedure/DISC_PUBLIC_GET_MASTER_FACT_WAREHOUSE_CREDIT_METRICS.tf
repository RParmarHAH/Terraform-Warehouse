resource "snowflake_procedure" "DISC_PUBLIC_GET_MASTER_FACT_WAREHOUSE_CREDIT_METRICS" {
	name ="GET_MASTER_FACT_WAREHOUSE_CREDIT_METRICS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "CALLER"
	statement = <<-EOT

DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
  INSERT INTO DISC_${var.SF_ENVIRONMENT}.PUBLIC.FACT_WAREHOUSE_CREDIT_METRICS
  SELECT 
    WAREHOUSE_NAME, 
    current_date() as CREDIT_DATE, 
    sum(CREDITS_USED) TOTAL_CREDITS_USED, 
    sum(CREDITS_USED_COMPUTE) TOTAL_CREDITS_USED_COMPUTE, 
    sum(CREDITS_USED_CLOUD_SERVICES) TOTAL_CREDITS_USED_CLOUD_SERVICES
  from table(information_schema.WAREHOUSE_METERING_HISTORY(current_date(),current_date()))
  group by WAREHOUSE_NAME;
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

