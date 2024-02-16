resource "snowflake_procedure" "DISC_QUALTRICS_SURVEYS_GET_CC_OPT_OUT" {
	name ="GET_CC_OPT_OUT"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "QUALTRICS_SURVEYS"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

BEGIN
	--TARGETSQL
	INSERT INTO DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.HIST_CC_OPT_OUT SELECT A.$1,A.$2,A.$3,A.$4,A.$5,A.$6,A.$7,A.$8,A.$9,A.$10,A.$11, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, FALSE as ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Qualtrics/Qualtrics_Opt_Out_MailingList/Opt_out_list.csv(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.CSV_FORMAT) A;
	
	--VIEWSQL
	INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.CC_OPT_OUT SELECT * FROM DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.HIST_CC_OPT_OUT WHERE ETL_INSERTED_DATE=(SELECT MAX(ETL_INSERTED_DATE) FROM DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.HIST_CC_OPT_OUT);
END;

 EOT
}

