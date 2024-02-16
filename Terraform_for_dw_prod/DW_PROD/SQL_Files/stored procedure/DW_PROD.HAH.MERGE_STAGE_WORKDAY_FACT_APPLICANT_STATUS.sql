CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_WORKDAY_FACT_APPLICANT_STATUS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    MERGE INTO DW_PROD.HAH.FACT_APPLICANT_STATUS TGT 
    USING DW_PROD.STAGE.WORKDAY_FACT_APPLICANT_STATUS STAGE
ON TGT.APPLICANT_STATUS_KEY = STAGE.APPLICANT_STATUS_KEY
WHEN MATCHED THEN 
UPDATE SET 
	TGT.SOURCE_SYSTEM_ID= STAGE.SOURCE_SYSTEM_ID,
	TGT.SYSTEM_CODE= STAGE.SYSTEM_CODE,
	TGT.APPLICANT_KEY= STAGE.APPLICANT_KEY,
	TGT.JOB_KEY= STAGE.JOB_KEY,
	TGT.JOB_FAMILY= STAGE.JOB_FAMILY,
	TGT.CANDIDATE_ID= STAGE.CANDIDATE_ID,
	TGT.LINKED_ID=STAGE.LINKED_ID,
	TGT.SEND_TO_AMS=STAGE.SEND_TO_AMS,
    TGT.PRE_BOARDING_COMPLETION=STAGE.PRE_BOARDING_COMPLETION,
	TGT.DATE_APPLIED= STAGE.DATE_APPLIED,
	TGT.CONVERSATION_INPROGRESS_DATETIME= STAGE.CONVERSATION_INPROGRESS_DATETIME,
	TGT.INTERVIEW_SCHEDULED_DATETIME= STAGE.INTERVIEW_SCHEDULED_DATETIME,
	TGT.INTERVIEW_RESCHEDULED_DATETIME= STAGE.INTERVIEW_RESCHEDULED_DATETIME,
	TGT.INTERVIEW_COMPLETED_DATETIME= STAGE.INTERVIEW_COMPLETED_DATETIME,
	TGT.INTERVIEW_NO_SHOW_DATETIME= STAGE.INTERVIEW_NO_SHOW_DATETIME,
	TGT.INTERVIEW_NO_AVAILABILITY_DATETIME= STAGE.INTERVIEW_NO_AVAILABILITY_DATETIME,
	TGT.NUMBER_OF_TIMES_INTERVIEW_SCHEDULED= STAGE.NUMBER_OF_TIMES_INTERVIEW_SCHEDULED,
	TGT.Application_and_Background_Check_Consent_Form_Complete_DATETIME= STAGE.Application_and_Background_Check_Consent_Form_Complete_DATETIME,
	TGT.OFFERS_SENT_DATETIME= STAGE.OFFERS_SENT_DATETIME,
	TGT.OFFERS_ACCEPTED_DATETIME= STAGE.OFFERS_ACCEPTED_DATETIME,
	TGT.ONBOARDING_SENT_DATETIME= STAGE.ONBOARDING_SENT_DATETIME,
	TGT.ONBOARDING_COMPLETED_DATETIME=STAGE.ONBOARDING_COMPLETED_DATETIME,
	TGT.ONBOARDING_COMPLETE_FLAG=STAGE.ONBOARDING_COMPLETE_FLAG,
	TGT.HIRED_DATETIME= STAGE.HIRED_DATETIME,
	TGT.REHIRE_DATETIME= STAGE.REHIRE_DATETIME,
	TGT.OFFER_DECLINED_DATETIME= STAGE.OFFER_DECLINED_DATETIME,
	TGT.REJECTED_DATETIME= STAGE.REJECTED_DATETIME,
	TGT.REJECTION_REASON= STAGE.REJECTION_REASON,
	TGT.MOST_RECENT_STAGE_DATETIME= STAGE.MOST_RECENT_STAGE_DATETIME,
	TGT.APPLICANT_STATUS= STAGE.APPLICANT_STATUS,
    TGT.EMPLOYEE_STATUS= STAGE.EMPLOYEE_STATUS,
	TGT.DISPOSITION_REASON=STAGE.DISPOSITION_REASON,
	TGT.PRIOR_STATUS= STAGE.PRIOR_STATUS,
	TGT.PRIOR_STATUS_DATETIME= STAGE.PRIOR_STATUS_DATETIME,
	TGT.BRANCH_KEY= STAGE.BRANCH_KEY,
	TGT.BRANCH_NAME= STAGE.BRANCH_NAME,
	TGT.SOURCE= STAGE.SOURCE,
	TGT.ETL_TASK_KEY= STAGE.ETL_TASK_KEY,
	TGT.ETL_INSERTED_TASK_KEY= STAGE.ETL_INSERTED_TASK_KEY,
	TGT.ETL_INSERTED_DATE= STAGE.ETL_INSERTED_DATE,
	TGT.ETL_INSERTED_BY= STAGE.ETL_INSERTED_BY,
	TGT.ETL_LAST_UPDATED_DATE= STAGE.ETL_LAST_UPDATED_DATE,
	TGT.ETL_LAST_UPDATED_BY= STAGE.ETL_LAST_UPDATED_BY,
	TGT.ETL_DELETED_FLAG= STAGE.ETL_DELETED_FLAG,
	TGT.BRANCH_STATE_CODE= STAGE.BRANCH_STATE_CODE
WHEN NOT MATCHED THEN 
INSERT ( 
    APPLICANT_STATUS_KEY,
	SOURCE_SYSTEM_ID,
	SYSTEM_CODE,
	APPLICANT_KEY,
	JOB_KEY,
	JOB_FAMILY,
	CANDIDATE_ID,
    LINKED_ID,
	SEND_TO_AMS,
    PRE_BOARDING_COMPLETION,
	DATE_APPLIED,
	CONVERSATION_INPROGRESS_DATETIME,
	INTERVIEW_SCHEDULED_DATETIME,
	INTERVIEW_RESCHEDULED_DATETIME,
	INTERVIEW_COMPLETED_DATETIME,
	INTERVIEW_NO_SHOW_DATETIME,
	INTERVIEW_NO_AVAILABILITY_DATETIME,
	NUMBER_OF_TIMES_INTERVIEW_SCHEDULED,
	Application_and_Background_Check_Consent_Form_Complete_DATETIME,
	OFFERS_SENT_DATETIME,
	OFFERS_ACCEPTED_DATETIME,
	ONBOARDING_SENT_DATETIME,
    ONBOARDING_COMPLETED_DATETIME,
	ONBOARDING_COMPLETE_FLAG,
	HIRED_DATETIME,
	REHIRE_DATETIME,
	OFFER_DECLINED_DATETIME,
	REJECTED_DATETIME,
	REJECTION_REASON,
	MOST_RECENT_STAGE_DATETIME,
	APPLICANT_STATUS,
    EMPLOYEE_STATUS,
    DISPOSITION_REASON,
	PRIOR_STATUS,
	PRIOR_STATUS_DATETIME,
	BRANCH_KEY,
	BRANCH_NAME,
	SOURCE,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY,
	ETL_DELETED_FLAG,
	BRANCH_STATE_CODE 
) 
VALUES (
    STAGE.APPLICANT_STATUS_KEY,
	STAGE.SOURCE_SYSTEM_ID,
	STAGE.SYSTEM_CODE,
    STAGE.APPLICANT_KEY,
    STAGE.JOB_KEY,
	STAGE.JOB_FAMILY,
	STAGE.CANDIDATE_ID,
	STAGE.LINKED_ID,
	STAGE.SEND_TO_AMS,
    STAGE.PRE_BOARDING_COMPLETION,
	STAGE.DATE_APPLIED,
	STAGE.CONVERSATION_INPROGRESS_DATETIME,
	STAGE.INTERVIEW_SCHEDULED_DATETIME,
	STAGE.INTERVIEW_RESCHEDULED_DATETIME,
	STAGE.INTERVIEW_COMPLETED_DATETIME,
	STAGE.INTERVIEW_NO_SHOW_DATETIME,
	STAGE.INTERVIEW_NO_AVAILABILITY_DATETIME,
	STAGE.NUMBER_OF_TIMES_INTERVIEW_SCHEDULED,
	STAGE.Application_and_Background_Check_Consent_Form_Complete_DATETIME,
	STAGE.OFFERS_SENT_DATETIME,
	STAGE.OFFERS_ACCEPTED_DATETIME,
	STAGE.ONBOARDING_SENT_DATETIME,
	STAGE.ONBOARDING_COMPLETED_DATETIME,
	STAGE.ONBOARDING_COMPLETE_FLAG,
	STAGE.HIRED_DATETIME,
	STAGE.REHIRE_DATETIME,
	STAGE.OFFER_DECLINED_DATETIME,
	STAGE.REJECTED_DATETIME,
	STAGE.REJECTION_REASON,
	STAGE.MOST_RECENT_STAGE_DATETIME,
	STAGE.APPLICANT_STATUS,
    STAGE.EMPLOYEE_STATUS,
    STAGE.DISPOSITION_REASON,
	STAGE.PRIOR_STATUS,
	STAGE.PRIOR_STATUS_DATETIME,
	STAGE.BRANCH_KEY,
	STAGE.BRANCH_NAME,
	STAGE.SOURCE,
	STAGE.ETL_TASK_KEY,
	STAGE.ETL_INSERTED_TASK_KEY,
	STAGE.ETL_INSERTED_DATE,
	STAGE.ETL_INSERTED_BY,
	STAGE.ETL_LAST_UPDATED_DATE,
	STAGE.ETL_LAST_UPDATED_BY,
	STAGE.ETL_DELETED_FLAG,
	STAGE.BRANCH_STATE_CODE
);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Insrted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';