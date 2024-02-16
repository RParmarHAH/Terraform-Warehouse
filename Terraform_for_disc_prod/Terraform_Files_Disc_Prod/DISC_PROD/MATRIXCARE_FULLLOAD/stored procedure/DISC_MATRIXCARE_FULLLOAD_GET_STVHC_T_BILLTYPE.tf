resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_BILLTYPE" {
	name ="GET_STVHC_T_BILLTYPE"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_BillType 
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
    COPY INTO MatrixCare.HIST_STVHC_T_BillType FROM (SELECT t.$1 AS biltyp_ID, t.$2 AS biltyp_Active, t.$3 AS biltyp_PrintFormat, t.$4 AS biltyp_InvProcessID, t.$5 AS biltyp_BillingStatusID, t.$6 AS biltyp_NewBillingStatusID, t.$7 AS biltyp_ReportName, t.$8 AS biltyp_AllowDetailExclude, t.$9 AS biltyp_CreatedDate, t.$10 AS biltyp_CreatedUser, t.$11 AS biltyp_ModifiedDate, t.$12 AS biltyp_ModifiedUser, t.$13 AS biltyp_TS, t.$14 AS biltyp_Name, t.$15 AS biltyp_Description, t.$16 AS biltyp_DefRevenue, t.$17 AS biltyp_AllowUIChange, t.$18 AS biltyp_AllowEmail, t.$19 AS biltyp_AllowMultiPrint, t.$20 AS biltyp_ReportID, t.$21 AS InsertDate, t.$22 AS UpdateDate, t.$23 AS DeletedFlag, t.$24 AS SYS_CHANGE_VERSION, CASE WHEN t.$23 = True THEN ''D'' WHEN t.$21 = t.$22 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$23, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_BillType.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_BillType AS WITH curr_v AS (SELECT biltyp_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_BillType GROUP BY biltyp_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_BillType t INNER JOIN curr_v v ON t.biltyp_ID = v.biltyp_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

