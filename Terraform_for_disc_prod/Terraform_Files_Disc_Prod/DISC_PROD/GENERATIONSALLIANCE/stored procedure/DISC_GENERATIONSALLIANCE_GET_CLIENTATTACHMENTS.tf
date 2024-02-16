resource "snowflake_procedure" "DISC_GENERATIONSALLIANCE_GET_CLIENTATTACHMENTS" {
	name ="GET_CLIENTATTACHMENTS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.GET_clientAttachments 
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
    COPY INTO GENERATIONSALLIANCE.clientAttachments FROM (SELECT t.$1 AS clientId, t.$2 AS attachmentId, t.$3 AS descr, t.$4 AS attachment, t.$5 AS documentPath, t.$6 AS str_filename, t.$7 AS updated_Path, t.$8 AS updated_FileName, t.$9 AS AzureEnabled, t.$10 AS AzureContainer, t.$11 AS AzureName, t.$12 AS CreatedBy, t.$13 AS Created, t.$14 AS UpdatedBy, t.$15 AS LastUpdated, t.$16 AS IsClientAccess, t.$17 AS SYS_CHANGE_VERSION, t.$18 AS SYS_CHANGE_OPERATION, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, DECODE(t.$18,''D'', True, False) AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AzStageProd/To_Be_Processed/GENERATIONSALLIANCE/ (PATTERN => ''.*GENERATIONSALLIANCE_dbo_clientAttachments.*[.]csv.gz'' , FILE_FORMAT=>DISC_${var.SF_ENVIRONMENT}.STAGE.PSV_FORMAT) t);

    --ViewSQL
    CREATE OR REPLACE TABLE GENERATIONSALLIANCE.clientAttachments AS WITH curr_v AS (SELECT clientId, attachmentId, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE FROM GENERATIONSALLIANCE.clientAttachments GROUP BY clientId, attachmentId) SELECT t.* FROM GENERATIONSALLIANCE.clientAttachments t INNER JOIN curr_v v ON t.clientId = v.clientId AND t.attachmentId = v.attachmentId AND t.ETL_DELETED_FLAG = FALSE AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;

    return ''Success'';
END;

 EOT
}

