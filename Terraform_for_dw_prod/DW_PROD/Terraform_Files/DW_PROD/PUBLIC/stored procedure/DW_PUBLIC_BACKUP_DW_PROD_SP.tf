resource "snowflake_procedure" "DW_PUBLIC_BACKUP_DW_PROD_SP" {
	name ="BACKUP_DW_PROD_SP"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "JAVASCRIPT"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

 EOT
}

