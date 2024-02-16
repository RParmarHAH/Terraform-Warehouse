resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_ARAUTHENTICARELOG" {
	name ="GET_ARAUTHENTICARELOG"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_ARAuthenticareLog 
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
    COPY INTO GENERATIONSALLIANCE.ARAuthenticareLog FROM (SELECT t.$1 AS ARLogID, t.$2 AS LogDate, t.$3 AS Status, t.$4 AS Errors, t.$5 AS InvoiceID, t.$6 AS InvoiceGroupId, t.$7 AS Details, t.$8 AS LogFileName, t.$9 AS ScheduleId, t.$10 AS ExportedBy, t.$11 AS ExportedOn, t.$12 AS BatchID, t.$13 AS ApiRequest, t.$14 AS ApiResponse, t.$15 AS StateCode, t.$16 AS AuthBatchID, t.$17 AS sftpErrorData, t.$18 AS SYS_CHANGE_VERSION, t.$19 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$19,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_ARAuthenticareLog.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.ARAuthenticareLog AS WITH curr_v AS (SELECT ARLogID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.ARAuthenticareLog GROUP BY ARLogID) SELECT t.* FROM GENERATIONSALLIANCE.ARAuthenticareLog t INNER JOIN curr_v v ON t.ARLogID = v.ARLogID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

