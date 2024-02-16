resource "snowflake_procedure" "DISC_RISKONNECT_GET_VEHICLE" {
	name ="GET_VEHICLE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "RISKONNECT"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.RISKONNECT.GET_VEHICLE 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
--*****************************************************************************************************************************

BEGIN 
    --TargetSQL
    COPY INTO DISC_${var.SF_ENVIRONMENT}.RISKONNECT.HIST_Vehicle FROM  (SELECT T.$1 AS Id,  T.$2 AS OwnerId,  T.$3 AS IsDeleted,  T.$4 AS Name,   REPLACE(T.$5,''T'','' '')::TIMESTAMP_NTZ(9) AS CreatedDate,  T.$6 AS CreatedById,  REPLACE(T.$7,''T'','' '')::TIMESTAMP_NTZ(9) AS LastModifiedDate,  T.$8 AS LastModifiedById,  REPLACE(T.$9,''T'','' '')::TIMESTAMP_NTZ(9) AS SystemModstamp,  T.$10 AS LastActivityDate,  T.$11 AS LastViewedDate,  T.$12 AS LastReferencedDate,  T.$13 AS ConnectionReceivedId,  T.$14 AS ConnectionSentId, T.$15 AS Body_Type__c,  T.$16 AS Color__c,  T.$17 AS Driver__c,  T.$18 AS Fair_Market_Value__c,  T.$19 AS Fleet_Number__c,  T.$20 AS Gross_Weight__c,  T.$21 AS ID_Prior__c,    T.$22 AS Lessor__c,  T.$23 AS Make__c,  T.$24 AS Model__c,  T.$25 AS Net_Book_Value__c,  T.$26 AS Ownership__c,  T.$27 AS Photo__c,  T.$28 AS Plate_Number__c, T.$29 AS Policy_Section__c,  T.$30 AS Policy__c,  T.$31 AS Property__c,  T.$32 AS Registration_Renewal_Date__c,  T.$33 AS State_DMV__c,  T.$34 AS Total_Cost__c,  T.$35 AS Vehicle_Plate_State__c,  T.$36 AS Vehicle_Type__c,  T.$37 AS Vin__c,  T.$38 AS Year_Safety_Inspection__c,  T.$39 AS Year__c,  T.$40 AS Search_Display__c, T.$41 AS Location_Branch__c,  T.$42 AS Vehicle_is_garaged_at__c,  T.$43 AS Branch_verified__c,  T.$44 AS Insurance_Card_Contact__c,  T.$45 AS Lease_Start_Date__c, T.$46 AS Lease_Expiration_Date__c,  T.$47 AS Change_reason__c,  T.$48 AS Lease__c,  T.$49 AS Notes__c,  T.$50 AS Active__c,  T.$51 AS Region__c,  T.$52 AS Leasing_Company__c, T.$53 AS Fleet_Vehicle__c,  T.$54 AS Populates_date_for_Letters__c,  T.$55 AS Clean_up__c,  T.$56 AS Insurance_Card_Contact_Email__c,  T.$57 AS Request_New_Insurance_Card__c, T.$58 AS Coverage_End_Date__c,  T.$59 AS Coverage_start_date__c,  T.$60 AS Wheelchair_lift__c,  T.$61 AS Velcor_Asset__c,  T.$62 AS DL__c,  T.$63 AS Date_of_Birth__c, T.$64 AS DL_State__c, -1 AS ETL_TASK_KEY, -1 AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG  FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Riskonnect/Daily_data (file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.CSV_FORMAT_UTF8_FALSE,PATTERN => ''.*Vehicle_.*[.]csv'')T);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.RISKONNECT.Vehicle AS SELECT ID,  OWNERID,  ISDELETED,  NAME,  CREATEDDATE,  CREATEDBYID,  LASTMODIFIEDDATE,  LASTMODIFIEDBYID,  SYSTEMMODSTAMP,  LASTACTIVITYDATE,  LASTVIEWEDDATE,  LASTREFERENCEDDATE,  CONNECTIONRECEIVEDID,  CONNECTIONSENTID,  BODY_TYPE__C,  COLOR__C,  DRIVER__C,  FAIR_MARKET_VALUE__C,  FLEET_NUMBER__C,  GROSS_WEIGHT__C,  ID_PRIOR__C,  LESSOR__C,  MAKE__C,  MODEL__C,  NET_BOOK_VALUE__C,  OWNERSHIP__C,  PHOTO__C,  PLATE_NUMBER__C,  POLICY_SECTION__C,  POLICY__C,  PROPERTY__C,  REGISTRATION_RENEWAL_DATE__C,  STATE_DMV__C,  TOTAL_COST__C,  VEHICLE_PLATE_STATE__C,  VEHICLE_TYPE__C,  VIN__C,  YEAR_SAFETY_INSPECTION__C,  YEAR__C,  SEARCH_DISPLAY__C,  LOCATION_BRANCH__C,  VEHICLE_IS_GARAGED_AT__C,  BRANCH_VERIFIED__C,  INSURANCE_CARD_CONTACT__C,  LEASE_START_DATE__C,  LEASE_EXPIRATION_DATE__C,  CHANGE_REASON__C,  LEASE__C,  NOTES__C,  ACTIVE__C,  REGION__C,  LEASING_COMPANY__C,  FLEET_VEHICLE__C,  POPULATES_DATE_FOR_LETTERS__C,  CLEAN_UP__C,  INSURANCE_CARD_CONTACT_EMAIL__C,  REQUEST_NEW_INSURANCE_CARD__C,  COVERAGE_END_DATE__C,  COVERAGE_START_DATE__C,  WHEELCHAIR_LIFT__C,  VELCOR_ASSET__C,  DL__C,  DATE_OF_BIRTH__C,  DL_STATE__C, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM DISC_${var.SF_ENVIRONMENT}.RISKONNECT.HIST_Vehicle WHERE (ID,ETL_LAST_UPDATED_DATE) IN (SELECT ID,MAX(ETL_LAST_UPDATED_DATE) FROM DISC_${var.SF_ENVIRONMENT}.RISKONNECT.HIST_Vehicle GROUP BY ID);

    return ''Success'';
END;

 EOT
}

