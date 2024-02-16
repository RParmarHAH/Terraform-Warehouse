CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_EPAIREDPUNCH("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_EPairedPunch 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.EPairedPunch (SELECT t.$1 AS pairedPunchId, t.$2 AS co, t.$3 AS id, t.$4 AS calendarId, t.$5 AS postDate, t.$6 AS inRawPunch, t.$7 AS outRawPunch, t.$8 AS shift, t.$9 AS cc1, t.$10 AS cc2, t.$11 AS cc3, t.$12 AS cc4, t.$13 AS cc5, t.$14 AS jobCode, t.$15 AS comment, t.$16 AS lastChange, t.$17 AS lastChangeUser, t.$18 AS totalMinutes, t.$19 AS voidId, t.$20 AS voidedId, t.$21 AS adjustment, t.$22 AS excludeFromPayroll, t.$23 AS amount, t.$24 AS detCode, t.$25 AS rate, t.$26 AS SYS_CHANGE_VERSION, t.$27 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$27,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_EPairedPunch.*[.]csv.gz'')T);

    return ''Success'';
END;
';