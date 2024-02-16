resource "snowflake_procedure" "DISC_ZENDESK_GET_TICKET_METRICS" {
	name ="GET_TICKET_METRICS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ZENDESK.GET_TICKET_METRICS 
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
    INSERT INTO DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_TICKET_METRICS SELECT DISTINCT ''AMS'' AS SOURCE, j.$1:id::varchar id, j.$1::VARIANT JSON_DATA, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Zendesk/output/ticket_metrics.json(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_JSON_FORMAT) j WHERE id IS NOT NULL;

    --ViewSQL
    MERGE INTO DISC_${var.SF_ENVIRONMENT}.ZENDESK.TICKET_METRICS TGT USING ( SELECT DISTINCT * FROM DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_TICKET_METRICS WHERE ETL_LAST_UPDATED_DATE = ( SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_TICKET_METRICS)) STAGE ON TGT.ID = STAGE.ID AND TGT.SOURCE = STAGE.SOURCE WHEN MATCHED THEN UPDATE SET TGT.SOURCE = STAGE.SOURCE , TGT.id = STAGE.JSON_DATA:id, TGT.url = STAGE.JSON_DATA:url , TGT.ticket_id = STAGE.JSON_DATA:ticket_id , TGT.created_at = STAGE.JSON_DATA:created_at , TGT.updated_at = STAGE.JSON_DATA:updated_at , TGT.group_stations = STAGE.JSON_DATA:group_stations , TGT.assignee_stations = STAGE.JSON_DATA:assignee_stations , TGT.reopens = STAGE.JSON_DATA:reopens , TGT.replies = STAGE.JSON_DATA:replies , TGT.assignee_updated_at = STAGE.JSON_DATA:assignee_updated_at , TGT.requester_updated_at = STAGE.JSON_DATA:requester_updated_at , TGT.status_updated_at = STAGE.JSON_DATA:status_updated_at , TGT.initially_assigned_at = STAGE.JSON_DATA:initially_assigned_at , TGT.assigned_at = STAGE.JSON_DATA:assigned_at , TGT.solved_at = STAGE.JSON_DATA:solved_at , TGT.latest_comment_added_at = STAGE.JSON_DATA:latest_comment_added_at , TGT.reply_time_in_minutes_calendar = STAGE.JSON_DATA:reply_time_in_minutes.calendar , TGT.reply_time_in_minutes_business = STAGE.JSON_DATA:reply_time_in_minutes.business , TGT.first_resolution_time_in_minutes_calendar = STAGE.JSON_DATA:first_resolution_time_in_minutes.calendar , TGT.first_resolution_time_in_minutes_business = STAGE.JSON_DATA:first_resolution_time_in_minutes.business , TGT.full_resolution_time_in_minutes_calendar = STAGE.JSON_DATA:full_resolution_time_in_minutes.calendar , TGT.full_resolution_time_in_minutes_business = STAGE.JSON_DATA:full_resolution_time_in_minutes.business , TGT.agent_wait_time_in_minutes_calendar = STAGE.JSON_DATA:agent_wait_time_in_minutes.calendar , TGT.agent_wait_time_in_minutes_business = STAGE.JSON_DATA:agent_wait_time_in_minutes.business , TGT.requester_wait_time_in_minutes_calendar = STAGE.JSON_DATA:requester_wait_time_in_minutes.calendar , TGT.requester_wait_time_in_minutes_business = STAGE.JSON_DATA:requester_wait_time_in_minutes.business , TGT.on_hold_time_in_minutes_calendar = STAGE.JSON_DATA:on_hold_time_in_minutes.calendar , TGT.on_hold_time_in_minutes_business = STAGE.JSON_DATA:on_hold_time_in_minutes.business , TGT.custom_status_updated_at = STAGE.JSON_DATA:custom_status_updated_at , TGT.ETL_TASK_KEY = STAGE.ETL_TASK_KEY , TGT.ETL_INSERTED_TASK_KEY = STAGE.ETL_INSERTED_TASK_KEY , TGT.ETL_INSERTED_DATE = STAGE.ETL_INSERTED_DATE , TGT.ETL_INSERTED_BY = STAGE.ETL_INSERTED_BY , TGT.ETL_LAST_UPDATED_DATE = STAGE.ETL_LAST_UPDATED_DATE , TGT.ETL_LAST_UPDATED_BY = STAGE.ETL_LAST_UPDATED_BY , TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG WHEN NOT MATCHED THEN INSERT ( SOURCE, id, url, ticket_id, created_at, updated_at, group_stations, assignee_stations, reopens, replies, assignee_updated_at, requester_updated_at, status_updated_at, initially_assigned_at, assigned_at, solved_at, latest_comment_added_at, reply_time_in_minutes_calendar, reply_time_in_minutes_business, first_resolution_time_in_minutes_calendar, first_resolution_time_in_minutes_business, full_resolution_time_in_minutes_calendar, full_resolution_time_in_minutes_business, agent_wait_time_in_minutes_calendar, agent_wait_time_in_minutes_business, requester_wait_time_in_minutes_calendar, requester_wait_time_in_minutes_business, on_hold_time_in_minutes_calendar, on_hold_time_in_minutes_business, custom_status_updated_at, ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG ) VALUES ( STAGE.SOURCE , STAGE.JSON_DATA:id, STAGE.JSON_DATA:url , STAGE.JSON_DATA:ticket_id , STAGE.JSON_DATA:created_at , STAGE.JSON_DATA:updated_at , STAGE.JSON_DATA:group_stations , STAGE.JSON_DATA:assignee_stations , STAGE.JSON_DATA:reopens , STAGE.JSON_DATA:replies , STAGE.JSON_DATA:assignee_updated_at , STAGE.JSON_DATA:requester_updated_at , STAGE.JSON_DATA:status_updated_at , STAGE.JSON_DATA:initially_assigned_at , STAGE.JSON_DATA:assigned_at , STAGE.JSON_DATA:solved_at , STAGE.JSON_DATA:latest_comment_added_at , STAGE.JSON_DATA:reply_time_in_minutes.calendar , STAGE.JSON_DATA:reply_time_in_minutes.business , STAGE.JSON_DATA:first_resolution_time_in_minutes.calendar , STAGE.JSON_DATA:first_resolution_time_in_minutes.business , STAGE.JSON_DATA:full_resolution_time_in_minutes.calendar , STAGE.JSON_DATA:full_resolution_time_in_minutes.business , STAGE.JSON_DATA:agent_wait_time_in_minutes.calendar , STAGE.JSON_DATA:agent_wait_time_in_minutes.business , STAGE.JSON_DATA:requester_wait_time_in_minutes.calendar , STAGE.JSON_DATA:requester_wait_time_in_minutes.business , STAGE.JSON_DATA:on_hold_time_in_minutes.calendar , STAGE.JSON_DATA:on_hold_time_in_minutes.business , STAGE.JSON_DATA:custom_status_updated_at , STAGE.ETL_TASK_KEY , STAGE.ETL_INSERTED_TASK_KEY , STAGE.ETL_INSERTED_DATE , STAGE.ETL_INSERTED_BY , STAGE.ETL_LAST_UPDATED_DATE , STAGE.ETL_LAST_UPDATED_BY , STAGE.ETL_DELETED_FLAG);

    return ''Success'';
END;

 EOT
}

