CREATE OR REPLACE PROCEDURE DISC_PROD.RISKONNECT.GET_CLIENT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.RISKONNECT.GET_CLIENT 
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
    COPY INTO DISC_PROD.RISKONNECT.HIST_Client FROM ( SELECT T.$1 AS Id, T.$2 AS OwnerId, T.$3 AS IsDeleted, T.$4 AS NAME, REPLACE(T.$5,''T'','' '')::TIMESTAMP_NTZ(9) AS CreatedDate, T.$6 AS CreatedById,REPLACE(T.$7,''T'','' '')::TIMESTAMP_NTZ(9) AS LastModifiedDate, T.$8 AS LastModifiedById, REPLACE(T.$9,''T'','' '')::TIMESTAMP_NTZ(9) AS SystemModstamp, T.$10 AS LastActivityDate, T.$11 AS LastViewedDate, T.$12 AS LastReferencedDate, T.$13 AS ConnectionReceivedId, T.$14 AS ConnectionSentId, T.$15 AS Supervisor__c, T.$16 AS Zip_Code__c, T.$17 AS Social_Security_Number__c, T.$18 AS Birth_Date__c, T.$19 AS Begin_Service_Date__c,T.$20 AS Phone_Number__c, T.$21 AS Active__c, T.$22 AS IDOA_ID__c, T.$23 AS Contracts__c, T.$24 AS Last_Visit_Date__c, T.$25 AS X2nd_Phone__c,T.$26 AS End_Service__c, T.$27 AS Gender__c, T.$28 AS Diagnosis__c, T.$29 AS Notes__c, T.$30 AS Client_Name3__c, -1 AS ETL_TASK_KEY, -1 AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY,0 AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Riskonnect/Daily_data (file_format => DISC_PROD.STAGE.CSV_FORMAT_UTF8_FALSE,PATTERN => ''.*Client_.*[.]csv'')T );

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_PROD.RISKONNECT.Client AS SELECT ID,OWNERID,ISDELETED,NAME,CREATEDDATE,CREATEDBYID,LASTMODIFIEDDATE,LASTMODIFIEDBYID,SYSTEMMODSTAMP,LASTACTIVITYDATE,LASTVIEWEDDATE,LASTREFERENCEDDATE,CONNECTIONRECEIVEDID,CONNECTIONSENTID,SUPERVISOR__C,ZIP_CODE__C,SOCIAL_SECURITY_NUMBER__C,BIRTH_DATE__C,BEGIN_SERVICE_DATE__C,PHONE_NUMBER__C,ACTIVE__C,IDOA_ID__C,CONTRACTS__C,LAST_VISIT_DATE__C,X2ND_PHONE__C,END_SERVICE__C,GENDER__C,DIAGNOSIS__C,NOTES__C,CLIENT_NAME3__C,:TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM DISC_PROD.RISKONNECT.HIST_Client  WHERE (ID,ETL_LAST_UPDATED_DATE) IN (SELECT ID,MAX(ETL_LAST_UPDATED_DATE) FROM DISC_PROD.RISKONNECT.HIST_Client GROUP BY ID);

    return ''Success'';
END;
';