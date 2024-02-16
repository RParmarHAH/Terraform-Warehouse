CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_ETIMEAPPROVEDUNPAID("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_ETimeApprovedUnpaid 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.ETimeApprovedUnpaid (SELECT t.$1 AS timeUnpaidId, t.$2 AS co, t.$3 AS id, t.$4 AS calendarId, t.$5 AS det, t.$6 AS detCode, t.$7 AS beginDate, t.$8 AS endDate, t.$9 AS shift, t.$10 AS cc1, t.$11 AS cc2, t.$12 AS cc3, t.$13 AS cc4, t.$14 AS cc5, t.$15 AS jobCode, t.$16 AS comment, t.$17 AS approved, t.$18 AS approvedUser, t.$19 AS lastChange, t.$20 AS lastChangeUser, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_ETimeApprovedUnpaid.*[.]csv.gz'')T);

    return ''Success'';
END;
';