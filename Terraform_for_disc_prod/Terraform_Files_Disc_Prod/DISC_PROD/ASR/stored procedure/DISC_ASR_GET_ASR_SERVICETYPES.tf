resource "snowflake_procedure" "DISC_ASR_GET_ASR_SERVICETYPES" {
	name ="GET_ASR_SERVICETYPES"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ASR.GET_ASR_SERVICETYPES 
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
    COPY INTO DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_ServiceTypes FROM (SELECT A.$1 AS Service_Type_ID, A.$2 AS Service_Type_Name, A.$3 AS ServiceTypeDescr, A.$4 AS AutoNotifyLateCheckIns, A.$5 AS AutoNotifyLateCheckinsEmail, A.$6 AS DefaultNextReviewPeriodDays, A.$7 AS IsSkilled, A.$8 AS ProviderMedicaidID, A.$9 AS ProviderNPINumber, A.$10 AS EVV_ID, A.$11 AS EVV_Credentials, A.$12 AS BillableRate, A.$13 AS GLACCOUNTNUMBER, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, FALSE as ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.Stage.AWSAZSTAGEPROD/ASR/Daily_Files/ASR_Data_Extract_ServiceTypes(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) A);

    --ViewSQL
    CREATE OR REPLACE TABLE DISC_${var.SF_ENVIRONMENT}.ASR.ASR_SERVICETYPES AS WITH curr_v AS (SELECT SERVICE_TYPE_ID, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_SERVICETYPES GROUP BY SERVICE_TYPE_ID) SELECT t.* FROM DISC_${var.SF_ENVIRONMENT}.ASR.HIST_ASR_SERVICETYPES t INNER JOIN curr_v v ON t.SERVICE_TYPE_ID = v.SERVICE_TYPE_ID AND t.ETL_DELETED_FLAG = FALSE and t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

