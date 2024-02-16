resource "snowflake_procedure" "DISC_MATRIXCARE_GET_STVHC_T_CLIENTINQUIRYPHONES" {
	name ="GET_STVHC_T_CLIENTINQUIRYPHONES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.MatrixCare.GET_STVHC_T_ClientInquiryPhones 
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
    COPY INTO MatrixCare.HIST_STVHC_T_ClientInquiryPhones FROM (SELECT t.$1 AS clinqph_ID, t.$2 AS clinqph_ClientInquiryID, t.$3 AS clinqph_Phone, t.$4 AS clinqph_PhoneType, t.$5 AS clinqph_Note, t.$6 AS clinqph_Sequence, t.$7 AS InsertDate, t.$8 AS UpdateDate, t.$9 AS DeletedFlag, t.$10 AS SYS_CHANGE_VERSION, CASE WHEN t.$9 = True THEN ''D'' WHEN t.$7 = t.$8 THEN ''I'' ELSE ''U'' END AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, COALESCE(t.$9, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/MATRIXCARE/ (PATTERN => ''.*BIDW_17523_AdaptiveNursing_STVHC_T_ClientInquiryPhones.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.MY_CSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE MatrixCare.STVHC_T_ClientInquiryPhones AS WITH curr_v AS (SELECT clinqph_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM MatrixCare.HIST_STVHC_T_ClientInquiryPhones GROUP BY clinqph_ID) SELECT t.* FROM MatrixCare.HIST_STVHC_T_ClientInquiryPhones t INNER JOIN curr_v v ON t.clinqph_ID = v.clinqph_ID AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

