CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_APPLICATIONDETAILS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_ApplicationDetails 
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
    COPY INTO GENERATIONSALLIANCE.ApplicationDetails FROM (SELECT t.$1 AS Id, t.$2 AS AppId, t.$3 AS HaveCar, t.$4 AS NoCarOption, t.$5 AS DrivingLiscense, t.$6 AS LicenseExpiration, t.$7 AS WeeklyWorkingHours, t.$8 AS WorkAtNight, t.$9 AS WorkAtWeekends, t.$10 AS WillingLiveIn, t.$11 AS EmploymentDesired, t.$12 AS LegallyAuthorized, t.$13 AS AvailiableStartDate, t.$14 AS TimeNotWorking, t.$15 AS Certifications, t.$16 AS Companionship, t.$17 AS Dressing, t.$18 AS MealPreparation, t.$19 AS Transferring, t.$20 AS Housekeeping, t.$21 AS IncontinenceCare, t.$22 AS Bathing, t.$23 AS Dementia, t.$24 AS AdditionalSkills, t.$25 AS SubmittedDate, t.$26 AS Imported, t.$27 AS Hidden, t.$28 AS ClassName, t.$29 AS EO_Disclaimers, t.$30 AS SYS_CHANGE_VERSION, t.$31 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$31,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_ApplicationDetails.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.ApplicationDetails AS WITH curr_v AS (SELECT Id, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.ApplicationDetails GROUP BY Id) SELECT t.* FROM GENERATIONSALLIANCE.ApplicationDetails t INNER JOIN curr_v v ON t.Id = v.Id AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';