resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_DATAFLEXSYNCDATA_FACT_INVOICE_TRANSACTIONS" {
	name ="DELETE_STAGE_DATAFLEXSYNCDATA_FACT_INVOICE_TRANSACTIONS"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN

	DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_INVOICE_TRANSACTIONS WHERE SOURCE_SYSTEM_ID =3
		   AND TRANSACTION_KEY NOT IN (SELECT TRANSACTION_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.DATAFLEXSYNCDATA_FACT_INVOICE_TRANSACTIONS);

RETURN ''SUCCESS'';
END;

 EOT
}

