resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_REFERRALFACILITYDOCUMENTS" {
	name ="GET_STVHC_T_REFERRALFACILITYDOCUMENTS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ReferralFacilityDocuments 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ReferralFacilityDocuments FROM (SELECT t.$1 AS reffacdoc_ID, t.$2 AS reffacdoc_ReferralFacilityID, t.$3 AS reffacdoc_TypeID, t.$4 AS reffacdoc_Format, t.$5 AS reffacdoc_FileName, t.$6 AS reffacdoc_FileSize, t.$7 AS reffacdoc_Notes, t.$8 AS reffacdoc_Sharelevel, t.$9 AS reffacdoc_CreatedDate, t.$10 AS reffacdoc_CreatedUser, t.$11 AS reffacdoc_ModifiedDate, t.$12 AS reffacdoc_ModifiedUser, t.$13 AS reffacdoc_TS, t.$14 AS reffacdoc_isCompressed, t.$15 AS reffacdoc_SubTypeID, t.$16 AS InsertDate, t.$17 AS UpdateDate, t.$18 AS DeletedFlag, t.$19 AS SYS_CHANGE_VERSION, CASE WHEN t.$18 = True THEN ''D'' WHEN t.$16 = t.$17 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$18, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ReferralFacilityDocuments.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ReferralFacilityDocuments AS WITH curr_v AS (SELECT reffacdoc_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ReferralFacilityDocuments GROUP BY reffacdoc_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_ReferralFacilityDocuments t INNER JOIN curr_v v ON t.reffacdoc_ID = v.reffacdoc_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

