resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_SANDATAIMPORT_FACT_EVV_VISIT" {
	name ="DELETE_STAGE_SANDATAIMPORT_FACT_EVV_VISIT"
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
		DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_EVV_VISIT WHERE SOURCE_SYSTEM_ID = 4 AND VISIT_KEY NOT IN (SELECT VISIT_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.VW_CURRENT_SANDATAIMPORT_FACT_EVV_VISIT);
	else
		DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.FACT_EVV_VISIT WHERE SOURCE_SYSTEM_ID = 4 AND VISIT_KEY IN (SELECT VISIT_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.VW_CURRENT_DELETED_SANDATAIMPORT_FACT_EVV_VISIT);
	end if;
	SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
end;

 EOT
}

