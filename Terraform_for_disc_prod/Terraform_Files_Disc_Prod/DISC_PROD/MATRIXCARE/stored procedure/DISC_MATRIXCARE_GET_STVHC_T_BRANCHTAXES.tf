resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_BRANCHTAXES" {
	name ="GET_STVHC_T_BRANCHTAXES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_BranchTaxes 
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
    COPY INTO MatrixCare.HIST_STVHC_T_BranchTaxes FROM (SELECT t.$1 AS brtx_ID, t.$2 AS brtx_GroupID, t.$3 AS brtx_TaxTypeID, t.$4 AS brtx_Desc, t.$5 AS brtx_Percent, t.$6 AS brtx_FixedAmt, t.$7 AS brtx_EffectiveStart, t.$8 AS brtx_EffectiveEnd, t.$9 AS brtx_CreatedDate, t.$10 AS brtx_CreatedUser, t.$11 AS brtx_ModifiedDate, t.$12 AS brtx_ModifiedUser, t.$13 AS brtx_TS, t.$14 AS brtx_HCPCS, t.$15 AS brtx_AcctID, t.$16 AS brtx_AcctCode, t.$17 AS InsertDate, t.$18 AS UpdateDate, t.$19 AS DeletedFlag, t.$20 AS SYS_CHANGE_VERSION, CASE WHEN t.$19 = True THEN ''D'' WHEN t.$17 = t.$18 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$19, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_BranchTaxes.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_BranchTaxes AS WITH curr_v AS (SELECT brtx_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_BranchTaxes GROUP BY brtx_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_BranchTaxes t INNER JOIN curr_v v ON t.brtx_ID = v.brtx_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

