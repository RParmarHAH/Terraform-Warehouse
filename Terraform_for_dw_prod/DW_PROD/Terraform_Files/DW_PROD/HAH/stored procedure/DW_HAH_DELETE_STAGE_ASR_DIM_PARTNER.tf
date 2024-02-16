resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_ASR_DIM_PARTNER" {
	name ="DELETE_STAGE_ASR_DIM_PARTNER"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    RETURN_RESULT VARCHAR;
BEGIN
DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_PARTNER WHERE SOURCE_SYSTEM_ID = 13 AND SYSTEM_CODE =''PRIME''
AND PARTNER_KEY NOT IN (SELECT PARTNER_KEY FROM DW_${var.SF_ENVIRONMENT}."STAGE".ASR_DIM_PARTNER);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

