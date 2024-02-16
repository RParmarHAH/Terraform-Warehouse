resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_ROSTER_FACT_CLIENT_STATUS_HISTORY" {
	name ="DELETE_STAGE_ROSTER_FACT_CLIENT_STATUS_HISTORY"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT
BEGIN
--*****************************************************************************************************************************
-- NAME:  ROSTER_FACT_CLIENT_STATUS_HISTORY
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   ------------------------------------------------------------------------------------------
-- 03/10/23    POOJA DEOKATE          Initial development
--*****************************************************************************************************************************
-- This procedure is created w/o any logic. Because current ADF pipeline do not support business layer structure
-- without DELETE procedure. It should have three procedures GET, MERGE & DELETE
RETURN ''Message : Done'';
END
 EOT
}

