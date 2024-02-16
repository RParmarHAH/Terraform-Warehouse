resource "snowflake_procedure" "DW_HAH_GET_STAGE_CLEARCARE_DIM_SERVICES" {
	name ="GET_STAGE_CLEARCARE_DIM_SERVICES"
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
--*****************************************************************************************************************************
-- NAME: CLEARCARE DIM SERVICES 
--
-- PURPOSE: Populates Stage DIM SERVICES for Clearcare
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 20/010/23	   Sagar Gulghane		 Initial Development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CLEARCARE_DIM_SERVICES 

SELECT DISTINCT  MD5(''CLEARCARE'' || ''-'' || COALESCE(PS.SERVICE_NAME,''UNKNOWN'')   || ''-'' || ''CLEARCARE'') AS SERVICE_KEY,
''16'' AS SOURCE_SYSTEM_ID,
''CLEARCARE'' AS SYSTEM_CODE,
SERVICE_NAME AS service_code,
SERVICE_NAME  AS service_description,
NULL AS SERVICE_TYPE,
CASE WHEN BC.BILL_RATE_METHOD = 1 THEN ''Hourly''
     WHEN BC.BILL_RATE_METHOD = 2 THEN ''Visit''
     WHEN BC.BILL_RATE_METHOD = 3 THEN ''Live-In''
     WHEN BC.BILL_RATE_METHOD = 4 THEN ''Non-Billable'' ELSE ''Hourly''
END AS  SERVICE_RATE_TYPE,
''HC'' AS REVENUE_CATEGORY ,
''HC'' AS REVENUE_SUBCATEGORY_CODE,
''HOME CARE'' AS REVENUE_SUBCATEGORY_NAME,
TRUE AS ACTIVE_FLAG,
 :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
    :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
        CURRENT_USER as ETL_INSERTED_BY,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
        CURRENT_USER as ETL_LAST_UPDATED_BY,
        0 AS ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.CLEARCARE.BILLING_CLIENTAUTHORIZATION BC-- DISC_${var.SF_ENVIRONMENT}.CLEARCARE.PROFILE_PARENTPAYERSERVICE PS
LEFT JOIN  DISC_${var.SF_ENVIRONMENT}.CLEARCARE.PROFILE_PARENTPAYERSERVICE PS --
--(SELECT DISTINCT SERVICE_ID, BILL_RATE_METHOD FROM DISC_${var.SF_ENVIRONMENT}.CLEARCARE.BILLING_CLIENTAUTHORIZATION WHERE BILL_RATE_METHOD IS NOT NULL ) BC
ON PS.ID = BC.SERVICE_ID  
WHERE BC.AGENCY_ID =''2459''  ;
SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
RETURN return_result;

END;


 EOT
}

