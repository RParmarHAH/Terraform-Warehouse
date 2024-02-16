CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_STAGE_PATIENTAUTHORIZATION("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_stage_PatientAuthorization 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.stage_PatientAuthorization (SELECT t.$1 AS AgencyID, t.$2 AS PatientID, t.$3 AS AuthorizationID, t.$4 AS ContractID, t.$5 AS AuthorizationNumber, t.$6 AS FromDate, t.$7 AS ToDate, t.$8 AS Discipline, t.$9 AS ServiceCodeID, t.$10 AS Type, t.$11 AS MaxUnitsFORAuth, t.$12 AS Period, t.$13 AS BankedHours, t.$14 AS SatHours, t.$15 AS SunHours, t.$16 AS MonHours, t.$17 AS TueHours, t.$18 AS WedHours, t.$19 AS ThuHours, t.$20 AS FriHours, t.$21 AS MaxUnitsFORPeriod, t.$22 AS Notes, t.$23 AS RemainingUnits, t.$24 AS ModifiedDate, t.$25 AS IsDeleted, t.$26 AS AuthAttachment, t.$27 AS ServiceTypeID, t.$28 AS SYS_CHANGE_VERSION, t.$29 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$29,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_stage_PatientAuthorization.*[.]csv.gz'') T);

    return ''Success'';
END;
';