resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_SANDATAIMPORT_FACT_EVV_VISIT_EXCEPTIONS" {
	name ="DELETE_STAGE_SANDATAIMPORT_FACT_EVV_VISIT_EXCEPTIONS"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN
	RETURN ''Done'';
END;

 EOT
}

