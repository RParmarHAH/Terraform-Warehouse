resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_CAREGIVERHIRING" {
	name ="GET_STVHC_T_CAREGIVERHIRING"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_CaregiverHiring 
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
    COPY INTO MatrixCare.HIST_STVHC_T_CaregiverHiring FROM (SELECT t.$1 AS carhr_ID, t.$2 AS carhr_carID, t.$3 AS carhr_AppliedDate, t.$4 AS carhr_InterviewDate, t.$5 AS carhr_HireDate, t.$6 AS carhr_OrientationDate, t.$7 AS carhr_Position, t.$8 AS carhr_SeparationDate, t.$9 AS carhr_SeparationReason, t.$10 AS carhr_CreatedDate, t.$11 AS carhr_CreatedUser, t.$12 AS carhr_ModifiedDate, t.$13 AS carhr_ModifiedUser, t.$14 AS carhr_TS, t.$15 AS carhr_StartDate, t.$16 AS carhr_InterviewStaffID, t.$17 AS carhr_InterviewScheduled_ActivityID, t.$18 AS carhr_ReferralDate, t.$19 AS carhr_ReferralTakenBy, t.$20 AS carhr_ReferralEntityTypeID, t.$21 AS carhr_ReferralEntityID, t.$22 AS carhr_ReferralContactJoinID, t.$23 AS carhr_ReferralCampaignID, t.$24 AS carhr_StaffID, t.$25 AS carhr_ReferralNotes, t.$26 AS carhr_ReferralTypeID, t.$27 AS carhr_CaregiverSeparationReasonID, t.$28 AS carhr_ReferralTakenByID, t.$29 AS carhr_FirstServiceDate, t.$30 AS carhr_LastServiceDate, t.$31 AS InsertDate, t.$32 AS UpdateDate, t.$33 AS DeletedFlag, t.$34 AS SYS_CHANGE_VERSION, CASE WHEN t.$33 = True THEN ''D'' WHEN t.$31 = t.$32 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$33, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_CaregiverHiring.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_CaregiverHiring AS WITH curr_v AS (SELECT carhr_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_CaregiverHiring GROUP BY carhr_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_CaregiverHiring t INNER JOIN curr_v v ON t.carhr_ID = v.carhr_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

