CREATE OR REPLACE PROCEDURE DISC_PROD.EMPEONEDISON.GET_EACCRUALBANK("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.EmpeonEdison.GET_EAccrualBank 
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
    INSERT OVERWRITE INTO DISC_PROD.EmpeonEdison.EAccrualBank (SELECT t.$1 AS id, t.$2 AS co, t.$3 AS bankCode, t.$4 AS startDate, t.$5 AS endDate, t.$6 AS currentUsed, t.$7 AS totalBalance, t.$8 AS currentAccrued, t.$9 AS override1, t.$10 AS override2, t.$11 AS override3, t.$12 AS guidfield, t.$13 AS lastChange, t.$14 AS lastChangeUser, t.$15 AS availableBalance, t.$16 AS accrualMaxOverride, t.$17 AS balanceMaxOverride, t.$18 AS capHoursOverride, t.$19 AS carryoverOverride, t.$20 AS rateOverride, t.$21 AS usageMaxOverride, t.$22 AS overrideStrategy, t.$23 AS SYS_CHANGE_VERSION, t.$24 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$24,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONEDISON/(file_format => DISC_PROD.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonEdison_dbo_EAccrualBank.*[.]csv.gz'')T);

    return ''Success'';
END;
';