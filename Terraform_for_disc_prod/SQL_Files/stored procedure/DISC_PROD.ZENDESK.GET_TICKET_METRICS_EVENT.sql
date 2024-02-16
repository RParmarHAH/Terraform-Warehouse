CREATE OR REPLACE PROCEDURE DISC_PROD.ZENDESK.GET_TICKET_METRICS_EVENT("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
--*****************************************************************************************************************************
-- NAME:  DISC_PROD.ZENDESK.GET_TICKET_METRICS_EVENT 
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
    INSERT INTO DISC_PROD.ZENDESK.HIST_TICKET_METRICS_EVENT(SELECT DISTINCT ''AMS'' AS SOURCE, j.$1:id::varchar id, j.$1::VARIANT JSON_DATA, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG     FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/Zendesk/output/ticket_metrics_event.json(file_format => DISC_PROD.STAGE.MY_JSON_FORMAT) j);

    --ViewSQL
    MERGE INTO DISC_PROD.ZENDESK.TICKET_METRICS_EVENT TGT USING ( SELECT DISTINCT * FROM DISC_PROD.ZENDESK.HIST_TICKET_METRICS_EVENT WHERE ETL_LAST_UPDATED_DATE = ( SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_PROD.ZENDESK.HIST_TICKET_METRICS_EVENT)) STAGE ON TGT.ID = STAGE.ID AND TGT.SOURCE = STAGE.SOURCE WHEN MATCHED THEN UPDATE SET TGT.SOURCE = STAGE.SOURCE , TGT.id = STAGE.JSON_DATA:id, TGT.TICKET_ID = STAGE.JSON_DATA:ticket_id , TGT.metric = STAGE.JSON_DATA:metric , TGT.instance_id = STAGE.JSON_DATA:instance_id , TGT.type = STAGE.JSON_DATA:type , TGT.time = STAGE.JSON_DATA:time , TGT.SLA_TARGET = STAGE.JSON_DATA:sla:target , TGT.SLA_BUSINESS_HOURS = STAGE.JSON_DATA:sla:business_hours , TGT.SLA_POLICY_ID = STAGE.JSON_DATA:sla:policy:id , TGT.SLA_POLICY_TITLE = STAGE.JSON_DATA:sla:policy:title , TGT.SLA_POLICY_DESCRIPTION = STAGE.JSON_DATA:sla:policy:description , TGT.STATUS_BUSINESS = STAGE.JSON_DATA:status:business , TGT.STATUS_CALENDAR = STAGE.JSON_DATA:status:calendar , TGT.ETL_TASK_KEY = STAGE.ETL_TASK_KEY , TGT.ETL_INSERTED_TASK_KEY = STAGE.ETL_INSERTED_TASK_KEY , TGT.ETL_INSERTED_DATE = STAGE.ETL_INSERTED_DATE , TGT.ETL_INSERTED_BY = STAGE.ETL_INSERTED_BY , TGT.ETL_LAST_UPDATED_DATE = STAGE.ETL_LAST_UPDATED_DATE , TGT.ETL_LAST_UPDATED_BY = STAGE.ETL_LAST_UPDATED_BY , TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG WHEN NOT MATCHED THEN INSERT ( SOURCE, ID, TICKET_ID, METRIC, INSTANCE_ID, TYPE, TIME, SLA_TARGET, SLA_BUSINESS_HOURS, SLA_POLICY_ID, SLA_POLICY_TITLE, SLA_POLICY_DESCRIPTION, STATUS_BUSINESS, STATUS_CALENDAR, ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG) VALUES (   STAGE.SOURCE ,  STAGE.JSON_DATA:id,  STAGE.JSON_DATA:ticket_id ,  STAGE.JSON_DATA:metric ,  STAGE.JSON_DATA:instance_id ,  STAGE.JSON_DATA:type ,  STAGE.JSON_DATA:time ,  STAGE.JSON_DATA:sla:target ,  STAGE.JSON_DATA:sla:business_hours ,  STAGE.JSON_DATA:sla:policy:id ,  STAGE.JSON_DATA:sla:policy:title ,  STAGE.JSON_DATA:sla:policy:description ,  STAGE.JSON_DATA:status:business ,  STAGE.JSON_DATA:status:calendar ,  STAGE.ETL_TASK_KEY ,  STAGE.ETL_INSERTED_TASK_KEY ,  STAGE.ETL_INSERTED_DATE ,  STAGE.ETL_INSERTED_BY ,  STAGE.ETL_LAST_UPDATED_DATE ,  STAGE.ETL_LAST_UPDATED_BY ,  STAGE.ETL_DELETED_FLAG );

    return ''Success'';
END;
';