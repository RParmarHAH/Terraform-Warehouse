resource "snowflake_procedure" "DISC_TRUSTPOINTDATA_HIST_EMPLOYEES_CV" {
	name ="EMPLOYEES_CV"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "TRUSTPOINTDATA_HIST"
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

CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.Employees AS
WITH curr_v AS (
  SELECT COMPANY, EMPLOYEE_NUMBER, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE 
  FROM DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.HIST_EMPLOYEES GROUP BY COMPANY, EMPLOYEE_NUMBER ) 
  SELECT t.* FROM DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.HIST_EMPLOYEES t 
  INNER JOIN curr_v v 
  ON t.COMPANY = v.COMPANY 
  AND t.EMPLOYEE_NUMBER = v.EMPLOYEE_NUMBER 
  AND t.ETL_DELETED_FLAG = FALSE 
  AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;
   
 EOT
}

