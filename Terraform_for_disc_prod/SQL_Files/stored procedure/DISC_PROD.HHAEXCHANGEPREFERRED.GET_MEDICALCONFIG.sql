CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEPREFERRED.GET_MEDICALCONFIG("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEPREFERRED.GET_MedicalConfig 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEPREFERRED.MedicalConfig (SELECT t.$1 AS AgencyID, t.$2 AS OfficeID, t.$3 AS ComplianceSetupID, t.$4 AS ComplianceSetupName, t.$5 AS MedicalConfigID, t.$6 AS MedicalID, t.$7 AS MedicalName, t.$8 AS Result, t.$9 AS Required, t.$10 AS ExpirationItemType, t.$11 AS Status, t.$12 AS Discipline, t.$13 AS SYS_CHANGE_VERSION, t.$14 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$14,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/PREFERRED/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEPREFERRED_dbo_MedicalConfig.*[.]csv.gz'')T WHERE t.$1 IN (243, 371));

    return ''Success'';
END;
';