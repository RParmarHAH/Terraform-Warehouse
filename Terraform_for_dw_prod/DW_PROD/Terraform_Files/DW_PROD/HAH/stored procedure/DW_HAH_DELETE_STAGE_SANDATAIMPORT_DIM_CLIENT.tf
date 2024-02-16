resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_SANDATAIMPORT_DIM_CLIENT" {
	name ="DELETE_STAGE_SANDATAIMPORT_DIM_CLIENT"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
	day_Of_Week int;
	return_result VARCHAR;
BEGIN
	SELECT dayofweek(current_timestamp()) into day_Of_Week;
	if (day_Of_Week = 0) then
		DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_CLIENT WHERE SOURCE_SYSTEM_ID = 4 AND CLIENT_KEY NOT IN (SELECT CLIENT_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.VW_CURRENT_SANDATAIMPORT_DIM_CLIENT);
	else
		DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_CLIENT WHERE SOURCE_SYSTEM_ID = 4 AND CLIENT_KEY IN (SELECT CLIENT_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.VW_CURRENT_DELETED_SANDATAIMPORT_DIM_CLIENT);
	end if;
	SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
end;

 EOT
}

