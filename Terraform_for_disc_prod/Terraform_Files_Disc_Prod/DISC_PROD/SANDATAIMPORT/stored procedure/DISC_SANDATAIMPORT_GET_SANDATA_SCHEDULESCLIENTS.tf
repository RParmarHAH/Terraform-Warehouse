resource "snowflake_procedure" "DISC_SANDATAIMPORT_GET_SANDATA_SCHEDULESCLIENTS" {
	name ="GET_SANDATA_SCHEDULESCLIENTS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  GET_SANDATA_SCHEDULESCLIENTS 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- ----------  -------------------   -----------------------------------------------------------------------------------------------
-- 2023-11-20 RAVI SUTHAR            INITIAL DEVELOPMENT
--*****************************************************************************************************************************
 
--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.SandataImport.GET_Sandata_SchedulesClients 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.SandataImport.HIST_Sandata_SchedulesClients FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS ScheduleID, t.$4 AS ClientSchedHdrID, t.$5 AS ClientSchedDtlID, t.$6 AS AdmissionID, t.$7 AS EventID, t.$8 AS AuthorizationID, t.$9 AS UnitType, t.$10 AS Status, t.$11 AS Rate, t.$12 AS Amount, t.$13 AS Copay, t.$14 AS Duration, t.$15 AS sedUnits, t.$16 AS ConsumptionDate, t.$17 AS CreatedAt, t.$18 AS UpdatedAt, t.$19 AS HashedRowValues, t.$20 AS BatchId, t.$21 AS SYS_CHANGE_VERSION, t.$22 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$22,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/SandataImport_Sandata_SchedulesClients.csv.gz (FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_SchedulesClients AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_SchedulesClients GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_SchedulesClients t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

