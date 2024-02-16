CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_QUALTRICS_FACT_DISTRIBUTION("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS 'BEGIN

INSERT OVERWRITE INTO DW_PROD.STAGE.QUALTRICS_FACT_DISTRIBUTION

WITH WH_EMPLOYEES AS 
(SELECT ROW_NUMBER() OVER (PARTITION BY CAMD.OLD_KEY ORDER BY DEM.EMPLOYEE_LAST_WORKED_DATE DESC) AS RNUM,CAMD.* 
FROM APP_DB_PROD.CARE_COORDINATION.CAREGIVER_MATCH_DEDUPE CAMD
LEFT JOIN DW_PROD.INTEGRATION.DIM_EMPLOYEE_MERGED DEM ON CAMD.CURRENT_KEYS = DEM.ORIGINAL_EMPLOYEE_KEY 
AND DEM.ORIGINAL_EMPLOYEE_KEY = DEM.EMPLOYEE_KEY
WHERE CAMD.OLD_KEY<>CAMD.CURRENT_KEYS)

,WH_CLIENTS AS 
(SELECT ROW_NUMBER() OVER (PARTITION BY CMD.OLD_KEY ORDER BY DCM.LAST_SERVICE_DATE DESC) AS RNUM,CMD.* 
FROM APP_DB_PROD.CARE_COORDINATION.CLIENT_MATCH_DEDUPE CMD
LEFT JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MERGED DCM ON CMD.CURRENT_KEYS = DCM.ORIGINAL_CLIENT_KEY 
AND DCM.ORIGINAL_CLIENT_KEY=DCM.CLIENT_KEY
WHERE CMD.OLD_KEY<>CMD.CURRENT_KEYS)

SELECT DISTINCT
MD5(DISTRIBUTION_ID||SURVEYLINK) AS QUALTRICS_FACT_DISTRIBUTION_KEY,
MD5(''QUALTRICS''||DISTRIBUTION_ID) AS QUALTRICS_DIM_DISTRIBUTION_KEY,
RIGHT(EXTREF, 32) AS EMPLOYEE_KEY,
coalesce(WHE.current_keys,EMPLOYEE_KEY) as WH_EMPLOYEE_KEY,
LEFT(EXTREF, 32) AS CLIENT_KEY,
coalesce(WHC.current_keys,CLIENT_KEY) as WH_CLIENT_KEY,
STATUS, --SessionExpired,Success,SurveyStarted,SoftBounce,SurveyFinished,Failure,SurveyPartiallyFinished,Pending,Blocked
SURVEYLINK AS SURVEY_LINK,
--CONTACT_FREQUENCY_RULE_ID,
MD5(SURVEY_ID||'' - ''||RESPONSE_ID) AS SURVEY_RESPONSE_HEADER_KEY, 
RESPONSE_ID AS RECORD_ID,
RESPONSE_COMPLETED_AT::TIMESTAMP_NTZ AS RESPONSE_COMPLETED_AT,
SENT_AT::TIMESTAMP_NTZ AS SENT_AT,
OPENED_AT::TIMESTAMP_NTZ AS OPENED_AT,
RESPONSE_STARTED_AT::TIMESTAMP_NTZ AS RESPONSE_STARTED_AT,
--SURVEY_SESSION_ID,
DSS.SOURCE_SYSTEM_ID as SOURCE_SYSTEM_ID,
''QUALTRICS'' as SOURCE_SYSTEM_CODE,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ as ETL_INSERTED_DATE,
CURRENT_USER as ETL_INSERTED_BY,
CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ as ETL_UPDATED_DATE,
CURRENT_USER as ETL_LAST_UPDATED_BY,
0 as ETL_DELETED_FLAG,
0 as ETL_INFERRED_MEMBER_FLAG
FROM DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_DISTRIBUTION_HISTORY H
LEFT JOIN DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_DIRECTORY_CONTACTS C ON C.CONTACTID = H.CONTACT_ID
LEFT JOIN DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_DISTRIBUTION_LIST L ON L.ID = H.DISTRIBUTION_ID
LEFT JOIN WH_EMPLOYEES WHE on RIGHT(EXTREF, 32) = WHE.OLD_KEY AND WHE.RNUM=1 
LEFT JOIN WH_CLIENTS WHC on LEFT(EXTREF, 32) = WHC.OLD_KEY AND WHC.RNUM=1
JOIN DW_PROD.HAH.DIM_SOURCE_SYSTEM DSS
  ON DSS.system_code = ''Qualtrics'';

RETURN(''SUCCESS'');

END';