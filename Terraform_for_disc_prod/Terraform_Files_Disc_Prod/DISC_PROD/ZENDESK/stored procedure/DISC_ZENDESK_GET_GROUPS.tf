resource "snowflake_procedure" "DISC_ZENDESK_GET_GROUPS" {
	name ="GET_GROUPS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ZENDESK"
	language  = "SQL"

	arguments {
		name = "TASKKEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ZENDESK.GET_GROUPS 
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
    INSERT INTO DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_GROUPS SELECT DISTINCT ''AMS'' AS SOURCE, j.VALUE:id::int AS ID, j.VALUE::VARIANT JSON_DATA, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Zendesk/output/groups_ams.json(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_JSON_FORMAT), LATERAL FLATTEN($1:groups) j UNION SELECT DISTINCT ''Payroll'' AS SOURCE, j2.value:id::int AS ID, j2.value::VARIANT JSON_DATA, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Zendesk/output/groups_payroll.json(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_JSON_FORMAT), LATERAL FLATTEN($1:groups) j2;

    --ViewSQL
    MERGE INTO DISC_${var.SF_ENVIRONMENT}.ZENDESK.GROUPS TGT USING ( SELECT * FROM DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_GROUPS WHERE ETL_LAST_UPDATED_DATE = (SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_GROUPS)) STAGE ON TGT.id = STAGE.id AND TGT.SOURCE = STAGE.SOURCE WHEN MATCHED THEN UPDATE SET TGT.SOURCE = STAGE.SOURCE ,TGT.name = STAGE.JSON_DATA:name ,TGT.description= STAGE.JSON_DATA:description ,TGT.is_public = STAGE.JSON_DATA:is_public ,TGT.url = STAGE.JSON_DATA:url ,TGT.deleted = STAGE.JSON_DATA:deleted ,TGT.created_at = STAGE.JSON_DATA:created_at ,TGT.updated_at = STAGE.JSON_DATA:updated_at , TGT.ETL_TASK_KEY = STAGE.ETL_TASK_KEY ,TGT.ETL_LAST_UPDATED_DATE = STAGE.ETL_LAST_UPDATED_DATE  ,TGT.ETL_LAST_UPDATED_BY = STAGE.ETL_LAST_UPDATED_BY  ,TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG  WHEN NOT MATCHED THEN INSERT ( SOURCE ,ID, NAME ,DESCRIPTION ,URL ,DELETED ,IS_PUBLIC ,CREATED_AT ,UPDATED_AT ,ETL_TASK_KEY , ETL_INSERTED_TASK_KEY , ETL_INSERTED_DATE , ETL_INSERTED_BY , ETL_LAST_UPDATED_DATE , ETL_LAST_UPDATED_BY , ETL_DELETED_FLAG) VALUES ( STAGE.SOURCE ,STAGE.JSON_DATA:id ,STAGE.JSON_DATA:name ,STAGE.JSON_DATA:description ,STAGE.JSON_DATA:url ,STAGE.JSON_DATA:deleted ,STAGE.JSON_DATA:is_public ,STAGE.JSON_DATA:created_at ,STAGE.JSON_DATA:updated_at ,STAGE.ETL_TASK_KEY ,STAGE.ETL_INSERTED_TASK_KEY ,STAGE.ETL_INSERTED_DATE ,STAGE.ETL_INSERTED_BY ,STAGE.ETL_LAST_UPDATED_DATE ,STAGE.ETL_LAST_UPDATED_BY ,STAGE.ETL_DELETED_FLAG);

    return ''Success'';
END;

 EOT
}

