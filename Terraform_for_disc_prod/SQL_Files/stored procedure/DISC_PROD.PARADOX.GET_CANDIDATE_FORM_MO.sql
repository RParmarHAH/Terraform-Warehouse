CREATE OR REPLACE PROCEDURE DISC_PROD.PARADOX.GET_CANDIDATE_FORM_MO("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
--*****************************************************************************************************************************
-- NAME:  GET_CANDIDATE_FORM_MO 
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
    INSERT INTO DISC_PROD.PARADOX.HIST_CANDIDATE_FORM_MO (SELECT A.$1 FORM_NAME, A.$2 LOCATION_CODE, A.$3 LOCATION_NAME, A.$4 JOB_APPLIED_TO, A.$5 JOB_REQ_ID, A.$6 JOB_TITLE, A.$7 CURRENT_CANDIDATE_JOURNEY_STATUS, A.$8 CANDIDATE_ID, A.$9 CANDIDATE_NAME, A.$10 FORM_DATE_SENT, A.$11 FORM_IN_PROGRESS_DATE, A.$12 FORM_COMPLETION_STATUS, A.$13 FORM_DATE_SUBMITTED, A.$14 FORM_PREVIEW_LINK, A.$15 PUBLISHED_DATE, A.$16 PUBLISHED_VERSION, A.$17 PROFILE_ID, A.$18 MULTIPLE_RECORDS, A.$19 PRIMARY_IDENTIFIER, A.$20 REAPPLY_IN_CAPTURE, A.$21 REAPPLY_IN_JOB_SEARCH, A.$22 REAPPLY_IN_CAMPAIGN, A.$23 PERSONAL_INFORMATION_YOUR_FULL_NAME, A.$24 PERSONAL_INFORMATION_PHONE_NUMBER, A.$25 PERSONAL_INFORMATION_EMAIL_ADDRESS, TRIM(PARSE_JSON( A.$26):"ADDRESS",''"'') AS PERSONAL_INFORMATION_STREET_ADDRESS_LINE_1, TRIM(PARSE_JSON( A.$26):"ADDRESS_2",''"'') AS PERSONAL_INFORMATION_STREET_ADDRESS_LINE_2, TRIM(PARSE_JSON( A.$26):"CITY",''"'') AS PERSONAL_INFORMATION_CITY, TRIM(PARSE_JSON( A.$26):"STATE",''"'') AS PERSONAL_INFORMATION_STATE, TRIM(PARSE_JSON( A.$26):"ZIP_CODE",''"'') AS PERSONAL_INFORMATION_ZIP_CODE, NULL PERSONAL_INFORMATION_EMERGENCY_CONTACT_NAME, NULL PERSONAL_INFORMATION_EMERGENCY_CONTACT_PHONE_NUMBER, NULL PERSONAL_INFORMATION_EMERGENCY_CONTACT_ALTERNATE_PHONE_NUMBER, NULL PERSONAL_INFORMATION_RELATION_TO_CAREGIVER, A.$27 PERSONAL_INFORMATION_HOW_DID_YOU_HEAR_ABOUT_THIS_JOB, A.$28 PERSONAL_INFORMATION_IF_OTHER_WHERE, A.$29 PERSONAL_INFORMATION_DO_YOU_HAVE_A_RELATIVE_THAT_WORKS_FOR_HELP_AT_HOME_IF_SO_WHAT_IS_THEIR_NAME, A.$30 PERSONAL_INFORMATION_AVAILABLE_DAYS, A.$31 PERSONAL_INFORMATION_HAVE_YOU_PREVIOUSLY_WORKED_FOR_HELP_AT_HOME, A.$32 PERSONAL_INFORMATION_DO_YOU_HAVE_THE_LEGAL_RIGHT_TO_WORK_IN_THE_US_WITHOUT_SPONSORSHIPS, A.$33 EDUCATION_HISTORY_DO_YOU_HAVE_A_HIGH_SCHOOL_DIPLOMA_OR_GED, A.$34 EDUCATION_HISTORY_IF_YES_WHAT_IS_THE_NAME_OF_THE_SCHOOL, A.$35 EMPLOYMENT_HISTORY_1__EMPLOYMENT_HISTORY_PLEASE_PROVIDE_MINIMUM_2_YEARS, A.$36 EMPLOYMENT_HISTORY_2__EMPLOYMENT_HISTORY_PLEASE_PROVIDE_MINIMUM_2_YEARS, A.$37 EMPLOYMENT_HISTORY_3__EMPLOYMENT_HISTORY_PLEASE_PROVIDE_MINIMUM_2_YEARS, A.$38 EMPLOYMENT_HISTORY_1__EMPLOYER_CITY, A.$39 EMPLOYMENT_HISTORY_2__EMPLOYER_CITY, A.$40 EMPLOYMENT_HISTORY_3__EMPLOYER_CITY, A.$41 EMPLOYMENT_HISTORY_1__EMPLOYER_STATE, A.$42 EMPLOYMENT_HISTORY_2__EMPLOYER_STATE, A.$43 EMPLOYMENT_HISTORY_3__EMPLOYER_STATE, A.$44 EMPLOYMENT_HISTORY_1__EMPLOYER_PHONE_NUMBER, A.$45 EMPLOYMENT_HISTORY_2__EMPLOYER_PHONE_NUMBER, A.$46 EMPLOYMENT_HISTORY_3__EMPLOYER_PHONE_NUMBER, A.$47 EMPLOYMENT_HISTORY_1__SUPERVISOR_NAME, A.$48 EMPLOYMENT_HISTORY_2__SUPERVISOR_NAME, A.$49 EMPLOYMENT_HISTORY_3__SUPERVISOR_NAME, A.$50 EMPLOYMENT_HISTORY_1__POSITION, A.$51 EMPLOYMENT_HISTORY_2__POSITION, A.$52 EMPLOYMENT_HISTORY_3__POSITION, A.$53 EMPLOYMENT_HISTORY_1__DATE_STARTED, A.$54 EMPLOYMENT_HISTORY_2__DATE_STARTED, A.$55 EMPLOYMENT_HISTORY_3__DATE_STARTED, A.$56 EMPLOYMENT_HISTORY_1__DATE_ENDED, A.$57 EMPLOYMENT_HISTORY_2__DATE_ENDED, A.$58 EMPLOYMENT_HISTORY_3__DATE_ENDED, A.$59 EMPLOYMENT_HISTORY_1__REASON_FOR_LEAVING, A.$60 EMPLOYMENT_HISTORY_2__REASON_FOR_LEAVING, A.$61 EMPLOYMENT_HISTORY_3__REASON_FOR_LEAVING, A.$62 REFERENCES_NAME_OF_REFERENCE_1, A.$63 REFERENCES_PHONE_NUMBER_1, A.$64 REFERENCES_RELATIONSHIP_1, A.$65 REFERENCES_NAME_OF_REFERENCE_2, A.$66 REFERENCES_REFERENCE_2_PHONE_NUMBER, A.$67 REFERENCES_REFERENCE_2_RELATIONSHIP, A.$68 EQUAL_EMPLOYMENT_OPPORTUNITY_EEO_VOLUNTARY_SELFIDENTIFICATION, A.$69 EQUAL_EMPLOYMENT_OPPORTUNITY_EQUAL_EMPLOYMENT_OPPORTUNITY, A.$70 EQUAL_EMPLOYMENT_OPPORTUNITY_WHAT_IS_YOUR_PREFERRED_LANGUAGE_FOR_COMMUNICATION, A.$71 PROOF_OF_RESIDENCY_PASSPORT_BIRTH_CERTIFICATE_OR_SOCIAL_SECURITY_CARD, A.$72 PROOF_OF_RESIDENCY_STATE_ISSUED_ID_OR_DRIVERS_LICENSE_FRONT, A.$73 PROOF_OF_RESIDENCY_STATE_ISSUED_ID_OR_DRIVERS_LICENSE_BACK, A.$74 PROOF_OF_RESIDENCY_PLEASE_SELECT, A.$75 PROOF_OF_RESIDENCY_HAVE_YOU_BEEN_A_RESIDENT_OF_MISSOURI_FOR_5_CONSECUTIVE_YEARS, A.$76 ONBOARDINGBACKGROUND_CHECK_REQUIREMENTS_BACKGROUND_CONSENT, A.$77 ATTESTATION_PLEASE_READ_AND_SIGN_THIS_FORM_IN_THE_SPACE_PROVIDED_BELOW, A.$78 ATTESTATION_PLEASE_CONFIRM_YOU_HAVE_REVIEWED_THE_STATEMENT_ABOVE_AND_AGREE_TO_THE_TERMS, A.$79 FINAL_SUBMISSION, :TASKKEY AS ETL_TASK_KEY, :TASKKEY AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG  FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/PARADOX/Upload_file/FormsCandidate.Forms.Detail.Report.Wide.Format.Mo.Application (FILE_FORMAT => DISC_PROD.STAGE.CSV_FORMAT) A);

    --VIEWSQL
    CREATE OR REPLACE TABLE DISC_PROD.PARADOX.CANDIDATE_FORM_MO AS SELECT FORM_NAME, LOCATION_CODE, LOCATION_NAME, JOB_APPLIED_TO, JOB_REQ_ID, JOB_TITLE, CURRENT_CANDIDATE_JOURNEY_STATUS, CANDIDATE_ID, CANDIDATE_NAME, FORM_DATE_SENT, FORM_IN_PROGRESS_DATE, FORM_COMPLETION_STATUS, FORM_DATE_SUBMITTED, FORM_PREVIEW_LINK, PUBLISHED_DATE, PUBLISHED_VERSION, PROFILE_ID, MULTIPLE_RECORDS, PRIMARY_IDENTIFIER, REAPPLY_IN_CAPTURE, REAPPLY_IN_JOB_SEARCH, REAPPLY_IN_CAMPAIGN, PERSONAL_INFORMATION_YOUR_FULL_NAME, PERSONAL_INFORMATION_PHONE_NUMBER, PERSONAL_INFORMATION_EMAIL_ADDRESS, PERSONAL_INFORMATION_STREET_ADDRESS_LINE_1, PERSONAL_INFORMATION_STREET_ADDRESS_LINE_2, PERSONAL_INFORMATION_CITY, PERSONAL_INFORMATION_STATE, PERSONAL_INFORMATION_ZIP_CODE, PERSONAL_INFORMATION_EMERGENCY_CONTACT_NAME, PERSONAL_INFORMATION_EMERGENCY_CONTACT_PHONE_NUMBER, PERSONAL_INFORMATION_EMERGENCY_CONTACT_ALTERNATE_PHONE_NUMBER, PERSONAL_INFORMATION_RELATION_TO_CAREGIVER, PERSONAL_INFORMATION_HOW_DID_YOU_HEAR_ABOUT_THIS_JOB, PERSONAL_INFORMATION_IF_OTHER_WHERE, PERSONAL_INFORMATION_DO_YOU_HAVE_A_RELATIVE_THAT_WORKS_FOR_HELP_AT_HOME_IF_SO_WHAT_IS_THEIR_NAME, PERSONAL_INFORMATION_AVAILABLE_DAYS, PERSONAL_INFORMATION_HAVE_YOU_PREVIOUSLY_WORKED_FOR_HELP_AT_HOME, PERSONAL_INFORMATION_DO_YOU_HAVE_THE_LEGAL_RIGHT_TO_WORK_IN_THE_US_WITHOUT_SPONSORSHIPS, EDUCATION_HISTORY_DO_YOU_HAVE_A_HIGH_SCHOOL_DIPLOMA_OR_GED, EDUCATION_HISTORY_IF_YES_WHAT_IS_THE_NAME_OF_THE_SCHOOL, EMPLOYMENT_HISTORY_1__EMPLOYMENT_HISTORY_PLEASE_PROVIDE_MINIMUM_2_YEARS, EMPLOYMENT_HISTORY_2__EMPLOYMENT_HISTORY_PLEASE_PROVIDE_MINIMUM_2_YEARS, EMPLOYMENT_HISTORY_3__EMPLOYMENT_HISTORY_PLEASE_PROVIDE_MINIMUM_2_YEARS, EMPLOYMENT_HISTORY_1__EMPLOYER_CITY, EMPLOYMENT_HISTORY_2__EMPLOYER_CITY, EMPLOYMENT_HISTORY_3__EMPLOYER_CITY, EMPLOYMENT_HISTORY_1__EMPLOYER_STATE, EMPLOYMENT_HISTORY_2__EMPLOYER_STATE, EMPLOYMENT_HISTORY_3__EMPLOYER_STATE, EMPLOYMENT_HISTORY_1__EMPLOYER_PHONE_NUMBER, EMPLOYMENT_HISTORY_2__EMPLOYER_PHONE_NUMBER, EMPLOYMENT_HISTORY_3__EMPLOYER_PHONE_NUMBER, EMPLOYMENT_HISTORY_1__SUPERVISOR_NAME, EMPLOYMENT_HISTORY_2__SUPERVISOR_NAME, EMPLOYMENT_HISTORY_3__SUPERVISOR_NAME, EMPLOYMENT_HISTORY_1__POSITION, EMPLOYMENT_HISTORY_2__POSITION, EMPLOYMENT_HISTORY_3__POSITION, EMPLOYMENT_HISTORY_1__DATE_STARTED, EMPLOYMENT_HISTORY_2__DATE_STARTED, EMPLOYMENT_HISTORY_3__DATE_STARTED, EMPLOYMENT_HISTORY_1__DATE_ENDED, EMPLOYMENT_HISTORY_2__DATE_ENDED, EMPLOYMENT_HISTORY_3__DATE_ENDED, EMPLOYMENT_HISTORY_1__REASON_FOR_LEAVING, EMPLOYMENT_HISTORY_2__REASON_FOR_LEAVING, EMPLOYMENT_HISTORY_3__REASON_FOR_LEAVING, REFERENCES_NAME_OF_REFERENCE_1, REFERENCES_PHONE_NUMBER_1, REFERENCES_RELATIONSHIP_1, REFERENCES_NAME_OF_REFERENCE_2, REFERENCES_REFERENCE_2_PHONE_NUMBER, REFERENCES_REFERENCE_2_RELATIONSHIP, EQUAL_EMPLOYMENT_OPPORTUNITY_EEO_VOLUNTARY_SELFIDENTIFICATION, EQUAL_EMPLOYMENT_OPPORTUNITY_EQUAL_EMPLOYMENT_OPPORTUNITY, EQUAL_EMPLOYMENT_OPPORTUNITY_WHAT_IS_YOUR_PREFERRED_LANGUAGE_FOR_COMMUNICATION, PROOF_OF_RESIDENCY_PASSPORT_BIRTH_CERTIFICATE_OR_SOCIAL_SECURITY_CARD, PROOF_OF_RESIDENCY_STATE_ISSUED_ID_OR_DRIVERS_LICENSE_FRONT, PROOF_OF_RESIDENCY_STATE_ISSUED_ID_OR_DRIVERS_LICENSE_BACK, PROOF_OF_RESIDENCY_PLEASE_SELECT, PROOF_OF_RESIDENCY_HAVE_YOU_BEEN_A_RESIDENT_OF_MISSOURI_FOR_5_CONSECUTIVE_YEARS, ONBOARDINGBACKGROUND_CHECK_REQUIREMENTS_BACKGROUND_CONSENT, ATTESTATION_PLEASE_READ_AND_SIGN_THIS_FORM_IN_THE_SPACE_PROVIDED_BELOW, ATTESTATION_PLEASE_CONFIRM_YOU_HAVE_REVIEWED_THE_STATEMENT_ABOVE_AND_AGREE_TO_THE_TERMS, FINAL_SUBMISSION, ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG FROM DISC_PROD.PARADOX.HIST_CANDIDATE_FORM_MO WHERE ETL_LAST_UPDATED_DATE = (SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_PROD.PARADOX.HIST_CANDIDATE_FORM_MO);  

    RETURN ''SUCCESS'';
END;

';