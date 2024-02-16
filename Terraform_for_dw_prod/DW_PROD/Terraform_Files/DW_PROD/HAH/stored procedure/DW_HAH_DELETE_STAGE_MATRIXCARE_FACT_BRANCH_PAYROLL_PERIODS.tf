resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_MATRIXCARE_FACT_BRANCH_PAYROLL_PERIODS" {
	name ="DELETE_STAGE_MATRIXCARE_FACT_BRANCH_PAYROLL_PERIODS"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN
	return ''Message : Done'';
end;

 EOT
}

