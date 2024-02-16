resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_MOLINA_GAPS_IN_CARE" {
	name ="DELETE_STAGE_MOLINA_GAPS_IN_CARE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT
BEGIN
--*****************************************************************************************************************************
-- NAME:  MOLINA_GAPS_IN_CARE
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   ------------------------------------------------------------------------------------------
-- 08/07/23    ASHISH SHARMA          Initial development
--*****************************************************************************************************************************
-- This pocedure is created w/o any logic. Because current ADF pipeline do not support business layer structure
-- without DELETE procedure. It should have three procedures GET, MERGE & DELETE
RETURN ''Message : Done'';
END
 EOT
}

