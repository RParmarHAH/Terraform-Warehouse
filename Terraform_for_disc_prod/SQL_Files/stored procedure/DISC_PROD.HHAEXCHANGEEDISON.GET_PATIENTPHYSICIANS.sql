CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_PATIENTPHYSICIANS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_PatientPhysicians 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.PatientPhysicians  (SELECT t.$1 AS AgencyID, t.$2 AS PatientPhysicianID, t.$3 AS PatientID, t.$4 AS PhysicianID, t.$5 AS MDName, t.$6 AS MDPhone, t.$7 AS MDAddress, t.$8 AS IsPrimary, t.$9 AS Note, t.$10 AS PhysicianNPI, t.$11 AS CreatedBy, t.$12 AS CreatedDate, t.$13 AS UpdatedBy, t.$14 AS UpdatedDate, t.$15 AS Address1, t.$16 AS Address2, t.$17 AS City, t.$18 AS State, t.$19 AS Zip, t.$20 AS SYS_CHANGE_VERSION, t.$21 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$21,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_PatientPhysicians.*[.]csv.gz'')T);

    return ''Success'';
END;
';