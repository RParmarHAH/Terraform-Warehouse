resource "snowflake_procedure" "DISC_MATRIXCARE_FULLLOAD_GET_STVHC_T_CLIENTINQUIRYFIELDS" {
	name ="GET_STVHC_T_CLIENTINQUIRYFIELDS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ClientInquiryFields 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ClientInquiryFields FROM (SELECT t.$1 AS cliqf_ID, t.$2 AS cliqf_BranchID, t.$3 AS cliqf_Name, t.$4 AS cliqf_TabID, t.$5 AS cliqf_RowNumber, t.$6 AS cliqf_ColNumber, t.$7 AS cliqf_FieldType, t.$8 AS cliqf_DefaultValue, t.$9 AS cliqf_CreatedUser, t.$10 AS cliqf_CreatedDate, t.$11 AS cliqf_ModifiedUser, t.$12 AS cliqf_ModifiedDate, t.$13 AS cliqf_TS, t.$14 AS cliqf_Active, t.$15 AS cliqf_NameID, t.$16 AS InsertDate, t.$17 AS UpdateDate, t.$18 AS DeletedFlag, t.$19 AS SYS_CHANGE_VERSION, CASE WHEN t.$18 = True THEN ''D'' WHEN t.$16 = t.$17 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$18, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ClientInquiryFields.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ClientInquiryFields AS WITH curr_v AS (SELECT cliqf_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ClientInquiryFields GROUP BY cliqf_ID) ,EXCLUDE_LIST AS ( SELECT DISTINCT CLIQF_BRANCHID FROM MatrixCare.HIST_STVHC_T_ClientInquiryFields br  INNER JOIN UTIL.Migrated_Branch_By_SourceSystem  BR_EX ON BR_eX.OFFIcE_NUMBER = BR.CLIQF_BRANCHID AND SOURCE_SYSTEM_ID = 7 AND SYSTEM_CODE = ''MATRIXCARE'') SELECT t.* FROM MatrixCare.HIST_STVHC_T_ClientInquiryFields t INNER JOIN curr_v v ON t.cliqf_ID = v.cliqf_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE AND t.CLIQF_BRANCHID NOT IN (SELECT CLIQF_BRANCHID FROM EXCLUDE_LIST) ;

    return ''Success'';
END;

 EOT
}

