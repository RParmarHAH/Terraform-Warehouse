resource "snowflake_procedure" "DISC_EMPEONPREFERRED_GET_ESCHEDULEOVERRIDE" {
	name ="GET_ESCHEDULEOVERRIDE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.GET_EScheduleOverride 
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
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.EmpeonPreferred.EScheduleOverride (SELECT t.$1 AS scheduleOverridId, t.$2 AS co, t.$3 AS id, t.$4 AS postDate, t.$5 AS start_date, t.$6 AS end_date, t.$7 AS duration, t.$8 AS marginBefore, t.$9 AS marginAfter, t.$10 AS offDay, t.$11 AS cc1, t.$12 AS cc2, t.$13 AS cc3, t.$14 AS cc4, t.$15 AS cc5, t.$16 AS jobCode, t.$17 AS shift, t.$18 AS lastChange, t.$19 AS lastChangeUser, t.$20 AS callOutReason, t.$21 AS onCall, t.$22 AS graceAfter, t.$23 AS graceBefore, t.$24 AS lunch, t.$25 AS SYS_CHANGE_VERSION, t.$26 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$26,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/EMPEONPREFERRED/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT,PATTERN =>''.*EmpeonPreferred_dbo_EScheduleOverride.*[.]csv.gz'')T);

    --ViewSQL
    CREATE OR REPLACE TABLE EmpeonPreferred.EScheduleOverride AS WITH curr_v AS (SELECT scheduleOverridId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM EmpeonPreferred.EScheduleOverride GROUP BY scheduleOverridId) SELECT t.* FROM EmpeonPreferred.EScheduleOverride t INNER JOIN curr_v v ON t.scheduleOverridId = v.scheduleOverridId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

