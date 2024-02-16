resource "snowflake_procedure" "DISC_ASR_GET_ASR_CUSTOMERSCOMMUNICATIONLOG" {
	name ="GET_ASR_CUSTOMERSCOMMUNICATIONLOG"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ASR.GET_ASR_CUSTOMERSCOMMUNICATIONLOG 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_CUSTOMERSCOMMUNICATIONLOG FROM (SELECT A.$1 AS RECORDID, A.$2 AS RECORDDATETIME, A.$3 AS CONTEXTID, A.$4 AS ITEMID, A.$5 AS RECORDTEXT, A.$6 AS RECORDFROM, A.$7 AS RECORDTO, A.$8 AS SUSPENDEDFROM, A.$9 AS SUSPENDEDTO, A.$10 AS RECORDTYPE, A.$11 AS EMPLOYEEID, A.$12 AS ACTIONTAKEN, A.$13 AS RESOLVED, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, FALSE AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_CUSTOMERSCOMMUNICATIONLOG(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.ASR.ASR_CUSTOMERSCOMMUNICATIONLOG AS WITH curr_v AS (SELECT RECORDID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_CUSTOMERSCOMMUNICATIONLOG GROUP BY RECORDID) SELECT t.* FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_CUSTOMERSCOMMUNICATIONLOG t INNER JOIN curr_v v ON t.RECORDID = v.RECORDID AND t.ETL_DELETED_FLAG = FALSE and t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

