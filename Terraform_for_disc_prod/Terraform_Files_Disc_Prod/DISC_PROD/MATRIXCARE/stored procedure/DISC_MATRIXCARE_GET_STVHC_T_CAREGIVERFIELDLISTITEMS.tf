resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_CAREGIVERFIELDLISTITEMS" {
	name ="GET_STVHC_T_CAREGIVERFIELDLISTITEMS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_CaregiverFieldListItems 
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
    COPY INTO MatrixCare.HIST_STVHC_T_CaregiverFieldListItems FROM (SELECT t.$1 AS cardd_ID, t.$2 AS cardd_FieldID, t.$3 AS cardd_SortID, t.$4 AS cardd_Value, t.$5 AS cardd_Text, t.$6 AS cardd_Active, t.$7 AS cardd_CreatedUser, t.$8 AS cardd_CreatedDate, t.$9 AS cardd_ModifiedUser, t.$10 AS cardd_ModifiedDate, t.$11 AS cardd_TS, t.$12 AS InsertDate, t.$13 AS UpdateDate, t.$14 AS DeletedFlag, t.$15 AS SYS_CHANGE_VERSION, t.$16 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$16,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_CaregiverFieldListItems.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_CaregiverFieldListItems AS WITH curr_v AS (SELECT cardd_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_CaregiverFieldListItems GROUP BY cardd_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_CaregiverFieldListItems t INNER JOIN curr_v v ON t.cardd_ID = v.cardd_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

