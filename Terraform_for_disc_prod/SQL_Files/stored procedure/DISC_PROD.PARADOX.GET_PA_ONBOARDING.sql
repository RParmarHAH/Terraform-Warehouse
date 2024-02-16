CREATE OR REPLACE PROCEDURE DISC_PROD.PARADOX.GET_PA_ONBOARDING("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
--*****************************************************************************************************************************
-- NAME:  GET_PA_ONBOARDING 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR										NOTES:
-- ----------		-------------------							-----------------------------------------------------------------------------------------------
-- 2023-11-20		KOMAL DHOKAI/RAVI SUTHAR					INITIAL DEVELOPMENT
--*****************************************************************************************************************************

 
BEGIN 
    --TARGETSQL
    COPY INTO DISC_PROD.PARADOX.HIST_PA_ONBOARDING FROM (SELECT A.$1 FORM_NAME,  A.$2 LOCATION_CODE,  A.$3 LOCATION_NAME,  A.$4 JOB_APPLIED_TO,  A.$5 JOB_REQ_ID,  A.$6 JOB_TITLE,  A.$7 CURRENT_CANDIDATE_JOURNEY_STATUS,  A.$8 CANDIDATE_ID,  A.$9 CANDIDATE_NAME,  A.$10 FORM_DATE_SENT,  A.$11 FORM_IN_PROGRESS_DATE,  A.$12 FORM_COMPLETION_STATUS,  A.$13 FORM_DATE_SUBMITTED,  A.$14 FORM_PREVIEW_LINK,  A.$15 PUBLISHED_DATE,  A.$16 PUBLISHED_VERSION,  A.$17 PROFILE_ID,  A.$18 MULTIPLE_RECORDS,  A.$19 PRIMARY_IDENTIFIER,  A.$20 REAPPLY_IN_CAPTURE,  A.$21 REAPPLY_IN_JOB_SEARCH,  A.$22 REAPPLY_IN_CAMPAIGN,  A.$23 ONBOARDING_DOCUMENTS_PLEASE_REVIEW_AND_ACCEPT_THE_JOB_REQUIREMENTS_JD,  A.$24 ONBOARDING_DOCUMENTS_JOB_DESCRIPTION,  A.$25 ONBOARDING_DOCUMENTS_DIRECT_DEPOSIT_ENROLLMENT,  NULL ONBOARDING_DOCUMENTS__WOTC_APPLICATION,  NULL ONBOARDING_DOCUMENTS__FACE_TO_FACE_INTERVIEW_DOCUMENTATION, A.$26 ONBOARDING_DOCUMENTS_ACKNOWLEDGMENT_OF_THE_INSURANCE_OFFER,  A.$27 ONBOARDING_DOCUMENTS_HEPATITIS_B_VACCINE_ACCEPTANCE_DECLINATION_FORM,  A.$28 ONBOARDING_DOCUMENTS_EMPLOYMENT_PROHIBITION_ACKNOWLEDGEMENT_FORM,  NULL ONBOARDING_DOCUMENTS__DIRECT_DEPOSIT_ENROLLMENT,  A.$29 ONBOARDING_DOCUMENTS_I_9,  NULL ONBOARDING_DOCUMENTS__W4,  A.$30 ONBOARDING_DOCUMENTS_TB_SYMPTOM_ASSESSMENT,  A.$31 ONBOARDING_DOCUMENTS_TB_RISK_ASSESSMENT,  NULL ONBOARDING_DOCUMENTS__TRAININGS,  NULL ONBOARDING_DOCUMENTS__PPD_COVID_TRAINING_ACKNOWLEDGEMENT,  NULL ONBOARDING_DOCUMENTS__EMPLOYEE_HANDBOOK_ACKNOWLEDGEMENT,  NULL ONBOARDING_DOCUMENTS__ACKNOWLEDGMENTS, A.$32 ONBOARDING_DOCUMENTS_FIELD_EMPLOYEE_HANDBOOK,  A.$33 ONBOARDING_DOCUMENTS_TRAININGS_ACKNOWLEDGMENTS,  A.$34 ONBOARDING_DOCUMENTS_TRAININGS_ACKNOWLEDGMENTS_SIGN_OFF,  A.$35 ONBOARDING_DOCUMENTS_FWA_FORM_SIGN_OFF,  A.$36 ONBOARDING_DOCUMENTS_HAH_CODE_OF_ETHICAL_STANDARDS,  A.$37 ONBOARDING_DOCUMENTS_WORKER_S_COMPENSATION,  A.$38 ONBOARDING_DOCUMENTS_BADGE_ID,  A.$39 ONBOARDING_DOCUMENTS_I_CONSENT_TO_HELP_AT_HOME_COMMUNICATING_WITH_ME_DURING_MY_EMPLOYMENT_USING_THE_PERSONAL_CONTACT_INFORMATION_I_PROVIDED_THIS_COMMUNICATION_MAY_BE_MADE_BY_BUT_IS_NOT_LIMITED_TO_TELEPHONE_SMS_TEXT_AND_EMAIL_,  A.$40 FINAL_SUBMISSION,  :TASKKEY AS ETL_TASK_KEY,  :TASKKEY AS ETL_INSERTED_TASK_KEY,  CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE,  CURRENT_USER() AS ETL_INSERTED_BY,  CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE,  CURRENT_USER() AS ETL_LAST_UPDATED_BY,  0 AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/PARADOX/UPLOAD_FILE/FORMSCANDIDATE.FORMS.DETAIL.REPORT.WIDE.FORMAT.PA.ONBOARDING (FILE_FORMAT => DISC_PROD.STAGE.CSV_FORMAT) A ); 

    --VIEWSQL
    CREATE OR REPLACE TABLE DISC_PROD.PARADOX.PA_ONBOARDING AS SELECT FORM_NAME FORM_NAME, LOCATION_CODE LOCATION_CODE, LOCATION_NAME LOCATION_NAME, JOB_APPLIED_TO JOB_APPLIED_TO, JOB_REQ_ID JOB_REQ_ID, JOB_TITLE JOB_TITLE, CURRENT_CANDIDATE_JOURNEY_STATUS CURRENT_CANDIDATE_JOURNEY_STATUS, CANDIDATE_ID CANDIDATE_ID, CANDIDATE_NAME CANDIDATE_NAME, FORM_DATE_SENT FORM_DATE_SENT, FORM_IN_PROGRESS_DATE FORM_IN_PROGRESS_DATE, FORM_COMPLETION_STATUS FORM_COMPLETION_STATUS, FORM_DATE_SUBMITTED FORM_DATE_SUBMITTED, FORM_PREVIEW_LINK FORM_PREVIEW_LINK, PUBLISHED_DATE PUBLISHED_DATE, PUBLISHED_VERSION PUBLISHED_VERSION, PROFILE_ID PROFILE_ID, MULTIPLE_RECORDS MULTIPLE_RECORDS, PRIMARY_IDENTIFIER PRIMARY_IDENTIFIER, REAPPLY_IN_CAPTURE REAPPLY_IN_CAPTURE, REAPPLY_IN_JOB_SEARCH REAPPLY_IN_JOB_SEARCH, REAPPLY_IN_CAMPAIGN REAPPLY_IN_CAMPAIGN, ONBOARDING_DOCUMENTS__WOTC_APPLICATION ONBOARDING_DOCUMENTS__WOTC_APPLICATION, ONBOARDING_DOCUMENTS__FACE_TO_FACE_INTERVIEW_DOCUMENTATION ONBOARDING_DOCUMENTS__FACE_TO_FACE_INTERVIEW_DOCUMENTATION, ONBOARDING_DOCUMENTS__ACKNOWLEDGMENT_OF_THE_INSURANCE_OFFER ONBOARDING_DOCUMENTS__ACKNOWLEDGMENT_OF_THE_INSURANCE_OFFER, ONBOARDING_DOCUMENTS__HEPATITIS_B_VACCINE_ACCEPTANCE_DECLINATION_FORM ONBOARDING_DOCUMENTS__HEPATITIS_B_VACCINE_ACCEPTANCE_DECLINATION_FORM, ONBOARDING_DOCUMENTS__EMPLOYMENT_PROHIBITION_ACKNOWLEDGMENT_FORM ONBOARDING_DOCUMENTS__EMPLOYMENT_PROHIBITION_ACKNOWLEDGMENT_FORM, ONBOARDING_DOCUMENTS__DIRECT_DEPOSIT_ENROLLMENT ONBOARDING_DOCUMENTS__DIRECT_DEPOSIT_ENROLLMENT, ONBOARDING_DOCUMENTS__I9 ONBOARDING_DOCUMENTS__I9, ONBOARDING_DOCUMENTS__W4 ONBOARDING_DOCUMENTS__W4, ONBOARDING_DOCUMENTS__TB_SYMPTOM_ASSESSMENT ONBOARDING_DOCUMENTS__TB_SYMPTOM_ASSESSMENT, ONBOARDING_DOCUMENTS__TB_RISK_ASSESSMENT ONBOARDING_DOCUMENTS__TB_RISK_ASSESSMENT, ONBOARDING_DOCUMENTS__TRAININGS ONBOARDING_DOCUMENTS__TRAININGS, ONBOARDING_DOCUMENTS__PPD_COVID_TRAINING_ACKNOWLEDGEMENT ONBOARDING_DOCUMENTS__PPD_COVID_TRAINING_ACKNOWLEDGEMENT, ONBOARDING_DOCUMENTS__EMPLOYEE_HANDBOOK_ACKNOWLEDGEMENT ONBOARDING_DOCUMENTS__EMPLOYEE_HANDBOOK_ACKNOWLEDGEMENT, ONBOARDING_DOCUMENTS__ACKNOWLEDGMENTS ONBOARDING_DOCUMENTS__ACKNOWLEDGMENTS, ONBOARDING_DOCUMENTS__I_CONSENT_TO_HELP_AT_HOME_COMMUNICATING_WITH_ME_DURING_MY_EMPLOYMENT_USING_THE_PERSONAL_CONTACT_INFORMATION_I_PROVIDED__THIS_COMMUNICATION_MAY_BE_MADE_BY_BUT_IS_NOT_LIMITED_TO_TELEPHONE_SMS_TEXT_AND_EMAIL ONBOARDING_DOCUMENTS__I_CONSENT_TO_HELP_AT_HOME_COMMUNICATING_WITH_ME_DURING_MY_EMPLOYMENT_USING_THE_PERSONAL_CONTACT_INFORMATION_I_PROVIDED__THIS_COMMUNICATION_MAY_BE_MADE_BY_BUT_IS_NOT_LIMITED_TO_TELEPHONE_SMS_TEXT_AND_EMAIL, FINAL_SUBMISSION FINAL_SUBMISSION, :TASKKEY AS ETL_TASK_KEY, :TASKKEY AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM DISC_PROD.PARADOX.HIST_PA_ONBOARDING WHERE ETL_LAST_UPDATED_DATE = (SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_PROD.PARADOX.HIST_PA_ONBOARDING);

    RETURN ''SUCCESS'';
END;

';