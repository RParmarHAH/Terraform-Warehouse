resource "snowflake_procedure" "DW_HAH_GET_STAGE_OLYMPUS_DIM_CLIENT" {
	name ="GET_STAGE_OLYMPUS_DIM_CLIENT"
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
-- NAME:  OLYMPUS_DIM_CLIENT
--
-- PURPOSE: Creates one row per client according to Olympus
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 04/10/2022     Mohan kewlani         Initial Development
-- 11/08/2023	  Shikhar Saxena 		Updated CLIENT_ETHNICITY logic and added HISPANIC_OR_LATINO column
--*****************************************************************************************************************************

INSERT OVERWRITE INTO  STAGE.OLYMPUS_DIM_CLIENT
SELECT
     md5(  ''OSH''  ||  ''-''  ||C.PATIENT_ID|| ''-''  ||  ''OLYMPUS'' ) AS CLIENT_KEY
    ,PATIENT_ID AS CLIENT_NUMBER
    ,''OSH'' AS SYSTEM_CODE
    ,24 AS SOURCE_SYSTEM_ID
    ,NULL Client_PID
    ,C.DATEOFBIRTH AS Client_DOB
   ,NULL CLIENT_DATE_OF_DEATH
   ,NULL Client_Gender
    ,NULL CLIENT_ETHNICITY
	,FALSE AS HISPANIC_OR_LATINO
     ,NULL CLIENT_MARITAL_STATUS
     ,NULL CLIENT_SALUTATION
    ,C.FIRSTNAME AS Client_First_Name
    ,NULL Client_Middle_Name
    ,C.LASTNAME AS Client_Last_Name
    ,TO_CHAR(C.LASTNAME) || '','' || TO_CHAR(C.FIRSTNAME)  AS CLIENT_NAME
    ,NULL Client_Address1
    ,NULL Client_Address2
    ,NULL Client_City
    ,NULL CLIENT_STATE_CODE
    ,C.ZIPCODE AS Client_Zip
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
    ,NULL  REFERRAL_DATE   
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
	,LOADDATE ADMISSION_DATE                  
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
    ,TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE
    ,TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE	    
   -- ,coord.CURRENT_SUPERVISOR_CODE AS CURRENT_SUPERVISOR_CODE
   -- ,coord.CURRENT_SUPERVISOR_NAME AS CURRENT_SUPERVISOR_NAME 
    --- ETL FIELDS ---
    ,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
	,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
    ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
    ,CURRENT_USER as ETL_INSERTED_BY 
    ,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
    ,CURRENT_USER as ETL_LAST_UPDATED_BY
    ,0 as ETL_DELETED_FLAG
    ,0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.OLYMPUS.OLYMPUS_SOURCE_DATA C WHERE C.LOADDATE =(SELECT MAX(LOADDATE) FROM  DISC_${var.SF_ENVIRONMENT}.OLYMPUS.OLYMPUS_SOURCE_DATA)
;
RETURN ''SUCCESS'';
END;

 EOT
}

