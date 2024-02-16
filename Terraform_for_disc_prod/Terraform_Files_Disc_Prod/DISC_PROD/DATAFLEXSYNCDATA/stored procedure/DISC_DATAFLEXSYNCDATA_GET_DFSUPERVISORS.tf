resource "snowflake_procedure" "DISC_DATAFLEXSYNCDATA_GET_DFSUPERVISORS" {
	name ="GET_DFSUPERVISORS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.GET_DfSupervisors 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.HIST_DfSupervisors FROM (SELECT t.$1 AS DbName, t.$2 AS Code, t.$3 AS Name, t.$4 AS Office, t.$5 AS Teamid, t.$6 AS Payemp_Number, t.$7 AS CreatedDate, t.$8 AS UpdateBatch, t.$9 AS UpdatedTime, t.$10 AS BusinessLine, t.$11 AS SYS_CHANGE_VERSION, t.$12 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$12,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfSupervisors.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfSupervisors AS WITH curr_v AS (SELECT DbName, Code, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfSupervisors GROUP BY DbName, Code) SELECT t.* FROM DataFlexSyncData.HIST_DfSupervisors t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.Code = v.Code AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

