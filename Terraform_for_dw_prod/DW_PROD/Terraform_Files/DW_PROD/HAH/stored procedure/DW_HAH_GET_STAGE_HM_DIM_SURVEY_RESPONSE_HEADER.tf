resource "snowflake_procedure" "DW_HAH_GET_STAGE_HM_DIM_SURVEY_RESPONSE_HEADER" {
	name ="GET_STAGE_HM_DIM_SURVEY_RESPONSE_HEADER"
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
-- 04/11/2022  Paras Bhavnani	    Initial DEVelopment
-- 17/11/2022  Paras Bhavnani		Removed the client and employee realted fields except keys
--*****************************************************************************************************************************
--

INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.HM_DIM_SURVEY_RESPONSE_HEADER
WITH BRANCH_DETAIL AS(
SELECT DETAILED_OFFICE_NAME,ORIGINAL_BRANCH_KEY FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.DIM_BRANCH_MERGED
WHERE ORIGINAL_BRANCH_KEY=BRANCH_KEY
AND SOURCE_SYSTEM_ID IN (1,2,3,4,7,8,9,17,16,15,13,14,19)
)  
SELECT
MD5(f.value:values.SurveyID::STRING||'' - ''||f.value:responseId::STRING) AS SURVEY_RESPONSE_HEADER_KEY,
MD5(f.value:values.SurveyID::STRING) AS SURVEY_KEY,
f.value:values.SurveyID::STRING AS SURVEY_ID,
f.value:values._recordId::STRING AS RECORD_ID,
f.value:values.CLIENT_KEY::STRING AS CLIENT_KEY,
f.value:values.EMPLOYEE_KEY::STRING AS EMPLOYEE_KEY,
BD.ORIGINAL_BRANCH_KEY AS BRANCH_KEY,
DP.PARTNER_KEY AS PARTNER_KEY,
26 AS SOURCE_SYSTEM_ID,
''Qualtrics'' AS SYSTEM_CODE,
f.value:values.status::STRING,
f.value:values.progress::STRING,
f.value:values.finished::INT,
f.value:values.recordedDate::TIMESTAMP_NTZ, 
f.value:values.startDate::TIMESTAMP_NTZ, 
f.value:values.endDate::TIMESTAMP_NTZ, 
f.value:values.duration, 
f.value:values.userLanguage::STRING, 
f.value:values.locationLatitude::STRING, 
f.value:values.locationLongitude::STRING,
f.value:values.ipAddress::STRING, 
f.value:values.externalDataReference::STRING, 
f.value:values.distributionChannel::STRING, 
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
JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_SURVEY DS ON f.SURVEY_ID=DS.SURVEY_ID
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_PARTNER DP ON f.value:values.PROGRAM_ID::STRING = DP.PARTNER_CODE
LEFT JOIN BRANCH_DETAIL BD ON f.value:values.PARENT_BRANCH_NAME::STRING = BD.DETAILED_OFFICE_NAME
WHERE f.SURVEY_ID=''SV_9R11KQoz9btyWto''
AND f.value:values.CLIENT_KEY::STRING IS NOT NULL;
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

