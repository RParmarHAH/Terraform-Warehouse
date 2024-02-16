CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_ERAWPUNCH("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_ERawPunch 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.ERawPunch (SELECT t.$1 AS rawPunchId, t.$2 AS ignored, t.$3 AS co, t.$4 AS id, t.$5 AS clockNumber, t.$6 AS deviceId, t.$7 AS calendarId, t.$8 AS type, t.$9 AS source, t.$10 AS utcTime, t.$11 AS origUtcTime, t.$12 AS origLocalTime, t.$13 AS latitude, t.$14 AS longitude, t.$15 AS accuracy, t.$16 AS shift, t.$17 AS cc1, t.$18 AS cc2, t.$19 AS cc3, t.$20 AS cc4, t.$21 AS cc5, t.$22 AS jobCode, t.$23 AS comment, t.$24 AS lastChange, t.$25 AS lastChangeUser, t.$26 AS localTime, t.$27 AS origTimeOffset, t.$28 AS timeOffset, t.$29 AS origTimeZoneId, t.$30 AS timeZoneId, t.$31 AS punchDate, t.$32 AS draggedTime, t.$33 AS draggedUser, t.$34 AS origType, t.$35 AS custom1, t.$36 AS custom2, t.$37 AS custom3, t.$38 AS custom4, t.$39 AS custom5, t.$40 AS custom6, t.$41 AS custom7, t.$42 AS isVoid, t.$43 AS amount, t.$44 AS detCode, t.$45 AS mealNotTaken, t.$46 AS rate, t.$47 AS SYS_CHANGE_VERSION, t.$48 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$48,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_ERawPunch.*[.]csv.gz'')T);

    return ''Success'';
END;
';