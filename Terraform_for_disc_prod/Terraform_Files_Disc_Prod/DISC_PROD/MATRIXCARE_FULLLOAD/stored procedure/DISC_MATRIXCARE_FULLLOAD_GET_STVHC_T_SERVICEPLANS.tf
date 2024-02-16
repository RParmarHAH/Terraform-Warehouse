resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_SERVICEPLANS" {
	name ="GET_STVHC_T_SERVICEPLANS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ServicePlans 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ServicePlans FROM (SELECT t.$1 AS svcplan_ID, t.$2 AS svcplan_AdmissionID, t.$3 AS svcplan_POCID, t.$4 AS svcplan_ServicePlanTasksID, t.$5 AS svcplan_Notes, t.$6 AS svcplan_CreatedDate, t.$7 AS svcplan_CreatedUser, t.$8 AS svcplan_ModifiedDate, t.$9 AS svcplan_ModifiedUser, t.$10 AS svcplan_TS, t.$11 AS svcplan_ClientInquiryID, t.$12 AS svcplan_HeaderID, t.$13 AS svcplan_FrequencyMax, t.$14 AS InsertDate, t.$15 AS UpdateDate, t.$16 AS DeletedFlag, t.$17 AS SYS_CHANGE_VERSION, CASE WHEN t.$16 = True THEN ''D'' WHEN t.$14 = t.$15 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$16, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ServicePlans.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ServicePlans AS WITH curr_v AS (SELECT svcplan_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ServicePlans GROUP BY svcplan_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_ServicePlans t INNER JOIN curr_v v ON t.svcplan_ID = v.svcplan_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

