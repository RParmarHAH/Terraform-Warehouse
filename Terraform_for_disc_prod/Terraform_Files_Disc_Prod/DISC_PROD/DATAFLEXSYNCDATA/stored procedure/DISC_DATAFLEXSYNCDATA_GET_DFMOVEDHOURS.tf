resource "snowflake_procedure" "DISC_DATAFLEXSYNCDATA_GET_DFMOVEDHOURS" {
	name ="GET_DFMOVEDHOURS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.GET_DfMovedHours 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.HIST_DfMovedHours FROM (SELECT t.$1 AS DbName, t.$2 AS ReferenceNo, t.$3 AS ClientNumber, t.$4 AS OldContract, t.$5 AS NewContract, t.$6 AS Period, t.$7 AS HoursMoved, t.$8 AS ChangedBy, t.$9 AS ChangedDateTime, t.$10 AS AuditNumber, t.$11 AS BillHoursMoved, t.$12 AS BillAmountMoved, t.$13 AS ClientName, t.$14 AS WriteOff, t.$15 AS ToBeRecouped, t.$16 AS OfficeNumber, t.$17 AS PrevWriteOff, t.$18 AS Recouped, t.$19 AS RecoupWriteOff, t.$20 AS CreatedDate, t.$21 AS UpdateBatch, t.$22 AS UpdatedTime, t.$23 AS SYS_CHANGE_VERSION, t.$24 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$24,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfMovedHours.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfMovedHours AS WITH curr_v AS (SELECT DbName, ReferenceNo, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfMovedHours GROUP BY DbName, ReferenceNo) SELECT t.* FROM DataFlexSyncData.HIST_DfMovedHours t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.ReferenceNo = v.ReferenceNo AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

