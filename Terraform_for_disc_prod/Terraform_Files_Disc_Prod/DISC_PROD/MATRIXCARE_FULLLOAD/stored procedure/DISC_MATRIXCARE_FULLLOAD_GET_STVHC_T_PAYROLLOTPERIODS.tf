resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_PAYROLLOTPERIODS" {
	name ="GET_STVHC_T_PAYROLLOTPERIODS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_PayrollOTPeriods 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PayrollOTPeriods FROM (SELECT t.$1 AS otp_ID, t.$2 AS otp_PayrollBatchID, t.$3 AS otp_WeekNumber, t.$4 AS otp_WeekYear, t.$5 AS otp_DayNumber, t.$6 AS otp_CaregiverID, t.$7 AS otp_StartDateTime, t.$8 AS otp_EndDateTime, t.$9 AS otp_TotalOTEligibleMinutes, t.$10 AS otp_TotalOTEligiblePaid, t.$11 AS otp_BlendedRate, t.$12 AS otp_TotalAllocatedOTMinutes, t.$13 AS otp_TotalAllocatedOTPaid, t.$14 AS otp_OTThresholdMinutes, t.$15 AS otp_OTConfig, t.$16 AS otp_IsWeekRecord, t.$17 AS otp_PayrollTypeID, t.$18 AS otp_BranchID, t.$19 AS otp_ParentID, t.$20 AS otp_HasLegacyRecords, t.$21 AS otp_DraftID, t.$22 AS otp_WeekSeq, t.$23 AS otp_OTMultiplier, t.$24 AS otp_HasSeventhDayOT, t.$25 AS otp_WeekOTPay, t.$26 AS otp_TotalMinutes, t.$27 AS InsertDate, t.$28 AS UpdateDate, t.$29 AS DeletedFlag, t.$30 AS SYS_CHANGE_VERSION, CASE WHEN t.$29 = True THEN ''D'' WHEN t.$27 = t.$28 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$29, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PayrollOTPeriods.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PayrollOTPeriods AS WITH curr_v AS (SELECT otp_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PayrollOTPeriods GROUP BY otp_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT OTP_BRANCHID FROM MatrixCare.HIST_STVHC_T_PayrollOTPeriods  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.OTP_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_PayrollOTPeriods t INNER JOIN curr_v v ON t.otp_ID = v.otp_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.OTP_BRANCHID NOT IN (SELECT OTP_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

