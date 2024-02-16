CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_PATIENTSTATUSCHANGEACTIVITY("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_PatientStatusChangeActivity 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.PatientStatusChangeActivity (SELECT t.$1 AS AgencyID, t.$2 AS StatusActivityID, t.$3 AS ChhaID, t.$4 AS Contract, t.$5 AS PatientID, t.$6 AS AdmissionID, t.$7 AS PatientName, t.$8 AS StatusID, t.$9 AS PatientStatusName, t.$10 AS StatusChangeDate, t.$11 AS Coordinators, t.$12 AS SYS_CHANGE_VERSION, t.$13 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$13,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (PATTERN => ''.*edisonhomedb_dbo_PatientStatusChangeActivity.*[.]csv.gz'', FILE_FORMAT =>DISC_PROD.STAGE.MY_CSV_FORMAT)T);

    return ''Success'';
END;
';