resource "snowflake_procedure" "DISC_QUALTRICS_SURVEYS_GET_CC_BOUNCED" {
	name ="GET_CC_BOUNCED"
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

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.GET_CC_BOUNCED 
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
    INSERT INTO DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.HIST_CC_BOUNCED SELECT A.$1,A.$2,A.$3,A.$4,A.$5,A.$6,A.$7,A.$8,A.$9,A.$10,A.$11,NULL, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, FALSE as ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Qualtrics/Qualtrics_Bounced_Contacts/Bounced_Contacts_List.csv(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.CSV_FORMAT) A;

    --ViewSQL
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.CC_BOUNCED SELECT * FROM DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.HIST_CC_BOUNCED WHERE ETL_INSERTED_DATE=(SELECT MAX(ETL_INSERTED_DATE) FROM DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.HIST_CC_BOUNCED);

    return ''Success'';
END;

 EOT
}

