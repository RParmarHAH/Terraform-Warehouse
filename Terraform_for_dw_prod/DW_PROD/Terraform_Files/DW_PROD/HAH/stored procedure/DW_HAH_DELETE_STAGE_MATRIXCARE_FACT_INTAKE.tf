resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_MATRIXCARE_FACT_INTAKE" {
	name ="DELETE_STAGE_MATRIXCARE_FACT_INTAKE"
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
		DELETE FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID IN (7) AND INTAKE_KEY NOT IN (SELECT INTAKE_KEY FROM STAGE.VW_CURRENT_MATRIXCARE_FACT_INTAKE);
	else
		DELETE FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID IN (7) AND INTAKE_KEY IN (SELECT INTAKE_KEY FROM STAGE.VW_CURRENT_DELETED_MATRIXCARE_FACT_INTAKE);
	end if;
	SELECT CONCAT(''Message : '',"number of rows deleted", '' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
end;

 EOT
}

