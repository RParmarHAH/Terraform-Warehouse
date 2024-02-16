resource "snowflake_procedure" "DW_INTEGRATION_FACT_REVENUE_MERGED_POSTPROCESSING" {
	name ="FACT_REVENUE_MERGED_POSTPROCESSING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
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

    INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_REVENUE_MERGED 
	SELECT REVENUE.REVENUE_KEY,
		REVENUE.REPORT_DATE,
		COALESCE(BRANCH_MERGED.BRANCH_KEY, REVENUE.BRANCH_KEY) AS BRANCH_KEY,
		REVENUE.BRANCH_KEY AS ORIGINAL_BRANCH_KEY,
		COALESCE(EMPLOYEE_MERGED.EMPLOYEE_KEY, REVENUE.EMPLOYEE_KEY) AS EMPLOYEE_KEY,
		REVENUE.EMPLOYEE_KEY AS ORIGINAL_EMPLOYEE_KEY,
		COALESCE(CLIENT_MERGED.CLIENT_KEY, REVENUE.CLIENT_KEY) AS CLIENT_KEY,
		REVENUE.CLIENT_KEY AS ORIGINAL_CLIENT_KEY,
		REVENUE.CONTRACT_KEY,
		REVENUE.INVOICE_KEY,
		COALESCE(CLIENT_MERGED.SOURCE_SYSTEM_ID, REVENUE.SOURCE_SYSTEM_ID) AS SOURCE_SYSTEM_ID,
		REVENUE.SOURCE_SYSTEM_ID AS ORIGINAL_SOURCE_SYSTEM_ID,
		COALESCE(SUPERVISOR_MERGED.SUPERVISOR_KEY , REVENUE.SUPERVISOR_KEY) AS SUPERVISOR_KEY,
		REVENUE.SUPERVISOR_KEY AS ORIGINAL_SUPERVISOR_KEY,
		REVENUE.REVENUE_DATE,
		REVENUE.PAYMENT_DATE,
		REVENUE.BRANCH_NAME,
		COALESCE(EMPLOYEE_MERGED.EMPLOYEE_ID , REVENUE.EMPLOYEE_ID) AS EMPLOYEE_ID,
		REVENUE.EMPLOYEE_ID AS ORIGINAL_EMPLOYEE_ID,
		COALESCE(CLIENT_MERGED.CLIENT_NUMBER , REVENUE.CLIENT_NUMBER) AS CLIENT_NUMBER,
		REVENUE.CLIENT_NUMBER AS ORIGINAL_CLIENT_NUMBER,
		REVENUE.CONTRACT_CODE,
		REVENUE.INVOICE_NUMBER,
		REVENUE.BILL_UNIT_TYPE,
		COALESCE(CLIENT_MERGED.SYSTEM_CODE, REVENUE.SYSTEM_CODE) AS SYSTEM_CODE,
		REVENUE.SYSTEM_CODE AS ORIGINAL_SYSTEM_CODE,
		COALESCE(SUPERVISOR_MERGED.SUPERVISOR_CODE, REVENUE.SUPERVISOR_CODE) AS SUPERVISOR_CODE,
		REVENUE.SUPERVISOR_CODE AS ORIGINAL_SUPERVISOR_CODE,
		REVENUE.BILL_CODE,
		REVENUE.INVOICE_HOURS,
		REVENUE.INVOICE_RATE,
		REVENUE.AMOUNT_BILLED,
		REVENUE.AMOUNT_COLLECTED,
		REVENUE.AMOUNT_OUTSTANDING,
		REVENUE.ETL_TASK_KEY,
		REVENUE.ETL_INSERTED_TASK_KEY,
		REVENUE.ETL_INSERTED_DATE,
		REVENUE.ETL_INSERTED_BY,
		REVENUE.ETL_LAST_UPDATED_DATE,
		REVENUE.ETL_LAST_UPDATED_BY,
		REVENUE.ETL_DELETED_FLAG
	FROM HAH.FACT_REVENUE AS REVENUE
	LEFT JOIN INTEGRATION.DIM_BRANCH_MERGED AS BRANCH_MERGED
		ON BRANCH_MERGED.ORIGINAL_BRANCH_KEY = REVENUE.BRANCH_KEY
	LEFT JOIN INTEGRATION.DIM_CLIENT_MERGED AS CLIENT_MERGED
		ON CLIENT_MERGED.ORIGINAL_CLIENT_KEY = REVENUE.CLIENT_KEY
	LEFT JOIN INTEGRATION.DIM_EMPLOYEE_MERGED AS EMPLOYEE_MERGED
		ON EMPLOYEE_MERGED.ORIGINAL_EMPLOYEE_KEY = REVENUE.EMPLOYEE_KEY
    LEFT JOIN INTEGRATION.DIM_SUPERVISOR_MERGED AS SUPERVISOR_MERGED 
    	ON SUPERVISOR_MERGED.ORIGINAL_SUPERVISOR_KEY = REVENUE.SUPERVISOR_KEY;
		
SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

