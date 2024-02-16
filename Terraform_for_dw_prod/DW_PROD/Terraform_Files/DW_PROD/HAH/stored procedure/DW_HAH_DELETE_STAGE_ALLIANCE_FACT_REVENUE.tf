resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_ALLIANCE_FACT_REVENUE" {
	name ="DELETE_STAGE_ALLIANCE_FACT_REVENUE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

  BEGIN
  DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID = 19 AND SYSTEM_CODE = ''ALLIANCE'' AND REVENUE_KEY
  NOT IN (SELECT REVENUE_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.ALLIANCE_FACT_REVENUE);
  
RETURN ''SUCCESS'';
END;

 EOT
}

