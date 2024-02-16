resource "snowflake_procedure" "DW_HAH_DELETE_STAGE_ALLIANCE_DIM_EMPLOYEE" {
	name ="DELETE_STAGE_ALLIANCE_DIM_EMPLOYEE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

  BEGIN 
  DELETE FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID =19 AND SYSTEM_CODE = ''ALLIANCE'' AND EMPLOYEE_KEY
  NOT IN (SELECT EMPLOYEE_KEY FROM DW_${var.SF_ENVIRONMENT}.STAGE.ALLIANCE_DIM_EMPLOYEE);
 RETURN ''SUCCESS'';
END; 

 EOT
}

