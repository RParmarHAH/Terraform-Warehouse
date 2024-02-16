resource "snowflake_procedure" "DISC_TRUSTPOINTDATA_HIST_PAYROLLDATA_DELETE" {
	name ="PAYROLLDATA_DELETE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "TRUSTPOINTDATA_HIST"
	language  = "JAVASCRIPT"

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

        var sql = `
   delete from "DISC_${var.SF_ENVIRONMENT}"."TRUSTPOINTDATA"."PAYROLL" where REGEXP_LIKE(EMPLOYEE_ID, ''[a-zA-Z].*'') =''TRUE'' AND COMPANY = ''EXCEL'';
`;
          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          
 EOT
}

