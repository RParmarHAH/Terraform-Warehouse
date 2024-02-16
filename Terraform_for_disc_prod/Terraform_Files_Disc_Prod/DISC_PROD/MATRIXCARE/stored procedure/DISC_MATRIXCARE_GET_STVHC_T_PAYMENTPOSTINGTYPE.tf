resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_PAYMENTPOSTINGTYPE" {
	name ="GET_STVHC_T_PAYMENTPOSTINGTYPE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_PaymentPostingType 
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
    COPY INTO MatrixCare.HIST_STVHC_T_PaymentPostingType FROM (SELECT t.$1 AS posttyp_ID, t.$2 AS posttyp_Name, t.$3 AS posttyp_Active, t.$4 AS posttyp_Sort, t.$5 AS posttyp_PostingType, t.$6 AS posttyp_Type, t.$7 AS posttyp_CreatedDate, t.$8 AS posttyp_CreatedUser, t.$9 AS posttyp_ModifiedDate, t.$10 AS posttyp_ModifiedUser, t.$11 AS posttyp_TS, t.$12 AS posttyp_ListItemType, t.$13 AS posttyp_RptGroupID, t.$14 AS posttyp_BranchID, t.$15 AS posttyp_OverrideID, t.$16 AS posttyp_Description, t.$17 AS posttyp_AcctID, t.$18 AS posttyp_AcctSource, t.$19 AS posttyp_EffectTaxes, t.$20 AS posttyp_AcctCode, t.$21 AS posttyp_EDIReasonCode, t.$22 AS posttyp_IsWithhold, t.$23 AS posttyp_ShowInUI, t.$24 AS InsertDate, t.$25 AS UpdateDate, t.$26 AS DeletedFlag, t.$27 AS SYS_CHANGE_VERSION, CASE WHEN t.$26 = True THEN ''D'' WHEN t.$24 = t.$25 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$26, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_PaymentPostingType.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_PaymentPostingType AS WITH curr_v AS (SELECT posttyp_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_PaymentPostingType GROUP BY posttyp_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT POSTTYP_BRANCHID FROM MatrixCare.HIST_STVHC_T_PaymentPostingType  br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.POSTTYP_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_PaymentPostingType t INNER JOIN curr_v v ON t.posttyp_ID = v.posttyp_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.POSTTYP_BRANCHID NOT IN (SELECT POSTTYP_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

