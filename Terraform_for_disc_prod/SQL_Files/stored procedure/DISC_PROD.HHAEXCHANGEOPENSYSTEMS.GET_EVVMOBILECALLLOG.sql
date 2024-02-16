CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_EVVMOBILECALLLOG("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.GET_EVVMobileCallLog 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEOPENSYSTEMS.EVVMobileCallLog (SELECT t.$1 AS AgencyID, t.$2 AS VisitCallDetailsID, t.$3 AS VisitID, t.$4 AS CaregiverID, t.$5 AS UniqueMobileID, t.$6 AS CallTime, t.$7 AS CallType, t.$8 AS CallUTCTime, t.$9 AS EVVSource, t.$10 AS EVVType, t.$11 AS FOBDisplayNumber, t.$12 AS AssignmentID, t.$13 AS Longitude, t.$14 AS Latitude, t.$15 AS CreatedDate, t.$16 AS SYS_CHANGE_VERSION, t.$17 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$17,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/OPENSYSTEMS/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*HHAEXCHANGEOPENSYSTEMS_dbo_EVVMobileCallLog.*[.]csv.gz'') T);

    return ''Success'';
END;
';