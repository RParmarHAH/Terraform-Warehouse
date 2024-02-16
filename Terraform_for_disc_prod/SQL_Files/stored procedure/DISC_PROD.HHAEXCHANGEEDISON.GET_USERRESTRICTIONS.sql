CREATE OR REPLACE PROCEDURE DISC_PROD.HHAEXCHANGEEDISON.GET_USERRESTRICTIONS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.HHAEXCHANGEEDISON.GET_UserRestrictions 
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
    INSERT OVERWRITE INTO DISC_PROD.HHAEXCHANGEEDISON.UserRestrictions  (SELECT t.$1 AS AgencyID, t.$2 AS RestricatedID, t.$3 AS UserID, t.$4 AS IPRestricted, t.$5 AS HourlyRestricted, t.$6 AS IP1, t.$7 AS IP2, t.$8 AS IP3, t.$9 AS MonFromTime, t.$10 AS MonToTime, t.$11 AS TueFromTime, t.$12 AS TueToTime, t.$13 AS WedFromTime, t.$14 AS WedToTime, t.$15 AS ThuFromTime, t.$16 AS ThuToTime, t.$17 AS FriFromTime, t.$18 AS FriToTime, t.$19 AS SatFromTime, t.$20 AS SatToTime, t.$21 AS SunFromTime, t.$22 AS SunToTime, t.$23 AS MonIP, t.$24 AS TueIP, t.$25 AS WedIP, t.$26 AS ThuIP, t.$27 AS FriIP, t.$28 AS SatIP, t.$29 AS SunIP, t.$30 AS SYS_CHANGE_VERSION, t.$31 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$31,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EDISON/ (file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN => ''.*edisonhomedb_dbo_UserRestrictions.*[.]csv.gz'')T);

    return ''Success'';
END;
';