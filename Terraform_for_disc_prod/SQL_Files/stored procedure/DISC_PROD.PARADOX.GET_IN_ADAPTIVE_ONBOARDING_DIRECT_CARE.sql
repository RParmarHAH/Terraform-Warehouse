CREATE OR REPLACE PROCEDURE DISC_PROD.PARADOX.GET_IN_ADAPTIVE_ONBOARDING_DIRECT_CARE("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
--*****************************************************************************************************************************
-- NAME:  GET_IN_ADAPTIVE_ONBOARDING_DIRECT_CARE 
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
    COPY INTO DISC_PROD.PARADOX.HIST_IN_ADAPTIVE_ONBOARDING_DIRECT_CARE FROM ( SELECT A.$1 FORM_NAME, A.$2 LOCATION_CODE, A.$3 LOCATION_NAME, A.$4 JOB_APPLIED_TO, A.$5 JOB_REQ_ID, A.$6 JOB_TITLE, A.$7 CURRENT_CANDIDATE_JOURNEY_STATUS, A.$8 CANDIDATE_ID, A.$9 CANDIDATE_NAME, A.$10 FORM_DATE_SENT, A.$11 FORM_IN_PROGRESS_DATE, A.$12 FORM_COMPLETION_STATUS, A.$13 FORM_DATE_SUBMITTED, A.$14 FORM_PREVIEW_LINK, A.$15 PUBLISHED_DATE, A.$16 PUBLISHED_VERSION, A.$17 PROFILE_ID, A.$18 MULTIPLE_RECORDS, A.$19 PRIMARY_IDENTIFIER, A.$20 REAPPLY_IN_CAPTURE, A.$21 REAPPLY_IN_JOB_SEARCH, A.$22 REAPPLY_IN_CAMPAIGN, A.$23 ONBOARDING_DOCUMENTS_PLEASE_REVIEW_AND_ACCEPT_THE_JOB_REQUIREMENTS_JD, A.$24 ONBOARDING_DOCUMENTS_HELP_AT_HOME_EEO_SURVEY, A.$25 ONBOARDING_DOCUMENTS_I_9, A.$26 ONBOARDING_DOCUMENTS_I_9_REQUIRED_DOCUMENTS, A.$27 ONBOARDING_DOCUMENTS_DIRECT_DEPOSIT, NULL ONBOARDING_DOCUMENTS_PLEASE_READ_BELOW, NULL ONBOARDING_DOCUMENTS_WOTC, NULL ONBOARDING_DOCUMENTS_ORIENTATION_CHECKLIST, NULL ONBOARDING_DOCUMENTS_TB_EDUCATION, A.$28 ONBOARDING_DOCUMENTS_ACKNOWLEDGEMENT_OF_INSURANCE_OFFER, NULL ONBOARDING_DOCUMENTS_HELP_AT_HOME_HANDBOOK, NULL ONBOARDING_DOCUMENTS_ACKNOWLEDGEMENT_HANDBOOK_SIGNOFF, NULL ONBOARDING_DOCUMENTS_NEPOTISM_ACKNOWLEDGEMENT, NULL ONBOARDING_DOCUMENTS_HEPATITIS_B_ACKNOWLEDGEMENT, NULL ONBOARDING_DOCUMENTS_BASIC_TRAINING_AND_NON_TRANSPORT_ACKNOWLEDGEMENT, A.$29 ONBOARDING_DOCUMENTS_HAH_CODE_OF_ETHICAL_STANDARDS, A.$30 ONBOARDING_DOCUMENTS_ADAPTIVE_HANDBOOK, A.$31 ONBOARDING_DOCUMENTS_I_CONSENT_TO_HELP_AT_HOME_COMMUNICATING_WITH_ME_DURING_MY_EMPLOYMENT_USING_THE_PERSONAL_CONTACT_INFORMATION_I_PROVIDED_THIS_COMMUNICATION_MAY_BE_MADE_BY_BUT_IS_NOT_LIMITED_TO_TELEPHONE_SMS_TEXT_AND_EMAIL_, A.$32 TAX_WITHHOLDING_TAX_WITHHOLDING, A.$33 TAX_WITHHOLDING_FEDERAL_TAX_FORMS, A.$34 TAX_WITHHOLDING_STATE_TAX_FORMS, A.$35 FINAL_SUBMISSION, :TASKKEY AS ETL_TASK_KEY, :TASKKEY AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG  FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/PARADOX/UPLOAD_FILE/FORMSCANDIDATE.FORMS.DETAIL.REPORT.WIDE.FORMAT.IN.ADAPTIVE.DIRECT.CARE.ONBOARDING (FILE_FORMAT => DISC_PROD.STAGE.CSV_FORMAT) A );

    --VIEWSQL
    CREATE OR REPLACE TABLE DISC_PROD.PARADOX.IN_ADAPTIVE_ONBOARDING_DIRECT_CARE AS  SELECT FORM_NAME FORM_NAME, LOCATION_CODE LOCATION_CODE, LOCATION_NAME LOCATION_NAME, JOB_APPLIED_TO JOB_APPLIED_TO, JOB_REQ_ID JOB_REQ_ID, JOB_TITLE JOB_TITLE, CURRENT_CANDIDATE_JOURNEY_STATUS CURRENT_CANDIDATE_JOURNEY_STATUS, CANDIDATE_ID CANDIDATE_ID, CANDIDATE_NAME CANDIDATE_NAME, FORM_DATE_SENT FORM_DATE_SENT, FORM_IN_PROGRESS_DATE FORM_IN_PROGRESS_DATE, FORM_COMPLETION_STATUS FORM_COMPLETION_STATUS, FORM_DATE_SUBMITTED FORM_DATE_SUBMITTED, FORM_PREVIEW_LINK FORM_PREVIEW_LINK, PUBLISHED_DATE PUBLISHED_DATE, PUBLISHED_VERSION PUBLISHED_VERSION, PROFILE_ID PROFILE_ID, MULTIPLE_RECORDS MULTIPLE_RECORDS, PRIMARY_IDENTIFIER PRIMARY_IDENTIFIER, REAPPLY_IN_CAPTURE REAPPLY_IN_CAPTURE, REAPPLY_IN_JOB_SEARCH REAPPLY_IN_JOB_SEARCH, REAPPLY_IN_CAMPAIGN REAPPLY_IN_CAMPAIGN, ONBOARDING_DOCUMENTS_HELP_AT_HOME_EEO_SURVEY ONBOARDING_DOCUMENTS_HELP_AT_HOME_EEO_SURVEY, ONBOARDING_DOCUMENTS_I9 ONBOARDING_DOCUMENTS_I9, ONBOARDING_DOCUMENTS_DIRECT_DEPOSIT ONBOARDING_DOCUMENTS_DIRECT_DEPOSIT, ONBOARDING_DOCUMENTS_PLEASE_READ_BELOW ONBOARDING_DOCUMENTS_PLEASE_READ_BELOW, ONBOARDING_DOCUMENTS_WOTC ONBOARDING_DOCUMENTS_WOTC, ONBOARDING_DOCUMENTS_ORIENTATION_CHECKLIST ONBOARDING_DOCUMENTS_ORIENTATION_CHECKLIST, ONBOARDING_DOCUMENTS_TB_EDUCATION ONBOARDING_DOCUMENTS_TB_EDUCATION, ONBOARDING_DOCUMENTS_ACKNOWLEDGEMENT_OF_INSURANCE_OFFER ONBOARDING_DOCUMENTS_ACKNOWLEDGEMENT_OF_INSURANCE_OFFER, ONBOARDING_DOCUMENTS_HELP_AT_HOME_HANDBOOK ONBOARDING_DOCUMENTS_HELP_AT_HOME_HANDBOOK, ONBOARDING_DOCUMENTS_ACKNOWLEDGEMENT_HANDBOOK_SIGNOFF ONBOARDING_DOCUMENTS_ACKNOWLEDGEMENT_HANDBOOK_SIGNOFF, ONBOARDING_DOCUMENTS_NEPOTISM_ACKNOWLEDGEMENT ONBOARDING_DOCUMENTS_NEPOTISM_ACKNOWLEDGEMENT, ONBOARDING_DOCUMENTS_HEPATITIS_B_ACKNOWLEDGEMENT ONBOARDING_DOCUMENTS_HEPATITIS_B_ACKNOWLEDGEMENT, ONBOARDING_DOCUMENTS_BASIC_TRAINING_AND_NON_TRANSPORT_ACKNOWLEDGEMENT ONBOARDING_DOCUMENTS_BASIC_TRAINING_AND_NON_TRANSPORT_ACKNOWLEDGEMENT, ONBOARDING_DOCUMENTS_I_CONSENT_TO_HELP_AT_HOME_COMMUNICATING_WITH_ME_DURING_MY_EMPLOYMENT_USING_THE_PERSONAL_CONTACT_INFORMATION_I_PROVIDED_THIS_COMMU ONBOARDING_DOCUMENTS_I_CONSENT_TO_HELP_AT_HOME_COMMUNICATING_WITH_ME_DURING_MY_EMPLOYMENT_USING_THE_PERSONAL_CONTACT_INFORMATION_I_PROVIDED_THIS_COMMU, TAX_WITHHOLDING_TAX_WITHHOLDING TAX_WITHHOLDING_TAX_WITHHOLDING, TAX_WITHHOLDING_FEDERAL_TAX_FORMS TAX_WITHHOLDING_FEDERAL_TAX_FORMS, TAX_WITHHOLDING_STATE_TAX_FORMS TAX_WITHHOLDING_STATE_TAX_FORMS, FINAL_SUBMISSION FINAL_SUBMISSION, :TASKKEY AS ETL_TASK_KEY, :TASKKEY AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG  FROM DISC_PROD.PARADOX.HIST_IN_ADAPTIVE_ONBOARDING_DIRECT_CARE WHERE ETL_LAST_UPDATED_DATE = (SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_PROD.PARADOX.HIST_IN_ADAPTIVE_ONBOARDING_DIRECT_CARE); 

    RETURN ''SUCCESS'';
END;

';