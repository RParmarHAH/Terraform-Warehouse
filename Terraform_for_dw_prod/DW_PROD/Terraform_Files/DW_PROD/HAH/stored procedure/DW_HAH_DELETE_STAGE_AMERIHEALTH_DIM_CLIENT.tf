resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_AMERIHEALTH_DIM_CLIENT" {
	name ="DELETE_STAGE_AMERIHEALTH_DIM_CLIENT"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN
return ''Message : Done'';
END;

 EOT
}

