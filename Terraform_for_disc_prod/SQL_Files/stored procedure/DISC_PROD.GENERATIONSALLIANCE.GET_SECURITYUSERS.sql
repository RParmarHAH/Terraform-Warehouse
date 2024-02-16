CREATE OR REPLACE PROCEDURE DISC_PROD.GENERATIONSALLIANCE.GET_SECURITYUSERS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.GENERATIONSALLIANCE.GET_securityUsers 
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
    COPY INTO GENERATIONSALLIANCE.securityUsers FROM (SELECT t.$1 AS userName, t.$2 AS userPassword, t.$3 AS enabled, t.$4 AS str_email, t.$5 AS bit_allClass, t.$6 AS bit_allLocation, t.$7 AS UserType, t.$8 AS UserReferenceID, t.$9 AS IncorrectAttempts, t.$10 AS LastFailedAttempt, t.$11 AS passwordResetTime, t.$12 AS UserLanguage, t.$13 AS SantraxNotification, t.$14 AS AppRegId, t.$15 AS HHAXNotification, t.$16 AS bit_MissedVisitNotification, t.$17 AS UserPasswordStrong, t.$18 AS TouchIdToken, t.$19 AS CreatedBy, t.$20 AS UpdatedBy, t.$21 AS Created, t.$22 AS LastUpdated, t.$23 AS DisabledDateTime, t.$24 AS DisabledReason, t.$25 AS DisabledDueToPasswordAttempts, t.$26 AS IsMissedVisitAppNotificationEnabled, t.$27 AS IsMissedVisitTextMessageEnabled, t.$28 AS IsMissedVisitEmailEnabled, t.$29 AS SendCGLogInLogOutAppNotification, t.$30 AS ForcePasswordChange, t.$31 AS usesEnhancedPasswordHash, t.$32 AS SYS_CHANGE_VERSION, t.$33 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$33,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_securityUsers.*[.]csv.gz'' , FILE_FORMAT=>DISC_PROD.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.securityUsers AS WITH curr_v AS (SELECT userName, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.securityUsers GROUP BY userName) SELECT t.* FROM GENERATIONSALLIANCE.securityUsers t INNER JOIN curr_v v ON t.userName = v.userName AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;
';