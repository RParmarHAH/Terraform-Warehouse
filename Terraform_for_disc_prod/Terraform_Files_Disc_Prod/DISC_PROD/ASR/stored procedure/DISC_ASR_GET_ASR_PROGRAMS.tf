resource "snowflake_procedure" "DISC_ASR_GET_ASR_PROGRAMS" {
	name ="GET_ASR_PROGRAMS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ASR.GET_ASR_PROGRAMS 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_Programs FROM (SELECT A.$1 AS ProgramID, A.$2 AS ProgramName, A.$3 AS ProgramDescription, A.$4 AS DefaultPayRate, A.$5 AS DefaultPayFee, A.$6 AS DefaultNextReviewPeriodDays, A.$7 AS IsSkilled, A.$8 AS BILLABLERATE, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, FALSE as ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_Programs(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.ASR.ASR_PROGRAMS AS WITH curr_v AS (SELECT PROGRAMID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_PROGRAMS GROUP BY PROGRAMID) SELECT t.* FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_PROGRAMS t INNER JOIN curr_v v ON t.PROGRAMID = v.PROGRAMID AND t.ETL_DELETED_FLAG = FALSE and t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

