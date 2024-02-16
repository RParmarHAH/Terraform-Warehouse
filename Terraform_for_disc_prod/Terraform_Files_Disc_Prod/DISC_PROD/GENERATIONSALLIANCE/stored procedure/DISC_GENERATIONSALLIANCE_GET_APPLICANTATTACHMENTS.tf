resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_APPLICANTATTACHMENTS" {
	name ="GET_APPLICANTATTACHMENTS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_ApplicantAttachments 
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
    COPY INTO GENERATIONSALLIANCE.ApplicantAttachments FROM (SELECT t.$1 AS socialSecNum, t.$2 AS attachmentId, t.$3 AS descr, t.$4 AS attachment, t.$5 AS str_filename, t.$6 AS documentPath, t.$7 AS Updated_Path, t.$8 AS Updated_FileName, t.$9 AS CreatedBy, t.$10 AS Created, t.$11 AS UpdatedBy, t.$12 AS LastUpdated, t.$13 AS AzureEnabled, t.$14 AS AzureContainer, t.$15 AS AzureName, t.$16 AS SYS_CHANGE_VERSION, t.$17 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$17,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_ApplicantAttachments.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.ApplicantAttachments AS WITH curr_v AS (SELECT socialSecNum, attachmentId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.ApplicantAttachments GROUP BY socialSecNum, attachmentId) SELECT t.* FROM GENERATIONSALLIANCE.ApplicantAttachments t INNER JOIN curr_v v ON t.socialSecNum = v.socialSecNum AND t.attachmentId = v.attachmentId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

