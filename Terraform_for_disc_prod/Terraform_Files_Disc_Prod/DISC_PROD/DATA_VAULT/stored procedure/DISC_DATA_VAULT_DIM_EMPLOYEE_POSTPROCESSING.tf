resource "snowflake_procedure" "DISC_DATA_VAULT_DIM_EMPLOYEE_POSTPROCESSING" {
	name ="DIM_EMPLOYEE_POSTPROCESSING"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_VAULT"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
              UPDATE DW_${var.SF_ENVIRONMENT}.HAH.DIM_EMPLOYEE EMP SET MDM_DIM_EMPLOYEE_KEY = LNK.HASH_EMPLOYEE_KEY FROM DISC_${var.SF_ENVIRONMENT}.DATA_VAULT.LINK_EMPLOYEE LNK WHERE LNK.LINK_EMPLOYEE_KEY = EMP.EMPLOYEE_KEY AND EMP.SOURCE_SYSTEM_ID IN (3,5,4,6);
	
SELECT CONCAT(''MESSAGE : '',"number of rows Updated",'' Rows Updated.'') into :RETURN_RESULT FROM TABLE(RESULT_SCAN(LAST_QUERY_ID())); 
RETURN return_result;
    END;
    
 EOT
}

