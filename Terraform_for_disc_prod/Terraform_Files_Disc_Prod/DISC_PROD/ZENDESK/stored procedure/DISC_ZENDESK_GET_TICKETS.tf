resource "snowflake_procedure" "DISC_ZENDESK_GET_TICKETS" {
	name ="GET_TICKETS"
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
-- NAME:  DISC_${var.SF_ENVIRONMENT}.ZENDESK.GET_TICKETS 
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
    INSERT INTO DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_TICKETS SELECT DISTINCT ''AMS'' AS SOURCE,j.$1:id::varchar id,j.$1::VARIANT JSON_DATA,:TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY,current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE,current_user() AS ETL_INSERTED_BY,current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE,current_user() AS ETL_LAST_UPDATED_BY,0 as ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Zendesk/output/tickets_ams.json(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_JSON_FORMAT) j UNION SELECT DISTINCT ''Payroll'' AS SOURCE,j2.$1:id::varchar id,j2.$1::VARIANT JSON_DATA,:TaskKey AS ETL_TASK_KEY,:TaskKey AS ETL_INSERTED_TASK_KEY,current_timestamp::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE,current_user() AS ETL_INSERTED_BY,current_timestamp::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE,current_user() AS ETL_LAST_UPDATED_BY,0 as ETL_DELETED_FLAG FROM @DISC_${var.SF_ENVIRONMENT}.STAGE.AWSAZSTAGEPROD/Zendesk/output/tickets_payroll.json(file_format => DISC_${var.SF_ENVIRONMENT}.STAGE.MY_JSON_FORMAT) j2;

    --ViewSQL
    MERGE INTO DISC_${var.SF_ENVIRONMENT}.ZENDESK.TICKETS TGT USING ( SELECT * FROM DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_TICKETS WHERE ETL_LAST_UPDATED_DATE = (SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_${var.SF_ENVIRONMENT}.ZENDESK.HIST_TICKETS)) STAGE ON TGT.ID = STAGE.ID AND TGT.SOURCE = STAGE.SOURCE WHEN MATCHED THEN UPDATE SET TGT.SOURCE = STAGE.SOURCE ,TGT.allow_attachments = STAGE.JSON_DATA:allow_attachments ,TGT.allow_channelback = STAGE.JSON_DATA:allow_channelback ,TGT.assignee_id = STAGE.JSON_DATA:assignee_id ,TGT.brand_id = STAGE.JSON_DATA:brand_id ,TGT.collaborator_ids = STAGE.JSON_DATA:collaborator_ids ,TGT.created_at = STAGE.JSON_DATA:created_at ,TGT.custom_fields = STAGE.JSON_DATA:custom_fields ,TGT.description = STAGE.JSON_DATA:description ,TGT.due = STAGE.JSON_DATA:due_at ,TGT.email_cc_ids = STAGE.JSON_DATA:email_cc_ids ,TGT.external_id = STAGE.JSON_DATA:external_id ,TGT.fields = STAGE.JSON_DATA:fields ,TGT.follower_ids = STAGE.JSON_DATA:follower_ids ,TGT.followup_ids = STAGE.JSON_DATA:followup_ids ,TGT.forum_topic_id = STAGE.JSON_DATA:forum_topic_id ,TGT.group_id = STAGE.JSON_DATA:group_id ,TGT.has_incidents = STAGE.JSON_DATA:has_incidents ,TGT.id = STAGE.JSON_DATA:id ,TGT.is_public = STAGE.JSON_DATA:is_public ,TGT.organization_id = STAGE.JSON_DATA:organization_id ,TGT.priority = STAGE.JSON_DATA:priority ,TGT.problem_id = STAGE.JSON_DATA:problem_id ,TGT.raw_subject = STAGE.JSON_DATA:raw_subject ,TGT.recipient = STAGE.JSON_DATA:recipient ,TGT.requester_id = STAGE.JSON_DATA:requester_id ,TGT.satisfaction_rating = STAGE.JSON_DATA:satisfaction_rating ,TGT.sharing_agreement_ids = STAGE.JSON_DATA:sharing_agreement_ids ,TGT.status = STAGE.JSON_DATA:status ,TGT.subject = STAGE.JSON_DATA:subject ,TGT.submitter_id = STAGE.JSON_DATA:submitter_id ,TGT.tags = STAGE.JSON_DATA:tags ,TGT.ticket_form_id = STAGE.JSON_DATA:ticket_form_id ,TGT.type = STAGE.JSON_DATA:type ,TGT.updated_at = STAGE.JSON_DATA:updated_at ,TGT.url = STAGE.JSON_DATA:url ,TGT.via = STAGE.JSON_DATA:via ,TGT.ETL_TASK_KEY = STAGE.ETL_TASK_KEY  ,TGT.ETL_INSERTED_TASK_KEY = STAGE.ETL_INSERTED_TASK_KEY  ,TGT.ETL_INSERTED_DATE = STAGE.ETL_INSERTED_DATE  ,TGT.ETL_INSERTED_BY = STAGE.ETL_INSERTED_BY  ,TGT.ETL_LAST_UPDATED_DATE = STAGE.ETL_LAST_UPDATED_DATE  ,TGT.ETL_LAST_UPDATED_BY = STAGE.ETL_LAST_UPDATED_BY  ,TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG  WHEN NOT MATCHED THEN INSERT ( SOURCE ,allow_attachments ,allow_channelback ,assignee_id ,brand_id ,collaborator_ids ,created_at ,custom_fields ,description ,due ,email_cc_ids ,external_id ,fields ,follower_ids ,followup_ids ,forum_topic_id ,group_id ,has_incidents ,id ,is_public ,organization_id ,priority ,problem_id ,raw_subject ,recipient ,requester_id ,satisfaction_rating ,sharing_agreement_ids ,status ,subject ,submitter_id ,tags ,ticket_form_id ,type ,updated_at ,url ,via , ETL_TASK_KEY , ETL_INSERTED_TASK_KEY , ETL_INSERTED_DATE , ETL_INSERTED_BY , ETL_LAST_UPDATED_DATE , ETL_LAST_UPDATED_BY , ETL_DELETED_FLAG) VALUES ( STAGE.SOURCE ,STAGE.JSON_DATA:allow_attachments ,STAGE.JSON_DATA:allow_channelback ,STAGE.JSON_DATA:assignee_id ,STAGE.JSON_DATA:brand_id ,STAGE.JSON_DATA:collaborator_ids ,STAGE.JSON_DATA:created_at ,STAGE.JSON_DATA:custom_fields ,STAGE.JSON_DATA:description ,STAGE.JSON_DATA:due_at ,STAGE.JSON_DATA:email_cc_ids ,STAGE.JSON_DATA:external_id ,STAGE.JSON_DATA:fields ,STAGE.JSON_DATA:follower_ids ,STAGE.JSON_DATA:followup_ids ,STAGE.JSON_DATA:forum_topic_id ,STAGE.JSON_DATA:group_id ,STAGE.JSON_DATA:has_incidents ,STAGE.JSON_DATA:id ,STAGE.JSON_DATA:is_public ,STAGE.JSON_DATA:organization_id ,STAGE.JSON_DATA:priority ,STAGE.JSON_DATA:problem_id ,STAGE.JSON_DATA:raw_subject ,STAGE.JSON_DATA:recipient ,STAGE.JSON_DATA:requester_id ,STAGE.JSON_DATA:satisfaction_rating ,STAGE.JSON_DATA:sharing_agreement_ids ,STAGE.JSON_DATA:status ,STAGE.JSON_DATA:subject ,STAGE.JSON_DATA:submitter_id ,STAGE.JSON_DATA:tags ,STAGE.JSON_DATA:ticket_form_id ,STAGE.JSON_DATA:type ,STAGE.JSON_DATA:updated_at ,STAGE.JSON_DATA:url ,STAGE.JSON_DATA:via ,STAGE.ETL_TASK_KEY ,STAGE.ETL_INSERTED_TASK_KEY ,STAGE.ETL_INSERTED_DATE ,STAGE.ETL_INSERTED_BY ,STAGE.ETL_LAST_UPDATED_DATE ,STAGE.ETL_LAST_UPDATED_BY ,STAGE.ETL_DELETED_FLAG);

    return ''Success'';
END;

 EOT
}

