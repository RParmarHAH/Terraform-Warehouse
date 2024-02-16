resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_DATAFLEXSYNCDATA_DIM_BILL_PERSON" {
	name ="DELETE_STAGE_DATAFLEXSYNCDATA_DIM_BILL_PERSON"
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

