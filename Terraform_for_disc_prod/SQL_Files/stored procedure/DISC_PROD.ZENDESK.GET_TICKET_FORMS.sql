CREATE OR REPLACE PROCEDURE DISC_PROD.ZENDESK.GET_TICKET_FORMS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ZENDESK.GET_TICKET_FORMS 
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
    INSERT INTO DISC_PROD.ZENDESK.HIST_TICKET_FORMS SELECT DISTINCT ''AMS'' AS SOURCE, j2.value:id::int AS ID, j2.value::VARIANT JSON_DATA, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Zendesk/output/ticket_form_ams.json(file_format => DISC_PROD.STAGE.MY_JSON_FORMAT), LATERAL FLATTEN(input => $1:ticket_forms) j2 WHERE ID IS NOT NULL;

    --ViewSQL
    MERGE INTO DISC_PROD.ZENDESK.TICKET_FORMS TGT USING ( SELECT DISTINCT * FROM DISC_PROD.ZENDESK.HIST_TICKET_FORMS WHERE ID IS NOT NULL AND ETL_LAST_UPDATED_DATE = ( SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_PROD.ZENDESK.HIST_TICKET_FORMS)) STAGE ON TGT.ID = STAGE.ID AND TGT.SOURCE = STAGE.SOURCE WHEN MATCHED THEN UPDATE SET TGT.SOURCE = STAGE.SOURCE , TGT.id = STAGE.JSON_DATA:id, TGT.url = STAGE.JSON_DATA:url, TGT.form_name = STAGE.JSON_DATA:name, TGT.display_name = STAGE.JSON_DATA:display_name, TGT.raw_name = STAGE.JSON_DATA:raw_name, TGT.raw_display_name = STAGE.JSON_DATA:raw_display_name, TGT.end_user_visible = STAGE.JSON_DATA:end_user_visible, TGT.position = STAGE.JSON_DATA:position, TGT.ticket_field_ids = STAGE.JSON_DATA:ticket_field_ids, TGT.active = STAGE.JSON_DATA:active, TGT.default = STAGE.JSON_DATA:default, TGT.created_at = STAGE.JSON_DATA:created_at, TGT.updated_at = STAGE.JSON_DATA:updated_at, TGT.in_all_brands = STAGE.JSON_DATA:in_all_brands, TGT.restricted_brand_ids = STAGE.JSON_DATA:restricted_brand_ids, TGT.end_user_conditions = STAGE.JSON_DATA:end_user_conditions, TGT.agent_conditions = STAGE.JSON_DATA:agent_conditions, TGT.ETL_TASK_KEY = STAGE.ETL_TASK_KEY , TGT.ETL_INSERTED_TASK_KEY = STAGE.ETL_INSERTED_TASK_KEY , TGT.ETL_INSERTED_DATE = STAGE.ETL_INSERTED_DATE , TGT.ETL_INSERTED_BY = STAGE.ETL_INSERTED_BY , TGT.ETL_LAST_UPDATED_DATE = STAGE.ETL_LAST_UPDATED_DATE , TGT.ETL_LAST_UPDATED_BY = STAGE.ETL_LAST_UPDATED_BY , TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG WHEN NOT MATCHED THEN INSERT ( SOURCE, id, url, form_name, display_name, raw_name, raw_display_name, end_user_visible, position, ticket_field_ids, active, default, created_at, updated_at, in_all_brands, restricted_brand_ids, end_user_conditions, agent_conditions, ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG ) VALUES ( STAGE.SOURCE , STAGE.JSON_DATA:id, STAGE.JSON_DATA:url, STAGE.JSON_DATA:name, STAGE.JSON_DATA:display_name, STAGE.JSON_DATA:raw_name, STAGE.JSON_DATA:raw_display_name, STAGE.JSON_DATA:end_user_visible, STAGE.JSON_DATA:position, STAGE.JSON_DATA:ticket_field_ids, STAGE.JSON_DATA:active, STAGE.JSON_DATA:default, STAGE.JSON_DATA:created_at, STAGE.JSON_DATA:updated_at, STAGE.JSON_DATA:in_all_brands, STAGE.JSON_DATA:restricted_brand_ids, STAGE.JSON_DATA:end_user_conditions, STAGE.JSON_DATA:agent_conditions, STAGE.ETL_TASK_KEY , STAGE.ETL_INSERTED_TASK_KEY , STAGE.ETL_INSERTED_DATE , STAGE.ETL_INSERTED_BY , STAGE.ETL_LAST_UPDATED_DATE , STAGE.ETL_LAST_UPDATED_BY , STAGE.ETL_DELETED_FLAG );

    return ''Success'';
END;
';