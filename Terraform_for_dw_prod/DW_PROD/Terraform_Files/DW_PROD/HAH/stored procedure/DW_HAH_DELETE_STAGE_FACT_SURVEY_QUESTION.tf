resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_FACT_SURVEY_QUESTION" {
	name ="DELETE_STAGE_FACT_SURVEY_QUESTION"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"

	arguments {
		name = "SOURCE_SYSTEM"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN
  return ''Done'';
END;

 EOT
}

