resource "snowflake_procedure" "DW_REPORT_GET_REPORT_CLIENT_CAREGIVER_MONTHLY_RELATIONSHIP_2_0" {
	name ="GET_REPORT_CLIENT_CAREGIVER_MONTHLY_RELATIONSHIP_2_0"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
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

		 --*****************************************************************************************************************************
-- NAME:  CLIENT_CAREGIVER_RELATIONSHIP_2_0
--
-- PURPOSE: Creates derived monthly metrics for each client based on visit/service data
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 12/8/23    Deepen Gajjar         Initial development
--*****************************************************************************************************************************
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.REPORT.CLIENT_CAREGIVER_MONTHLY_RELATIONSHIP_2_0
SELECT
	DISTINCT V.VISIT_KEY,
	V.SERVICE_DATE,
	V.CLIENT_KEY, 
	V.ORIGINAL_CLIENT_KEY, 
	V.CLIENT_NUMBER ,
	V.EMPLOYEE_KEY, 
	V.ORIGINAL_EMPLOYEE_KEY,
	E.EMPLOYEE_NUMBER, 
	V.SYSTEM_CODE,
	V.BRANCH_KEY,
	V.CONFIRMED_FLAG,
	CL.CLIENT_DOB,
	E.EMPLOYEE_DOB,
	E.CASE_MANAGER_FLAG,
	E.EMPLOYEE_CATEGORY ,
	CL.CLIENT_ZIP,
	CG.LATITUDE AS CG_LATITUDE,
	CG.LONGITUDE AS CG_LONGITUDE,
	E.EMPLOYEE_ZIP,
	EG.LATITUDE AS EG_LATITUDE,
	EG.LONGITUDE AS EG_LONGITUDE,
	v.HOURS_SERVED,
--	IFF(v.SOURCE_SYSTEM_ID=3 AND B.REVENUE_SUBCATEGORY_CODE IN (''DDM'',''NSH''),0,v.HOURS_SERVED) as HOURS_SERVED,
	E.EMPLOYEE_FIRST_NAME,
	E.EMPLOYEE_LAST_NAME,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,     
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY ,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY	
FROM INTEGRATION.FACT_VISIT_MERGED V 
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.FACT_PARTNER_CONTRACT_SERVICE pcs ON pcs.partner_contract_service_key = v.partner_contract_service_key
LEFT JOIN HAH.DIM_SERVICES  B ON B.SERVICE_KEY = PCS.SERVICE_KEY 
LEFT JOIN INTEGRATION.DIM_EMPLOYEE_MERGED E ON E.ORIGINAL_EMPLOYEE_KEY = V.ORIGINAL_EMPLOYEE_KEY 
JOIN INTEGRATION.DIM_CLIENT_MERGED CL ON CL.ORIGINAL_CLIENT_KEY = V.ORIGINAL_CLIENT_KEY
JOIN INTEGRATION.DIM_BRANCH_MERGED BRANCH ON BRANCH.ORIGINAL_BRANCH_KEY = V.BRANCH_KEY   
LEFT JOIN HAH.DIM_GEOGRAPHY CG ON CG.ZIP_CODE = CLIENT_ZIP
LEFT JOIN HAH.DIM_GEOGRAPHY EG ON EG.ZIP_CODE = E.EMPLOYEE_ZIP 
WHERE DATE_TRUNC(''MONTH'',V.SERVICE_DATE) <= DATEADD( ''MONTH'', 2, CURRENT_DATE)
AND V.ORIGINAL_SOURCE_SYSTEM_ID IN (4,7,17,13,9,3,19,8,16,1,2)
AND b.REVENUE_CATEGORY  NOT IN (''CLS'',''NA'',''CC'') AND PCS.BILLABLE_FLAG = TRUE
;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;

END



 EOT
}

