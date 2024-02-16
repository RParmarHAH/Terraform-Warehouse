resource "snowflake_procedure" "DW_HAH_DIM_CLIENT_POSTPROCESSING" {
	name ="DIM_CLIENT_POSTPROCESSING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
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

UPDATE DW_${var.SF_ENVIRONMENT}.HAH.DIM_CLIENT C
SET C.FIRST_SERVICE_DATE = V.FIRST_SERVICE_DATE, C.LAST_SERVICE_DATE = V.LAST_SERVICE_DATE 
FROM (
    SELECT C.CLIENT_KEY, MIN(V.REPORT_DATE) FIRST_SERVICE_DATE, MAX(V.REPORT_DATE) LAST_SERVICE_DATE 
    FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_CLIENT C 
    LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT V
        ON C.CLIENT_KEY = V.CLIENT_KEY
	LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_CONTRACT DC ON V.CONTRACT_KEY = DC.CONTRACT_KEY
    WHERE DC.BILLABLE_FLAG = TRUE AND V.CONFIRMED_FLAG = ''YES''					-- Added this as we want first & Last confirmed AND billable visit date.
    GROUP BY 1
) V WHERE C.CLIENT_KEY = V.CLIENT_KEY;

SELECT CONCAT(''Message : '',"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

