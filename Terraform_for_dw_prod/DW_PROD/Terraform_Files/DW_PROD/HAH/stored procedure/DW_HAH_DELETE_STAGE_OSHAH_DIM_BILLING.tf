resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_OSHAH_DIM_BILLING" {
	name ="DELETE_STAGE_OSHAH_DIM_BILLING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    RETURN_RESULT VARCHAR;
BEGIN
DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_BILLING WHERE SOURCE_SYSTEM_ID = 17  AND SYSTEM_CODE ILIKE ''%OSHAH%''
AND BILLING_KEY NOT IN (SELECT BILLING_KEY FROM DW_${var.SF_ENVIRONMENT}."STAGE".OSHAH_DIM_BILLING);
SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

