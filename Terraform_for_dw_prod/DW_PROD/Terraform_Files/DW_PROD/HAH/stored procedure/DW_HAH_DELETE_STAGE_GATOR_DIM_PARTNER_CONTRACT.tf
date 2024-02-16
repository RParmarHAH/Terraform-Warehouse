resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_GATOR_DIM_PARTNER_CONTRACT" {
	name ="DELETE_STAGE_GATOR_DIM_PARTNER_CONTRACT"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  return_result VARCHAR;
BEGIN
return ''Done'';
END;

 EOT
}

