resource "snowflake_procedure" "DISC_PUBLIC_PYTHON_CODE_TESTING" {
	name ="PYTHON_CODE_TESTING"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
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
return_result VARCHAR;
BEGIN
INSERT
	INTO
	DISC_${var.SF_ENVIRONMENT}."PUBLIC".TEST81 
SELECT
	ID,
	LASTRUNDATE
FROM
	DISC_${var.SF_ENVIRONMENT}."PUBLIC".PIPELINE_CONFIG_DISCOVERY
WHERE
	ID NOT IN (
	SELECT
		BRANCH_ID
	FROM
		DISC_${var.SF_ENVIRONMENT}."PUBLIC".TEST81)
	AND LASTRUNDATE IS NOT NULL
LIMIT 3;
SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;


 EOT
}

