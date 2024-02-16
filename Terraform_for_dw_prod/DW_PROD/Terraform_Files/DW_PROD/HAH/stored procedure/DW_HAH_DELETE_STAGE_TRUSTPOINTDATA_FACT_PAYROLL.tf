resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_TRUSTPOINTDATA_FACT_PAYROLL" {
	name ="DELETE_STAGE_TRUSTPOINTDATA_FACT_PAYROLL"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  return_result VARCHAR;
BEGIN
DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_PAYROLL WHERE SOURCE_SYSTEM_ID = 6 AND PAYROLL_KEY  NOT IN (SELECT PAYROLL_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.TRUSTPOINTDATA_FACT_PAYROLL);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

