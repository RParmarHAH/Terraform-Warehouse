resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_CLEARCARE_DIM_INVOICE_TRANSACTION_TYPE" {
	name ="DELETE_STAGE_CLEARCARE_DIM_INVOICE_TRANSACTION_TYPE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN

	DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_INVOICE_TRANSACTION_TYPE WHERE SOURCE_SYSTEM_ID = 16
		   AND TRANSACTION_TYPE_KEY NOT IN (SELECT TRANSACTION_TYPE_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.CLEARCARE_DIM_INVOICE_TRANSACTION_TYPE);

RETURN ''SUCCESS'';
END;

 EOT
}

