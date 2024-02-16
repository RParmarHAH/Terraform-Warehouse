CREATE OR REPLACE PROCEDURE DISC_PROD.ZENDESK.GET_TICKET_CUSTOM_FIELDS_MAPPING("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ZENDESK.GET_TICKET_CUSTOM_FIELDS_MAPPING 
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
    INSERT INTO DISC_PROD.ZENDESK.HIST_TICKET_CUSTOM_FIELDS_MAPPING SELECT DISTINCT ''AMS'' AS SOURCE, j2.value:id::int AS ID, j2.value::VARIANT JSON_DATA, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Zendesk/output/ticket_fields_mapping_ams.json(file_format => DISC_PROD.STAGE.MY_JSON_FORMAT), LATERAL FLATTEN(input => $1:ticket_fields) j2 WHERE ID IS NOT NULL ;

    --ViewSQL
    MERGE INTO DISC_PROD.ZENDESK.TICKET_CUSTOM_FIELDS_MAPPING TGT USING ( SELECT DISTINCT * FROM DISC_PROD.ZENDESK.HIST_TICKET_CUSTOM_FIELDS_MAPPING WHERE ETL_LAST_UPDATED_DATE = ( SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_PROD.ZENDESK.HIST_TICKET_CUSTOM_FIELDS_MAPPING)) STAGE ON TGT.ID = STAGE.ID AND TGT.SOURCE = STAGE.SOURCE WHEN MATCHED THEN UPDATE SET TGT.SOURCE = STAGE.SOURCE , TGT.id = STAGE.JSON_DATA:id, TGT.type = STAGE.JSON_DATA:type, TGT.title = STAGE.JSON_DATA:title, TGT.raw_title = STAGE.JSON_DATA:raw_title, TGT.description = STAGE.JSON_DATA:description, TGT.raw_description = STAGE.JSON_DATA:raw_description, TGT.position = STAGE.JSON_DATA:position, TGT.active = STAGE.JSON_DATA:active, TGT.required = STAGE.JSON_DATA:required, TGT.collapsed_for_agents = STAGE.JSON_DATA:collapsed_for_agents, TGT.regexp_for_validation = STAGE.JSON_DATA:regexp_for_validation, TGT.title_in_portal = STAGE.JSON_DATA:title_in_portal, TGT.raw_title_in_portal = STAGE.JSON_DATA:raw_title_in_portal, TGT.visible_in_portal = STAGE.JSON_DATA:visible_in_portal, TGT.editable_in_portal = STAGE.JSON_DATA:editable_in_portal, TGT.required_in_portal = STAGE.JSON_DATA:required_in_portal, TGT.tag = STAGE.JSON_DATA:tag, TGT.created_at = STAGE.JSON_DATA:created_at, TGT.updated_at = STAGE.JSON_DATA:updated_at, TGT.removable = STAGE.JSON_DATA:removable, TGT.key = STAGE.JSON_DATA:key, TGT.agent_description = STAGE.JSON_DATA:agent_description, TGT.custom_field_options = STAGE.JSON_DATA:custom_field_options, TGT.system_field_options = STAGE.JSON_DATA:system_field_options, TGT.ETL_TASK_KEY = STAGE.ETL_TASK_KEY , TGT.ETL_INSERTED_TASK_KEY = STAGE.ETL_INSERTED_TASK_KEY , TGT.ETL_INSERTED_DATE = STAGE.ETL_INSERTED_DATE , TGT.ETL_INSERTED_BY = STAGE.ETL_INSERTED_BY , TGT.ETL_LAST_UPDATED_DATE = STAGE.ETL_LAST_UPDATED_DATE , TGT.ETL_LAST_UPDATED_BY = STAGE.ETL_LAST_UPDATED_BY , TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG WHEN NOT MATCHED THEN INSERT ( SOURCE, id, type, title, raw_title, description, raw_description, position, active, required, collapsed_for_agents, regexp_for_validation, title_in_portal, raw_title_in_portal, visible_in_portal, editable_in_portal, required_in_portal, tag, created_at, updated_at, removable, key, agent_description, custom_field_options, system_field_options, ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG ) VALUES ( STAGE.SOURCE , STAGE.JSON_DATA:id, STAGE.JSON_DATA:type, STAGE.JSON_DATA:title, STAGE.JSON_DATA:raw_title, STAGE.JSON_DATA:description, STAGE.JSON_DATA:raw_description, STAGE.JSON_DATA:position, STAGE.JSON_DATA:active, STAGE.JSON_DATA:required, STAGE.JSON_DATA:collapsed_for_agents, STAGE.JSON_DATA:regexp_for_validation, STAGE.JSON_DATA:title_in_portal, STAGE.JSON_DATA:raw_title_in_portal, STAGE.JSON_DATA:visible_in_portal, STAGE.JSON_DATA:editable_in_portal, STAGE.JSON_DATA:required_in_portal, STAGE.JSON_DATA:tag, STAGE.JSON_DATA:created_at, STAGE.JSON_DATA:updated_at, STAGE.JSON_DATA:removable, STAGE.JSON_DATA:key, STAGE.JSON_DATA:agent_description, STAGE.JSON_DATA:custom_field_options, STAGE.JSON_DATA:system_field_options, STAGE.ETL_TASK_KEY , STAGE.ETL_INSERTED_TASK_KEY , STAGE.ETL_INSERTED_DATE , STAGE.ETL_INSERTED_BY , STAGE.ETL_LAST_UPDATED_DATE , STAGE.ETL_LAST_UPDATED_BY , STAGE.ETL_DELETED_FLAG );

    return ''Success'';
END;
';