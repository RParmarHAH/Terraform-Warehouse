resource "snowflake_procedure" "DW_HAH_GET_STAGE_CENTENE_DIM_CLIENT_BAKUP_02082023" {
	name ="GET_STAGE_CENTENE_DIM_CLIENT_BAKUP_02082023"
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

BEGIN
       --*****************************************************************************************************************************
-- NAME:  CENTENE_DIM_CLIENT
--
-- PURPOSE: Creates one row per client according to CENTENE
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 30/1/2023     AKASH THAKKER         Initial Development
-- 24/5/2023	 AKASH THAKKER		   Changes due to source file format change 

--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CENTENE_DIM_CLIENT
SELECT
     MD5(''CENTENE'' || TRIM(EXTERNAL_ID) || ''-'' || TRIM(FIRST_NAME) || ''-'' || TRIM(LAST_NAME) || ''-'' || ''CENTENE'') AS CLIENT_KEY
	,TRIM(EXTERNAL_ID) AS CLIENT_NUMBER 
    ,''CENTENE'' AS SYSTEM_CODE
    ,27 AS SOURCE_SYSTEM_ID
    ,NULL Client_PID
    ,DATE_OF_BIRTH
    ,NULL CLIENT_DATE_OF_DEATH
    ,NULL Client_GENDER
    ,NULL CLIENT_ETHNICITY
    ,NULL CLIENT_MARITAL_STATUS
    ,NULL CLIENT_SALUTATION
    ,TRIM(FIRST_NAME) AS CLIENT_FIRST_NAME
    ,TRIM(FIRST_NAME) AS  Client_MIDDLE_NAME
    ,TRIM(LAST_NAME) AS CLIENT_LAST_NAME
    ,TRIM(TO_CHAR(LAST_NAME)) || '','' || TRIM(TO_CHAR(FIRST_NAME)) || '','' || TRIM(TO_CHAR(MIDDLE_NAME))  AS CLIENT_NAME
    ,NULL Client_Address1
    ,NULL Client_Address2
    ,CITY Client_City
    ,STATE CLIENT_STATE_CODE
    ,ZIP_CODE AS Client_Zip
	,NULL CLIENT_CLN_ADDRESS1
	,NULL CLIENT_CLN_ADDRESS2
	,NULL CLIENT_CLN_CITY
	,NULL CLIENT_CLN_STATE_CODE
	,NULL CLIENT_CLN_ZIP
	,NULL CLIENT_STD_ADDRESS1
	,NULL CLIENT_STD_ADDRESS2
	,NULL CLIENT_STD_CITY
	,NULL CLIENT_STD_STATE_CODE
	,NULL CLIENT_STD_ZIP
    ,NULL Client_Home_Phone
    ,NULL Client_Cell_Phone
    ,NULL Client_Work_Phone
    ,NULL CLIENT_FAX_NUMBER
	,NULL AS CLIENT_PERSONAL_EMAIL           
    ,NULL REFERRAL_DATE   
    ,NULL DAYS_TO_SERVICE	
	,NULL CONTRACT_BEGIN_DATE     
	,NULL CONTRACT_END_DATE       
    ,NULL FIRST_SERVICE_DATE
    ,NULL LAST_SERVICE_DATE
    ,NULL BEGIN_DATE
    ,NULL END_DATE
    ,NULL ACTIVE_CLIENT_FLAG 
    ,NULL On_Hold_Flag
    ,CAST( NULL AS DATE) AS On_Hold_Start_Date
    ,CAST( NULL AS DATE) AS On_Hold_End_Date
	,NULL ACQUIRED_FROM_COMPANY_KEY       
	,NULL ACQUIRED_FROM_COMPANY_ID
	,NULL ACQUIRED_FROM_COMPANY_FULL_NAME
	,NULL ACQUISITION_DATE  
	,NULL ACQUISITION_FLAG                
	,NULL ADMISSION_DATE                  
	,NULL ADMISSION_FLAG     
	,NULL CLIENT_CONVERTED_FLAG   
	,NULL PRIMARY_SUPERVISOR_KEY          
	,NULL PRIMARY_SUPERVISOR_CODE         
	,NULL PRIMARY_SUPERVISOR_NAME         
	,NULL SECONDARY_SUPERVISOR_KEY        
	,NULL SECONDARY_SUPERVISOR_CODE
	,NULL SECONDARY_SUPERVISOR_NAME
	,NULL PRIMARY_BRANCH_KEY              
	,NULL PRIMARY_BRANCH_NAME             
	,NULL PRIMARY_BRANCH_STATE     
	,NULL GUARANTOR_NAME           
	,NULL NOTES
 	,NULL AGENCY 
 	,MEDICAID_ID
    ,TO_DATE(''1900-01-01'',''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE
    ,TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE
    ,-1 AS ETL_TASK_KEY
	,-1 AS ETL_INSERTED_TASK_KEY
    ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
    ,CURRENT_USER as ETL_INSERTED_BY 
    ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
    ,CURRENT_USER as ETL_LAST_UPDATED_BY
    ,0 as ETL_DELETED_FLAG
    ,0 AS ETL_INFERRED_MEMBER_FLAG
from DISC_${var.SF_ENVIRONMENT}.CENTENE.CENTENE_SOURCE_DATA ;

return '' SUCCESS '';
END;

 EOT
}

