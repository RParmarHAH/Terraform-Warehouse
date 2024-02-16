resource "snowflake_procedure" "DISC_GPSYNCDATA_GET_PAYSTUB_DETAILLINE" {
	name ="GET_PAYSTUB_DETAILLINE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GpSyncData.GET_PayStub_DetailLine 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.GpSyncData.HIST_PayStub_DetailLine FROM (SELECT t.$1 AS DetailLineId, t.$2 AS CheckId, t.$3 AS PayCode, t.$4 AS CodeTypes, t.$5 AS Rate, t.$6 AS Units, t.$7 AS Amount, t.$8 AS AmountYTD, t.$9 AS Descriptions, t.$10 AS IsReimbursement, t.$11 AS IsUnionDue, t.$12 AS IsTax, t.$13 AS IsWage, t.$14 AS IsHistory, t.$15 AS IsHidingRate, t.$16 AS SYS_CHANGE_VERSION, t.$17 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$17,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GPSYNCDATA/ (PATTERN => ''.*GpSyncData_dbo_PayStub_DetailLine.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GpSyncData.PayStub_DetailLine AS WITH curr_v AS (SELECT DetailLineId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GpSyncData.HIST_PayStub_DetailLine GROUP BY DetailLineId) SELECT t.* FROM GpSyncData.HIST_PayStub_DetailLine t INNER JOIN curr_v v ON t.DetailLineId = v.DetailLineId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

