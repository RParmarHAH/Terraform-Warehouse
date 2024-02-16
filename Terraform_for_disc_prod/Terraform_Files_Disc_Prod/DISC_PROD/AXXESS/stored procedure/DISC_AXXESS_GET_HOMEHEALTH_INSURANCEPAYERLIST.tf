resource "snowflake_procedure" "DISC_AXXESS_GET_HOMEHEALTH_INSURANCEPAYERLIST" {
	name ="GET_HOMEHEALTH_INSURANCEPAYERLIST"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
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
	INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.AXXESS.AXXESS_HomeHealth_InsurancePayerList (SELECT A.$1 AS Insurance_Name,A.$2 AS Display_Name,A.$3 AS Payer_Class,A.$4 AS Type_Of_Bill,A.$5 AS Bill_Type,A.$6 Payer_Id,:TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, current_timestamp ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG  FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Axxess/SFTP_files/HomeHealth_InsurancePayerList(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

	return ''Success'';
END;

 EOT
}

