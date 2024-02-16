CREATE OR REPLACE PROCEDURE DISC_PROD.PARADOX.GET_OPEN_JOBS("TASKKEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
--*****************************************************************************************************************************
-- NAME:  GET_OPEN_JOBS 
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
    COPY INTO DISC_PROD.PARADOX.HIST_OPEN_JOBS FROM (SELECT DISTINCT A.$1 REQ_ID, A.$2 STORE_, A.$3 ORGANIZATIONAL_ALIGNMENT, A.$4 STATE, A.$5 CITY, A.$6 JOB_POSTING_DATE, A.$7 JOB_CLOSING_DATE, A.$8 JOB_CREATED_DATE, A.$9 JOB_TITLE, A.$10 JOB_FAMILY, A.$11 JOB_CODE, A.$12 JOB_OWNER, A.$13 JOB_OWNER_ID, A.$14 REQ_AGE, A.$15 REQ_AGE_GROUP, A.$16 CANDIDATES_APPLIED, A.$17 CANDIDATES_PASSED_SCREENING, A.$18 CANDIDATES_FULL_APPLICATION_COMPLETE, A.$19 INTERVIEWS_SENT, A.$20 SCHEDULING_REQUESTS_ACCEPTED, A.$21 CANDIDATES_INTERVIEW_SCHEDULED, A.$22 INTERVIEWS_RESCHEDULED, A.$23 INTERVIEWS_CANCELED, A.$24 OFFER_EXTENDED, A.$25 CANDIDATES_OFFER_ACCEPTED, A.$26 JOB_POSTING_LINK, A.$27 JOB_TITLE_CODE, A.$28 TOTAL_CANDIDATES_ADDED_MANUALLY, A.$29 CANDIDATE_JOURNEY, A.$30 FORMS_USED, A.$31 JOB_STATUS, A.$32 LOCATION_NAME, A.$33 EXTERNAL_JOB_REFERENCE_NUMBER, A.$34 DEFAULT_INTERVIEW_ATTENDEES, A.$35 ARCHIVED, A.$36 JOB_LOCATION_NAME, A.$37 AREA__LEVEL_1, A.$38 AREA__LEVEL_2, A.$39 AREA__LEVEL_3, A.$40 LOCATION_ATTR__ADDRESS, A.$41 LOCATION_ATTR__ADDRESS_2, A.$42 LOCATION_ATTR__CITY, A.$43 LOCATION_ATTR__COUNTRY, A.$44 LOCATION_ATTR__LOCATION_ID, A.$45 LOCATION_ATTR__LOCATION_EMAIL, A.$46 LOCATION_ATTR__LOCATION_NAME, A.$47 LOCATION_ATTR__LOCATION_PHONE, A.$48 LOCATION_ATTR__PROVINCE, A.$49 LOCATION_ATTR__STATE, A.$50 LOCATION_ATTR__ZIP_CODE, A.$51 HIRING_TEAM__RECRUITER, A.$52 HIRING_TEAM__HIRING_MANAGER, :TASKKEY AS ETL_TASK_KEY, :TASKKEY AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM @DISC_PROD.STAGE.AWSAZSTAGEPROD/PARADOX/Upload_file/HireOpen(FILE_FORMAT => DISC_PROD.STAGE.CSV_FORMAT) A);

    --VIEWSQL
    CREATE OR REPLACE TABLE DISC_PROD.PARADOX.OPEN_JOBS AS  SELECT  REQ_ID REQ_ID, STORE_ STORE_, ORGANIZATIONAL_ALIGNMENT ORGANIZATIONAL_ALIGNMENT, STATE STATE, CITY CITY, JOB_POSTING_DATE JOB_POSTING_DATE, JOB_CLOSING_DATE JOB_CLOSING_DATE, JOB_CREATED_DATE JOB_CREATED_DATE, JOB_TITLE JOB_TITLE, JOB_FAMILY JOB_FAMILY, JOB_CODE JOB_CODE, JOB_OWNER JOB_OWNER, JOB_OWNER_ID JOB_OWNER_ID, REQ_AGE REQ_AGE, REQ_AGE_GROUP REQ_AGE_GROUP, CANDIDATES_APPLIED CANDIDATES_APPLIED, CANDIDATES_PASSED_SCREENING CANDIDATES_PASSED_SCREENING, CANDIDATES_FULL_APPLICATION_COMPLETE CANDIDATES_FULL_APPLICATION_COMPLETE, INTERVIEWS_SENT INTERVIEWS_SENT, SCHEDULING_REQUESTS_ACCEPTED SCHEDULING_REQUESTS_ACCEPTED, CANDIDATES_INTERVIEW_SCHEDULED CANDIDATES_INTERVIEW_SCHEDULED, INTERVIEWS_RESCHEDULED INTERVIEWS_RESCHEDULED, INTERVIEWS_CANCELED INTERVIEWS_CANCELED, OFFER_EXTENDED OFFER_EXTENDED, CANDIDATES_OFFER_ACCEPTED CANDIDATES_OFFER_ACCEPTED, JOB_POSTING_LINK JOB_POSTING_LINK, JOB_TITLE_CODE JOB_TITLE_CODE, TOTAL_CANDIDATES_ADDED_MANUALLY TOTAL_CANDIDATES_ADDED_MANUALLY, CANDIDATE_JOURNEY CANDIDATE_JOURNEY, FORMS_USED FORMS_USED, JOB_STATUS JOB_STATUS, LOCATION_NAME LOCATION_NAME, EXTERNAL_JOB_REFERENCE_NUMBER EXTERNAL_JOB_REFERENCE_NUMBER, DEFAULT_INTERVIEW_ATTENDEES DEFAULT_INTERVIEW_ATTENDEES, ARCHIVED ARCHIVED, JOB_LOCATION_NAME JOB_LOCATION_NAME, AREA__LEVEL_1 AREA__LEVEL_1, AREA__LEVEL_2 AREA__LEVEL_2, AREA__LEVEL_3 AREA__LEVEL_3, LOCATION_ATTR__ADDRESS LOCATION_ATTR__ADDRESS, LOCATION_ATTR__ADDRESS_2 LOCATION_ATTR__ADDRESS_2, LOCATION_ATTR__CITY LOCATION_ATTR__CITY, LOCATION_ATTR__COUNTRY LOCATION_ATTR__COUNTRY, LOCATION_ATTR__LOCATION_ID LOCATION_ATTR__LOCATION_ID, LOCATION_ATTR__LOCATION_EMAIL LOCATION_ATTR__LOCATION_EMAIL, LOCATION_ATTR__LOCATION_NAME LOCATION_ATTR__LOCATION_NAME, LOCATION_ATTR__LOCATION_PHONE LOCATION_ATTR__LOCATION_PHONE, LOCATION_ATTR__PROVINCE LOCATION_ATTR__PROVINCE, LOCATION_ATTR__STATE LOCATION_ATTR__STATE, LOCATION_ATTR__ZIP_CODE LOCATION_ATTR__ZIP_CODE, HIRING_TEAM__RECRUITER HIRING_TEAM__RECRUITER, HIRING_TEAM__HIRING_MANAGER HIRING_TEAM__HIRING_MANAGER, :TASKKEY AS ETL_TASK_KEY, :TASKKEY AS ETL_INSERTED_TASK_KEY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE, CURRENT_USER() AS ETL_INSERTED_BY, CURRENT_TIMESTAMP::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE, CURRENT_USER() AS ETL_LAST_UPDATED_BY, 0 AS ETL_DELETED_FLAG FROM DISC_PROD.PARADOX.HIST_OPEN_JOBS WHERE ETL_LAST_UPDATED_DATE = (SELECT MAX(ETL_LAST_UPDATED_DATE) FROM DISC_PROD.PARADOX.HIST_OPEN_JOBS);

    RETURN ''SUCCESS'';
END;

';