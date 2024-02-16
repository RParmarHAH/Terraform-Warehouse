resource "snowflake_procedure" "DISC_QUALTRICS_SURVEYS_GET_QUALTRICS_SURVEY_DISTRIBUTION_HISTORY" {
	name ="GET_QUALTRICS_SURVEY_DISTRIBUTION_HISTORY"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.GET_QUALTRICS_SURVEY_DISTRIBUTION_HISTORY 
--
-- PURPOSE: To Load Discovery Layer Tables
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2023-11-20 		Ravi Suthar            	Initial Development
-- 2023-11-30		Komal Dhokai			Removed TargetSQL
--*****************************************************************************************************************************

BEGIN 
   
    --ViewSQL
    INSERT OVERWRITE INTO DISC_${var.SF_ENVIRONMENT}.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_DISTRIBUTION_HISTORY SELECT a.$1,a.$2,a.$3,a.$4,a.$5,a.$6,a.$7,a.$8,a.$9,a.$10,a.$11,a.$12,:TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY,CURRENT_TIMESTAMP(),CURRENT_USER(),CURRENT_TIMESTAMP(),CURRENT_USER(),NULL FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/Qualtrics/Qualtrics_Survey_Distribution_History/(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.CSV_FORMAT) a;

    return ''Success'';
END;

 EOT
}

