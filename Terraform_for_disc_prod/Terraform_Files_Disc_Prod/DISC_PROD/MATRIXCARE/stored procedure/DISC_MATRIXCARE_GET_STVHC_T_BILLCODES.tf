resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_BILLCODES" {
	name ="GET_STVHC_T_BILLCODES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_BillCodes 
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
    COPY INTO MatrixCare.HIST_STVHC_T_BillCodes FROM (SELECT t.$1 AS bcd_ID, t.$2 AS bcd_BillCode, t.$3 AS bcd_Name, t.$4 AS bcd_Active, t.$5 AS bcd_CreatedDate, t.$6 AS bcd_CreatedUser, t.$7 AS bcd_ModifiedDate, t.$8 AS bcd_ModifiedUser, t.$9 AS bcd_TS, t.$10 AS bcd_ListItemType, t.$11 AS bcd_RptGroupID, t.$12 AS bcd_BranchID, t.$13 AS bcd_OverrideID, t.$14 AS bcd_Description, t.$15 AS InsertDate, t.$16 AS UpdateDate, t.$17 AS DeletedFlag, t.$18 AS SYS_CHANGE_VERSION, CASE WHEN t.$17 = True THEN ''D'' WHEN t.$15 = t.$16 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$17, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_BillCodes.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_BillCodes AS WITH curr_v AS (SELECT bcd_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_BillCodes GROUP BY bcd_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT BCD_BRANCHID FROM MatrixCare.HIST_STVHC_T_BillCodes br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.BCD_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_BillCodes t INNER JOIN curr_v v ON t.bcd_ID = v.bcd_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND NVL(t.BCD_BRANCHID,-1) NOT IN (SELECT BCD_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

