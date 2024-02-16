resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_PAYMENTREGISTERTYPES" {
	name ="GET_STVHC_T_PAYMENTREGISTERTYPES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_PaymentRegisterTypes 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PaymentRegisterTypes FROM (SELECT t.$1 AS pmtrtyp_ID, t.$2 AS pmtrtyp_Name, t.$3 AS pmtrtyp_Active, t.$4 AS pmtrtyp_CreatedDate, t.$5 AS pmtrtyp_CreatedUser, t.$6 AS pmtrtyp_ModifiedDate, t.$7 AS pmtrtyp_ModifiedUser, t.$8 AS pmtrtyp_TS, t.$9 AS pmtrtyp_ListItemType, t.$10 AS pmtrtyp_RptGroupID, t.$11 AS pmtrtyp_BranchID, t.$12 AS pmtrtyp_OverrideID, t.$13 AS pmtrtyp_Description, t.$14 AS pmtrtyp_AcctID, t.$15 AS pmtrtyp_IsCreditCard, t.$16 AS pmtrtyp_AcctCode, t.$17 AS InsertDate, t.$18 AS UpdateDate, t.$19 AS DeletedFlag, t.$20 AS SYS_CHANGE_VERSION, CASE WHEN t.$19 = True THEN ''D'' WHEN t.$17 = t.$18 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$19, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PaymentRegisterTypes.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PaymentRegisterTypes AS WITH curr_v AS (SELECT pmtrtyp_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PaymentRegisterTypes GROUP BY pmtrtyp_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT PMTRTYP_BRANCHID FROM MatrixCare.HIST_STVHC_T_PaymentRegisterTypes  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.PMTRTYP_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_PaymentRegisterTypes t INNER JOIN curr_v v ON t.pmtrtyp_ID = v.pmtrtyp_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.PMTRTYP_BRANCHID NOT IN (SELECT PMTRTYP_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

