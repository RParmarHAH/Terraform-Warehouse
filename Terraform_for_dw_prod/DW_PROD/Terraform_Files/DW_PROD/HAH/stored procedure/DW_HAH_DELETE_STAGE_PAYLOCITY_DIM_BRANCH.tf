resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_PAYLOCITY_DIM_BRANCH" {
	name ="DELETE_STAGE_PAYLOCITY_DIM_BRANCH"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

	BEGIN

	DELETE FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID = 10 AND BRANCH_KEY
    NOT IN (SELECT BRANCH_KEY FROM STAGE.PAYLOCITY_DIM_BRANCH);

	RETURN ''Message : Done'';
	END;

 EOT
}

