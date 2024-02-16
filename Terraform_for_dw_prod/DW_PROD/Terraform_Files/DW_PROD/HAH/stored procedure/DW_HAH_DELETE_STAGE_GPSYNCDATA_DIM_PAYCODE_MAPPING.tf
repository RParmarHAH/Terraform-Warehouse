resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_GPSYNCDATA_DIM_PAYCODE_MAPPING" {
	name ="DELETE_STAGE_GPSYNCDATA_DIM_PAYCODE_MAPPING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

 BEGIN
 RETURN ''Message:Done'';
 END;
 
 EOT
}

