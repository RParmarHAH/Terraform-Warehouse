CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_ETIMEHIST("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_ETimeHist 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.ETimeHist (SELECT t.$1 AS timeHistId, t.$2 AS order_id, t.$3 AS co, t.$4 AS id, t.$5 AS calendarId, t.$6 AS pairedPunchId, t.$7 AS det, t.$8 AS detCode, t.$9 AS hours, t.$10 AS rate, t.$11 AS amount, t.$12 AS beginDate, t.$13 AS endDate, t.$14 AS shift, t.$15 AS cc1, t.$16 AS cc2, t.$17 AS cc3, t.$18 AS cc4, t.$19 AS cc5, t.$20 AS jobCode, t.$21 AS comment, t.$22 AS lastChange, t.$23 AS lastChangeUser, t.$24 AS isMemo, t.$25 AS type, t.$26 AS postDate, t.$27 AS timeUnpaidId, t.$28 AS payToScheduleId, t.$29 AS excludeFromPBJ, t.$30 AS excludeFromPayroll, t.$31 AS SYS_CHANGE_VERSION, t.$32 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$32,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_ETimeHist.*[.]csv.gz'')T);

    return ''Success'';
END;
';