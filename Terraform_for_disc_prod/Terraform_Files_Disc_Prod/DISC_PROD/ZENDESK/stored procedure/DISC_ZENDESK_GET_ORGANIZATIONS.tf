resource "snowflake_procedure" "DISC_ZENDESK_GET_ORGANIZATIONS" {
	name ="GET_ORGANIZATIONS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ZENDESK.GET_ORGANIZATIONS 
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
    INSERT INTO DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_ORGANIZATIONS SELECT DISTINCT ''AMS'' AS SOURCE, j.$1:id::int AS ID, j.$1::VARIANT JSON_DATA, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Zendesk/output/organizations_ams.json(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_JSON_FORMAT) j UNION SELECT DISTINCT ''Payroll'' AS SOURCE, j2.value:id::int AS ID, j2.value::VARIANT JSON_DATA, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Zendesk/output/organizations_payroll.json(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_JSON_FORMAT), LATERAL FLATTEN($1:organizations) j2;

    --ViewSQL
    MERGE INTO DISC_${var.SF_ENVIRONMENT}.ZENDESK.ORGANIZATIONS TGT USING ( SELECT * FROM DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_ORGANIZATIONS WHERE ETL_LAST_UPDATED_DATE = (SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_ORGANIZATIONS)) STAGE ON TGT.id = STAGE.id AND TGT.SOURCE = STAGE.SOURCE WHEN MATCHED THEN UPDATE SET TGT.name = STAGE.JSON_DATA:name, TGT.details = STAGE.JSON_DATA:details, TGT.domain_names = STAGE.JSON_DATA:domain_names, TGT.external_id = STAGE.JSON_DATA:external_id, TGT.group_id = STAGE.JSON_DATA:group_id, TGT.organization_fields_city = STAGE.JSON_DATA:organization_fields:city, TGT.organization_fields_email = STAGE.JSON_DATA:organization_fields:email, TGT.organization_fields_fax = STAGE.JSON_DATA:organization_fields:fax, TGT.organization_fields_location_code = STAGE.JSON_DATA:organization_fields:location_code, TGT.organization_fields_manger = STAGE.JSON_DATA:organization_fields:manger, TGT.organization_fields_office_address = STAGE.JSON_DATA:organization_fields:office_address, TGT.organization_fields_office_number = STAGE.JSON_DATA:organization_fields:office_number, TGT.organization_fields_phone = STAGE.JSON_DATA:organization_fields:phone, TGT.organization_fields_state = STAGE.JSON_DATA:organization_fields:state, TGT.organization_fields_territory = STAGE.JSON_DATA:organization_fields:territory, TGT.organization_fields_zip = STAGE.JSON_DATA:organization_fields:zip, TGT.notes = STAGE.JSON_DATA:notes, TGT.shared_comments = STAGE.JSON_DATA:shared_comments, TGT.shared_tickets = STAGE.JSON_DATA:shared_tickets, TGT.tags = STAGE.JSON_DATA:tags, TGT.url = STAGE.JSON_DATA:url, TGT.created_at = STAGE.JSON_DATA:created_at, TGT.updated_at = STAGE.JSON_DATA:updated_at, TGT.ETL_TASK_KEY = STAGE.ETL_TASK_KEY ,TGT.ETL_LAST_UPDATED_DATE = STAGE.ETL_LAST_UPDATED_DATE  ,TGT.ETL_LAST_UPDATED_BY = STAGE.ETL_LAST_UPDATED_BY  ,TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG  WHEN NOT MATCHED THEN INSERT (SOURCE, ID, NAME, DETAILS, DOMAIN_NAMES, EXTERNAL_ID, GROUP_ID, ORGANIZATION_FIELDS_CITY, ORGANIZATION_FIELDS_EMAIL, ORGANIZATION_FIELDS_FAX, ORGANIZATION_FIELDS_LOCATION_CODE, ORGANIZATION_FIELDS_MANGER, ORGANIZATION_FIELDS_OFFICE_ADDRESS, ORGANIZATION_FIELDS_OFFICE_NUMBER, ORGANIZATION_FIELDS_PHONE, ORGANIZATION_FIELDS_STATE, ORGANIZATION_FIELDS_TERRITORY, ORGANIZATION_FIELDS_ZIP, NOTES, SHARED_COMMENTS, SHARED_TICKETS, TAGS, URL, CREATED_AT, UPDATED_AT,ETL_TASK_KEY , ETL_INSERTED_TASK_KEY , ETL_INSERTED_DATE , ETL_INSERTED_BY , ETL_LAST_UPDATED_DATE , ETL_LAST_UPDATED_BY , ETL_DELETED_FLAG) VALUES (STAGE.source, STAGE.JSON_DATA:id, STAGE.JSON_DATA:name, STAGE.JSON_DATA:details, STAGE.JSON_DATA:domain_names, STAGE.JSON_DATA:external_id, STAGE.JSON_DATA:group_id, STAGE.JSON_DATA:organization_fields:city, STAGE.JSON_DATA:organization_fields:email, STAGE.JSON_DATA:organization_fields:fax, STAGE.JSON_DATA:organization_fields:location_code, STAGE.JSON_DATA:organization_fields:manger, STAGE.JSON_DATA:organization_fields:office_address, STAGE.JSON_DATA:organization_fields:office_number, STAGE.JSON_DATA:organization_fields:phone, STAGE.JSON_DATA:organization_fields:state, STAGE.JSON_DATA:organization_fields:territory, STAGE.JSON_DATA:organization_fields:zip, STAGE.JSON_DATA:notes, STAGE.JSON_DATA:shared_comments, STAGE.JSON_DATA:shared_tickets, STAGE.JSON_DATA:tags, STAGE.JSON_DATA:url, STAGE.JSON_DATA:created_at, STAGE.JSON_DATA:updated_at,STAGE.ETL_TASK_KEY ,STAGE.ETL_INSERTED_TASK_KEY ,STAGE.ETL_INSERTED_DATE ,STAGE.ETL_INSERTED_BY ,STAGE.ETL_LAST_UPDATED_DATE ,STAGE.ETL_LAST_UPDATED_BY ,STAGE.ETL_DELETED_FLAG);

    return ''Success'';
END;

 EOT
}

