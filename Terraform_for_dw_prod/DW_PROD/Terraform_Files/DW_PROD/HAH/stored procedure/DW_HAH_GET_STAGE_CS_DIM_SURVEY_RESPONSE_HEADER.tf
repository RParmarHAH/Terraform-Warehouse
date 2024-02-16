resource "snowflake_procedure" "DW_HAH_GET_STAGE_CS_DIM_SURVEY_RESPONSE_HEADER" {
	name ="GET_STAGE_CS_DIM_SURVEY_RESPONSE_HEADER"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
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
    --*****************************************************************************************************************************
-- NAME:  FACT_SURVEY_RESPONSE_HEADER
--
-- PURPOSE: Insert survey response header
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR             	NOTES:
-- --------    -------------------  ---------------------------------------------------------------------------
-- 09/11/2022  Paras Bhavnani	    Initial DEVelopment
-- 17/11/2022  Paras Bhavnani		Removed the client and employee realted fields except keys
--*****************************************************************************************************************************
--

INSERT OVERWRITE INTO STAGE.CS_DIM_SURVEY_RESPONSE_HEADER 
SELECT
MD5(f.SURVEY_ID ||'' - ''||f.value:responseId::STRING) AS SURVEY_RESPONSE_HEADER_KEY,
MD5(f.SURVEY_ID) AS SURVEY_KEY,
f.SURVEY_ID AS SURVEY_ID,
f.value:values._recordId::STRING AS RECORD_ID,
LOWER(f.value:values.externalDataReference::STRING) AS CLIENT_KEY,
'''' AS EMPLOYEE_KEY,
'''' AS BRANCH_KEY,
'''' AS PARTNER_KEY,
26 AS SOURCE_SYSTEM_ID,
''Qualtrics'' AS SYSTEM_CODE,
f.value:values.status::STRING,
'''' AS progress,
f.value:values.finished::INT AS finished,
f.value:values.recordedDate::TIMESTAMP_NTZ AS DATE_RECORDED, 
f.value:values.startDate::TIMESTAMP_NTZ AS START_DATE, 
f.value:values.endDate::TIMESTAMP_NTZ AS END_DATE, 
0 AS DURATION, 
'''' AS userLanguage, 
'''' AS locationLatitude, 
'''' AS locationLongitude,
'''' AS ipAddress, 
f.value:values.externalDataReference::STRING AS EXTERNALDATAREFERENCE, 
'''' AS distributionChannel, 
 `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_TASK_KEY,
        
    
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_INSERTED_TASK_KEY,
current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE,
CURRENT_USER() AS ETL_INSERTED_BY,
current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE,
CURRENT_USER() AS ETL_LAST_UPDATED_BY,
FALSE AS ETL_DELETED_FLAG
FROM (SELECT * FROM DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_RESPONSE, table(flatten(SURVEY_JSON:responses))) f
JOIN HAH.DIM_SURVEY DS ON f.SURVEY_ID=DS.SURVEY_ID
WHERE f.SURVEY_ID=''SV_eVUEoFMiK0s2ej4'';
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

