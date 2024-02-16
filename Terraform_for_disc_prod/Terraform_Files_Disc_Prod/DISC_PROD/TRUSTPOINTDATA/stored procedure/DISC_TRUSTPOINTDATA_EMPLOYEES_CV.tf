resource "snowflake_procedure" "DISC_TRUSTPOINTDATA_EMPLOYEES_CV" {
	name ="EMPLOYEES_CV"
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

BEGIN 
-- *****************************************************************************************************************************
-- NAME:  EMPLOYEES_CV 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE            	AUTHOR                  	NOTES:
-- ----------      	-------------------     	-----------------------------------------------------------------------------------------------
-- 2023-11-20     	JIGAR PRAJAPATI          	INITIAL DEVELOPMENT
--*****************************************************************************************************************************

	CREATE OR REPLACE
	TABLE DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.EMPLOYEES AS
	WITH curr_v AS (
	SELECT 
			COMPANY,
		EMPLOYEE_NUMBER, 
			MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE
	FROM
		DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.HIST_EMPLOYEES
	GROUP BY
		COMPANY,
		EMPLOYEE_NUMBER
	)
	SELECT
		t.* EXCLUDE ETL_DELETED_FLAG,
		CASE
			WHEN ETL_INSERTED_DATE::DATE <> CURRENT_DATE THEN TRUE
			ELSE t.ETL_DELETED_FLAG
		END AS ETL_DELETED_FLAG
	FROM
		DISC_${var.SF_ENVIRONMENT}.TRUSTPOINTDATA.HIST_EMPLOYEES T
	INNER JOIN curr_v v 
		ON
		t.COMPANY = v.COMPANY
		AND t.EMPLOYEE_NUMBER = v.EMPLOYEE_NUMBER
		AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;
END;

 EOT
}

