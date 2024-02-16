CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CALLMAINTENANCE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_CallMaintenance 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CallMaintenance (SELECT t.$1 AS AgencyID, t.$2 AS OfficeID, t.$3 AS MaintenanceID, t.$4 AS AideID, t.$5 AS AssignmentID, t.$6 AS CallerID, t.$7 AS DialedNumber, t.$8 AS CallType, t.$9 AS CallTime, t.$10 AS CallDuration, t.$11 AS Status, t.$12 AS DutySheet, t.$13 AS Duties, t.$14 AS CallUniqueID, t.$15 AS EVVSource, t.$16 AS EVVType, t.$17 AS EVVDeviceID, t.$18 AS EVVTokenID, t.$19 AS EVVCallTime, t.$20 AS EVVPatientId, t.$21 AS GPSDistance, t.$22 AS ModifiedDate, t.$23 AS SYS_CHANGE_VERSION, t.$24 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$24,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_CallMaintenance.*[.]csv.gz'') T);

    return ''Success'';
END;
';