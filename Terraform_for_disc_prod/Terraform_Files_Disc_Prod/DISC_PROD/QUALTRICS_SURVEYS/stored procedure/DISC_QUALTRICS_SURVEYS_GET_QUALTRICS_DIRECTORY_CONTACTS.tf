resource "snowflake_procedure" "DISC_QUALTRICS_SURVEYS_GET_QUALTRICS_DIRECTORY_CONTACTS" {
	name ="GET_QUALTRICS_DIRECTORY_CONTACTS"
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
    --TargetSQL
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.QUALTRICS_DIRECTORY_CONTACTS SELECT a.$1,a.$2,a.$3,a.$4,a.$5,a.$6,a.$7,a.$8,a.$9,:TaskKey,:TaskKey,CURRENT_TIMESTAMP(),CURRENT_USER(),CURRENT_TIMESTAMP(),CURRENT_USER(),NULL FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/Qualtrics/Qualtrics_Directory_Contacts/Contacts_List.csv(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.CSV_FORMAT) a;

    return ''Success'';

END;

 EOT
}

