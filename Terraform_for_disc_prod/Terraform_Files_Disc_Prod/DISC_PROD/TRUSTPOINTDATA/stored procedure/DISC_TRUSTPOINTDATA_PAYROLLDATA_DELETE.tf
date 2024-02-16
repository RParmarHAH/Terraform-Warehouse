resource "snowflake_procedure" "DISC_TRUSTPOINTDATA_PAYROLLDATA_DELETE" {
	name ="PAYROLLDATA_DELETE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "TRUSTPOINTDATA"
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
   delete from "DISC_${var.SF_ENVIRONMENT}"."TRUSTPOINTDATA"."PAYROLL" where REGEXP_LIKE(EMPLOYEE_ID, ''[a-zA-Z].*'') =''TRUE'' AND COMPANY = ''EXCEL'';
SELECT CONCAT (''MESSAGE : '',"number of rows deleted",'' Rows Deleted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
  END;

 EOT
}

