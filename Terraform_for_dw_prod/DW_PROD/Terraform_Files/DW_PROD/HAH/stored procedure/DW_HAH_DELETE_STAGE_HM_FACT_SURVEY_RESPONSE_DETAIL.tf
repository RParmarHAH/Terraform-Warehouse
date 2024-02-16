resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_HM_FACT_SURVEY_RESPONSE_DETAIL" {
	name ="DELETE_STAGE_HM_FACT_SURVEY_RESPONSE_DETAIL"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "JAVASCRIPT"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT


  sqlCmd = `SELECT 1`;
//  rs = sqlStmt.execute();
  return ''Done'';


 EOT
}

