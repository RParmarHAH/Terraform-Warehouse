resource "snowflake_procedure" "DISC_ZENDESK_GET_CALLS" {
	name ="GET_CALLS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ZENDESK.GET_CALLS 
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
    INSERT INTO DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_CALLS SELECT DISTINCT ''AMS'' AS SOURCE, j.$1:id::varchar id, j.$1::VARIANT JSON_DATA, :TaskKey AS ETL_TASK_KEY, :TaskKey AS ETL_INSERTED_TASK_KEY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, current_user() AS ETL_INSERTED_BY, current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, current_user() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Zendesk/output/calls.json(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_JSON_FORMAT) j WHERE id IS NOT NULL;

    --ViewSQL
    MERGE INTO DISC_${var.SF_ENVIRONMENT}.ZENDESK.CALLS TGT USING ( SELECT DISTINCT * FROM DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_CALLS WHERE ETL_LAST_UPDATED_DATE = ( SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_CALLS)) STAGE ON TGT.ID = STAGE.ID AND TGT.SOURCE = STAGE.SOURCE WHEN MATCHED THEN UPDATE SET TGT.SOURCE = STAGE.SOURCE , TGT.id = STAGE.JSON_DATA:id, TGT.created_at = STAGE.JSON_DATA:created_at , TGT.updated_at = STAGE.JSON_DATA:updated_at , TGT.agent_id = STAGE.JSON_DATA:agent_id , TGT.call_charge = STAGE.JSON_DATA:call_charge , TGT.consultation_time = STAGE.JSON_DATA:consultation_time , TGT.completion_status = STAGE.JSON_DATA:completion_status , TGT.customer_id = STAGE.JSON_DATA:customer_id , TGT.customer_requested_voicemail = STAGE.JSON_DATA:customer_requested_voicemail , TGT.direction = STAGE.JSON_DATA:direction , TGT.duration = STAGE.JSON_DATA:duration , TGT.exceeded_queue_wait_time = STAGE.JSON_DATA:exceeded_queue_wait_time , TGT.hold_time = STAGE.JSON_DATA:hold_time , TGT.minutes_billed = STAGE.JSON_DATA:minutes_billed , TGT.outside_business_hours = STAGE.JSON_DATA:outside_business_hours , TGT.phone_number_id = STAGE.JSON_DATA:phone_number_id , TGT.phone_number = STAGE.JSON_DATA:phone_number , TGT.ticket_id = STAGE.JSON_DATA:ticket_id , TGT.time_to_answer = STAGE.JSON_DATA:time_to_answer , TGT.voicemail = STAGE.JSON_DATA:voicemail , TGT.wait_time = STAGE.JSON_DATA:wait_time , TGT.wrap_up_time = STAGE.JSON_DATA:wrap_up_time , TGT.ivr_time_spent = STAGE.JSON_DATA:ivr_time_spent , TGT.ivr_hops = STAGE.JSON_DATA:ivr_hops , TGT.ivr_destination_group_name = STAGE.JSON_DATA:ivr_destination_group_name , TGT.talk_time = STAGE.JSON_DATA:talk_time , TGT.ivr_routed_to = STAGE.JSON_DATA:ivr_routed_to , TGT.callback = STAGE.JSON_DATA:callback , TGT.callback_source = STAGE.JSON_DATA:callback_source , TGT.default_group = STAGE.JSON_DATA:default_group , TGT.ivr_action = STAGE.JSON_DATA:ivr_action , TGT.line = STAGE.JSON_DATA:line , TGT.line_id = STAGE.JSON_DATA:line_id , TGT.line_type = STAGE.JSON_DATA:line_type , TGT.overflowed = STAGE.JSON_DATA:overflowed , TGT.overflowed_to = STAGE.JSON_DATA:overflowed_to , TGT.recording_control_interactions = STAGE.JSON_DATA:recording_control_interactions , TGT.recording_time = STAGE.JSON_DATA:recording_time , TGT.not_recording_time = STAGE.JSON_DATA:not_recording_time , TGT.call_recording_consent = STAGE.JSON_DATA:call_recording_consent , TGT.call_recording_consent_action = STAGE.JSON_DATA:call_recording_consent_action , TGT.call_recording_consent_keypress = STAGE.JSON_DATA:call_recording_consent_keypress , TGT.call_group_id = STAGE.JSON_DATA:call_group_id , TGT.call_channel = STAGE.JSON_DATA:call_channel , TGT.quality_issues = STAGE.JSON_DATA:quality_issues , TGT.ETL_TASK_KEY = STAGE.ETL_TASK_KEY , TGT.ETL_INSERTED_TASK_KEY = STAGE.ETL_INSERTED_TASK_KEY , TGT.ETL_INSERTED_DATE = STAGE.ETL_INSERTED_DATE , TGT.ETL_INSERTED_BY = STAGE.ETL_INSERTED_BY , TGT.ETL_LAST_UPDATED_DATE = STAGE.ETL_LAST_UPDATED_DATE , TGT.ETL_LAST_UPDATED_BY = STAGE.ETL_LAST_UPDATED_BY , TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG WHEN NOT MATCHED THEN INSERT ( SOURCE, id, created_at , updated_at , agent_id , call_charge , consultation_time , completion_status , customer_id , customer_requested_voicemail , direction , duration , exceeded_queue_wait_time , hold_time , minutes_billed , outside_business_hours , phone_number_id , phone_number , ticket_id , time_to_answer , voicemail , wait_time , wrap_up_time , ivr_time_spent , ivr_hops , ivr_destination_group_name , talk_time , ivr_routed_to , callback , callback_source , default_group , ivr_action , line , line_id , line_type , overflowed , overflowed_to , recording_control_interactions , recording_time , not_recording_time , call_recording_consent , call_recording_consent_action , call_recording_consent_keypress , call_group_id , call_channel , quality_issues , ETL_TASK_KEY , ETL_INSERTED_TASK_KEY , ETL_INSERTED_DATE , ETL_INSERTED_BY , ETL_LAST_UPDATED_DATE , ETL_LAST_UPDATED_BY , ETL_DELETED_FLAG) VALUES ( STAGE.SOURCE , STAGE.JSON_DATA:id, STAGE.JSON_DATA:created_at , STAGE.JSON_DATA:updated_at , STAGE.JSON_DATA:agent_id , STAGE.JSON_DATA:call_charge , STAGE.JSON_DATA:consultation_time , STAGE.JSON_DATA:completion_status , STAGE.JSON_DATA:customer_id , STAGE.JSON_DATA:customer_requested_voicemail , STAGE.JSON_DATA:direction , STAGE.JSON_DATA:duration , STAGE.JSON_DATA:exceeded_queue_wait_time , STAGE.JSON_DATA:hold_time , STAGE.JSON_DATA:minutes_billed , STAGE.JSON_DATA:outside_business_hours , STAGE.JSON_DATA:phone_number_id , STAGE.JSON_DATA:phone_number , STAGE.JSON_DATA:ticket_id , STAGE.JSON_DATA:time_to_answer , STAGE.JSON_DATA:voicemail , STAGE.JSON_DATA:wait_time , STAGE.JSON_DATA:wrap_up_time , STAGE.JSON_DATA:ivr_time_spent , STAGE.JSON_DATA:ivr_hops , STAGE.JSON_DATA:ivr_destination_group_name , STAGE.JSON_DATA:talk_time , STAGE.JSON_DATA:ivr_routed_to , STAGE.JSON_DATA:callback , STAGE.JSON_DATA:callback_source , STAGE.JSON_DATA:default_group , STAGE.JSON_DATA:ivr_action , STAGE.JSON_DATA:line , STAGE.JSON_DATA:line_id , STAGE.JSON_DATA:line_type , STAGE.JSON_DATA:overflowed , STAGE.JSON_DATA:overflowed_to , STAGE.JSON_DATA:recording_control_interactions , STAGE.JSON_DATA:recording_time , STAGE.JSON_DATA:not_recording_time , STAGE.JSON_DATA:call_recording_consent , STAGE.JSON_DATA:call_recording_consent_action , STAGE.JSON_DATA:call_recording_consent_keypress , STAGE.JSON_DATA:call_group_id , STAGE.JSON_DATA:call_channel , STAGE.JSON_DATA:quality_issues , STAGE.ETL_TASK_KEY , STAGE.ETL_INSERTED_TASK_KEY , STAGE.ETL_INSERTED_DATE , STAGE.ETL_INSERTED_BY , STAGE.ETL_LAST_UPDATED_DATE , STAGE.ETL_LAST_UPDATED_BY , STAGE.ETL_DELETED_FLAG );

    return ''Success'';
END;

 EOT
}

