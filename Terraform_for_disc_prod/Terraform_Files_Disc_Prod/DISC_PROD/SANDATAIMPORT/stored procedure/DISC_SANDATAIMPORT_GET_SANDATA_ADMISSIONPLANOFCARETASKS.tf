resource "snowflake_procedure" "DISC_SANDATAIMPORT_GET_SANDATA_ADMISSIONPLANOFCARETASKS" {
	name ="GET_SANDATA_ADMISSIONPLANOFCARETASKS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.SandataImport.GET_Sandata_AdmissionPlanOfCareTasks 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.SandataImport.HIST_Sandata_AdmissionPlanOfCareTasks FROM (SELECT t.$1 AS ID, t.$2 AS agencyID, t.$3 AS phID, t.$4 AS admissionID, t.$5 AS ServiceID, t.$6 AS BeginDate, t.$7 AS EndDate, t.$8 AS PlanID, t.$9 AS TaskID, t.$10 AS DaysperWeek, t.$11 AS Sun, t.$12 AS Mon, t.$13 AS Tue, t.$14 AS Wed, t.$15 AS Thu, t.$16 AS Fri, t.$17 AS Sat, t.$18 AS CreatedAt, t.$19 AS UpdatedAt, t.$20 AS HashedRowValues, t.$21 AS BatchId, t.$22 AS SYS_CHANGE_VERSION, t.$23 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$23,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/SANDATAIMPORT/ (PATTERN => ''.*SandataImport_Sandata_AdmissionPlanOfCareTasks.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE SandataImport.Sandata_AdmissionPlanOfCareTasks AS WITH curr_v AS (SELECT ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM SandataImport.HIST_Sandata_AdmissionPlanOfCareTasks GROUP BY ID) SELECT t.* FROM SandataImport.HIST_Sandata_AdmissionPlanOfCareTasks t INNER JOIN curr_v v ON t.ID = v.ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

