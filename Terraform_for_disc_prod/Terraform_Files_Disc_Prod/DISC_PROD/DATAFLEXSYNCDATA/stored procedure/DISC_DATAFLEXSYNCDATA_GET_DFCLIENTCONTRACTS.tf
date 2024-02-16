resource "snowflake_procedure" "DISC_DATAFLEXSYNCDATA_GET_DFCLIENTCONTRACTS" {
	name ="GET_DFCLIENTCONTRACTS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.GET_DfClientContracts 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.DataFlexSyncData.HIST_DfClientContracts FROM (SELECT t.$1 AS DbName, t.$2 AS ClientNumber, t.$3 AS ContractCode, t.$4 AS BeginServiceDate, t.$5 AS EndServiceDate, t.$6 AS AuthStatus, t.$7 AS AuthType, t.$8 AS IdNumber, t.$9 AS WeeklyMaxHours, t.$10 AS MonthlyMaxHours, t.$11 AS PayorSource, t.$12 AS BillCodesValues, t.$13 AS AuthorizationValues, t.$14 AS PayRate, t.$15 AS ServiceArea, t.$16 AS OldAuthorizedHours, t.$17 AS CaseNumber, t.$18 AS CaseWorkerManager, t.$19 AS CreatedDate, t.$20 AS UpdateBatch, t.$21 AS UpdatedTime, t.$22 AS DateAdded, t.$23 AS DateChanged, t.$24 AS SYS_CHANGE_VERSION, t.$25 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$25,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/DATAFLEXSYNCDATA/ (PATTERN => ''.*DataFlexSyncData_dbo_DfClientContracts.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE DataFlexSyncData.DfClientContracts AS WITH curr_v AS (SELECT DbName, ClientNumber, ContractCode, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DataFlexSyncData.HIST_DfClientContracts GROUP BY DbName, ClientNumber, ContractCode) SELECT t.* FROM DataFlexSyncData.HIST_DfClientContracts t INNER JOIN curr_v v ON t.DbName = v.DbName AND t.ClientNumber = v.ClientNumber AND t.ContractCode = v.ContractCode AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

