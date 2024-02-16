resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_RATES" {
	name ="GET_STVHC_T_RATES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_Rates 
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
    COPY INTO MatrixCare.HIST_STVHC_T_Rates FROM (SELECT t.$1 AS rate_ID, t.$2 AS rate_OverrideType, t.$3 AS rate_RateType, t.$4 AS rate_ServiceCodeID, t.$5 AS rate_BranchID, t.$6 AS rate_RegionID, t.$7 AS rate_ClientID, t.$8 AS rate_CaregiverID, t.$9 AS rate_PayerID, t.$10 AS rate_Rate1, t.$11 AS rate_Rate2, t.$12 AS rate_Rate3, t.$13 AS rate_Rate4, t.$14 AS rate_Rate5, t.$15 AS rate_Rate6, t.$16 AS rate_UnitFlag, t.$17 AS rate_UnitSpecific, t.$18 AS rate_Notes, t.$19 AS rate_EffectiveStartDate, t.$20 AS rate_EffectiveEndDate, t.$21 AS rate_CreatedDate, t.$22 AS rate_CreatedUser, t.$23 AS rate_ModifiedDate, t.$24 AS rate_ModifiedUser, t.$25 AS rate_TS, t.$26 AS rate_OTRate, t.$27 AS InsertDate, t.$28 AS UpdateDate, t.$29 AS DeletedFlag, t.$30 AS SYS_CHANGE_VERSION, CASE WHEN t.$29 = True THEN ''D'' WHEN t.$27 = t.$28 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$29, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_Rates[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_Rates AS WITH curr_v AS (SELECT rate_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_Rates GROUP BY rate_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT RATE_BRANCHID FROM MatrixCare.HIST_STVHC_T_Rates  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.RATE_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_Rates t INNER JOIN curr_v v ON t.rate_ID = v.rate_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.RATE_BRANCHID NOT IN (SELECT RATE_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

