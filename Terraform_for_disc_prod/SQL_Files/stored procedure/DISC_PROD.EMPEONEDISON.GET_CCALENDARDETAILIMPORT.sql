CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_CCALENDARDETAILIMPORT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_CCalendarDetailImport 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.CCalendarDetailImport (SELECT t.$1 AS co, t.$2 AS calendarId, t.$3 AS batch, t.$4 AS payType, t.$5 AS serviceGUID, t.$6 AS job, t.$7 AS queuedUser, t.$8 AS queuedTime, t.$9 AS state, t.$10 AS notes, t.$11 AS guidfield, t.$12 AS lastChange, t.$13 AS lastChangeUser, t.$14 AS importProps, t.$15 AS importFileName, t.$16 AS importFileSize, t.$17 AS importFileCreationDate, t.$18 AS SYS_CHANGE_VERSION, t.$19 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$19,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/EmpeonEdison_dbo_CCalendarDetailImport.csv.gz(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT)T);

    return ''Success'';
END;
';