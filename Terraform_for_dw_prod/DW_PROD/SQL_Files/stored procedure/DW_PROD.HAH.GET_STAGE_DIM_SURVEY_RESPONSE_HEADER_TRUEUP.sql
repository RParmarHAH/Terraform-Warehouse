CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_DIM_SURVEY_RESPONSE_HEADER_TRUEUP("SURVEY_ID" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    SQL VARCHAR;
BEGIN

DELETE FROM DW_PROD.STAGE.DIM_SURVEY_RESPONSE_HEADER WHERE SURVEY_ID=:SURVEY_ID;

WITH MAPPING_COLUMN AS
(select * 
from DW_PROD.HAH.FACT_SURVEY_COLUMN_MAPPING
pivot(MIN(SOURCE_COLUMN_NAME) for destination_column_name in 
(''SURVEY_ID'', ''RECORD_ID'',''CLIENT_KEY'',''EMPLOYEE_KEY'',''BRANCH_KEY'',''STATUS'',''PROGRESS'',''COMPLETED_FLAG'',''RECORDED_DATE'',''START_DATE'',''END_DATE'',''DURATION_IN_SECONDS'',''LANGUAGE'',''LATITUDE'',''LONGITUDE'',''IP_ADDRESS'',''EXTERNAL_REFERENCE'',''DISTRIBUTION_CHANNEL'',''PARTNER_KEY'',''RESPONSE_ID'',''BATCH_NUMBER''))
as p
WHERE SURVEY_ID=:SURVEY_ID)
SELECT 
''INSERT INTO DW_PROD.STAGE.DIM_SURVEY_RESPONSE_HEADER
WITH BRANCH_DETAIL AS(
SELECT DETAILED_OFFICE_NAME,ORIGINAL_BRANCH_KEY FROM DW_PROD.INTEGRATION.DIM_BRANCH_MERGED
WHERE ORIGINAL_BRANCH_KEY=BRANCH_KEY
AND SOURCE_SYSTEM_ID IN (1,2,3,4,7,8,9,17,16,15,13,14,19)
),WH_EMPLOYEES AS 
(SELECT ROW_NUMBER() OVER (PARTITION BY CAML.GATOR_EMPLOYEE_KEY ORDER BY DEM.EMPLOYEE_LAST_WORKED_DATE DESC) AS RNUM,CAML.* 
FROM APP_DB_PROD.CARE_COORDINATION.CAREGIVER_MATCH_LIST CAML
LEFT JOIN DW_PROD.INTEGRATION.DIM_EMPLOYEE_MERGED DEM ON CAML.DW_EMPLOYEE_KEY = DEM.ORIGINAL_EMPLOYEE_KEY 
AND DEM.ORIGINAL_EMPLOYEE_KEY=DEM.EMPLOYEE_KEY
WHERE CAML.GATOR_EMPLOYEE_KEY<>CAML.DW_EMPLOYEE_KEY)  
,WH_CLIENTS AS 
(SELECT ROW_NUMBER() OVER (PARTITION BY CMD.OLD_KEY ORDER BY DCM.LAST_SERVICE_DATE DESC) AS RNUM,CMD.* 
FROM APP_DB_PROD.CARE_COORDINATION.CLIENT_MATCH_DEDUPE CMD
LEFT JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MERGED DCM ON CMD.CURRENT_KEYS = DCM.ORIGINAL_CLIENT_KEY 
AND DCM.ORIGINAL_CLIENT_KEY=DCM.CLIENT_KEY
WHERE CMD.OLD_KEY<>CMD.CURRENT_KEYS) 
SELECT DISTINCT
MD5(f.SURVEY_ID::STRING||'''' - ''''||f.value:''||"''RESPONSE_ID''"||''::STRING) AS SURVEY_RESPONSE_HEADER_KEY, 
MD5(f.SURVEY_ID::STRING) AS SURVEY_KEY,
f.SURVEY_ID::STRING AS SURVEY_ID,
NVL(f.value:values.''||"''RECORD_ID''"||''::STRING,f.value:''||"''RESPONSE_ID''"||''::STRING) AS RECORD_ID,\\n''
||IFF("''CLIENT_KEY''" IS NOT NULL,''f.value:values.''||"''CLIENT_KEY''"||''::STRING AS CLIENT_KEY,\\n'',''NULL AS CLIENT_KEY,\\n'')
||IFF("''CLIENT_KEY''" IS NOT NULL,''COALESCE(WHC.CURRENT_KEYS,CLIENT_KEY) as WH_CLIENT_KEY,\\n'',''NULL AS WH_CLIENT_KEY,\\n'')
||IFF("''EMPLOYEE_KEY''" IS NOT NULL,''f.value:values.''||"''EMPLOYEE_KEY''"||''::STRING AS SOURCE_EMPLOYEE_KEY,\\n'',''NULL AS SOURCE_EMPLOYEE_KEY,\\n'')
||IFF("''EMPLOYEE_KEY''" IS NOT NULL,''COALESCE(WHE.DW_EMPLOYEE_KEY,EML.MASTER_EMPLOYEE_KEY,SOURCE_EMPLOYEE_KEY),\\n'',''NULL AS WH_EMPLOYEE_KEY,\\n'')
||''COALESCE(''||IFF("''BRANCH_KEY''" IS NOT NULL,''br.ORIGINAL_BRANCH_KEY::STRING,'',''NULL,'')||IFF("''EMPLOYEE_KEY''" IS NOT NULL,''DEM.primary_branch_key,'',''NULL,'')||IFF("''CLIENT_KEY''" IS NOT NULL,''DCM.primary_branch_key'',''NULL'')||'')AS BRANCH_KEY,
''
||IFF("''PARTNER_KEY''" IS NOT NULL,''DP.PARTNER_KEY AS PARTNER_KEY,\\n'',''NULL AS PARTNER_KEY,'')
||IFF("''PARTNER_KEY''" IS NOT NULL,''DPC.PARTNER_CONTRACT_KEY AS PARTNER_CONTRACT_KEY,\\n'',''NULL AS PARTNER_CONTRACT_KEY,'')
||''26 AS SOURCE_SYSTEM_ID,\\n''
||''''''Qualtrics'''' AS SYSTEM_CODE,\\n''
||IFF("''STATUS''" IS NOT NULL,''f.value:values.''||"''STATUS''"||''::STRING AS STATUS,\\n'',''NULL AS STATUS,\\n'')
||IFF("''PROGRESS''" IS NOT NULL,''f.value:values.''||"''PROGRESS''"||''::STRING AS PROGRESS,\\n'',''NULL AS PROGRESS,\\n'')
||IFF("''COMPLETED_FLAG''" IS NOT NULL,''f.value:values.''||"''COMPLETED_FLAG''"||''::INT AS COMPLETED_FLAG,\\n'',''NULL AS COMPLETED_FLAG,\\n'')
||IFF("''RECORDED_DATE''" IS NOT NULL,''f.value:values.''||"''RECORDED_DATE''"||''::TIMESTAMP_NTZ AS RECORDED_DATE,\\n'',''NULL AS RECORDED_DATE,\\n'')
||IFF("''START_DATE''" IS NOT NULL,''f.value:values.''||"''START_DATE''"||''::TIMESTAMP_NTZ AS START_DATE,\\n'',''NULL AS START_DATE,\\n'')
||IFF("''END_DATE''" IS NOT NULL,''f.value:values.''||"''END_DATE''"||''::TIMESTAMP_NTZ AS END_DATE,\\n'',''NULL AS END_DATE,\\n'')
||IFF("''DURATION_IN_SECONDS''" IS NOT NULL,''f.value:values.''||"''DURATION_IN_SECONDS''"||'' AS DURATION_IN_SECONDS,\\n'',''0 AS DURATION_IN_SECONDS,\\n'')
||IFF("''LANGUAGE''" IS NOT NULL,''f.value:values.''||"''LANGUAGE''"||''::STRING AS LANGUAGE,\\n'',''NULL AS LANGUAGE,\\n'')
||IFF("''LATITUDE''" IS NOT NULL,''f.value:values.''||"''LATITUDE''"||''::STRING AS LATITUDE,\\n'',''NULL AS LATITUDE,\\n'')
||IFF("''LONGITUDE''" IS NOT NULL,''f.value:values.''||"''LONGITUDE''"||''::STRING AS LONGITUDE,\\n'',''NULL AS LONGITUDE,\\n'')
||IFF("''IP_ADDRESS''" IS NOT NULL,''f.value:values.''||"''IP_ADDRESS''"||''::STRING AS IP_ADDRESS,\\n'',''NULL AS IP_ADDRESS,\\n'')
||IFF("''EXTERNAL_REFERENCE''" IS NOT NULL,''f.value:values.''||"''EXTERNAL_REFERENCE''"||''::STRING AS EXTERNAL_REFERENCE,\\n'',''NULL AS EXTERNAL_REFERENCE,\\n'')
||IFF("''DISTRIBUTION_CHANNEL''" IS NOT NULL,''f.value:values.''||"''DISTRIBUTION_CHANNEL''"||''::STRING AS DISTRIBUTION_CHANNEL,\\n'',''NULL AS DISTRIBUTION_CHANNEL,\\n'')
||IFF("''BATCH_NUMBER''" IS NOT NULL,''f.value:values."''||"''BATCH_NUMBER''"||''"::STRING AS BATCH_NUMBER,\\n'',''NULL AS BATCH_NUMBER,\\n'')
||''-1 AS STR_ETL_TASK_KEY,\\n''
||''-1 AS ETL_INSERTED_TASK_KEY,\\n''
||''CURRENT_TIMESTAMP ::TIMESTAMP_NTZ(9) AS ETL_INSERTED_DATE,\\n''
||''CURRENT_USER() AS ETL_INSERTED_BY,\\n''
||''CURRENT_TIMESTAMP ::TIMESTAMP_NTZ(9) AS ETL_LAST_UPDATED_DATE,\\n''
||''CURRENT_USER() AS ETL_LAST_UPDATED_BY,\\n''
||''FALSE AS ETL_DELETED_FLAG\\n''
||''FROM (SELECT * FROM DISC_PROD.QUALTRICS_SURVEYS.QUALTRICS_SURVEY_RESPONSE_TRUEUP, table(flatten(SURVEY_JSON))) f\\n''
||''JOIN DW_PROD.HAH.DIM_SURVEY DS ON f.SURVEY_ID=DS.SURVEY_ID\\n''
||IFF("''PARTNER_KEY''" IS NOT NULL,''LEFT JOIN DW_PROD.HAH.DIM_PARTNER DP ON f.value:values.''||"''PARTNER_KEY''"||''::STRING = DP.PARTNER_CODE AND SOURCE_SYSTEM_ID = 0\\n'','''')
||IFF("''PARTNER_KEY''" IS NOT NULL,''LEFT JOIN DW_PROD.HAH.DIM_PARTNER_CONTRACT DPC ON f.value:values.''||"''PARTNER_KEY''"||''::STRING = DPC.CONTRACT_CODE
 AND DPC.SOURCE_SYSTEM_ID = 29\\n'','''')
||IFF("''BRANCH_KEY''" IS NOT NULL,''LEFT JOIN BRANCH_DETAIL br ON f.value:values."''||"''BRANCH_KEY''"||''"::STRING = br.DETAILED_OFFICE_NAME\\n'','''')
||IFF("''CLIENT_KEY''" IS NOT NULL,''LEFT JOIN WH_CLIENTS WHC ON f.value:values."''||"''CLIENT_KEY''"||''"::STRING = WHC.OLD_KEY AND WHC.RNUM=1\\n'','''')
||IFF("''EMPLOYEE_KEY''" IS NOT NULL,''LEFT JOIN WH_EMPLOYEES WHE ON f.value:values."''||"''EMPLOYEE_KEY''"||''"::STRING = WHE.GATOR_EMPLOYEE_KEY AND WHE.RNUM=1\\n'','''')
||IFF("''EMPLOYEE_KEY''" IS NOT NULL,''LEFT JOIN DW_PROD.INTEGRATION.DIM_EMPLOYEE_MERGED DEM ON f.value:values."''||"''EMPLOYEE_KEY''"||''"::STRING = DEM.ORIGINAL_EMPLOYEE_KEY\\n'','''')
||IFF("''EMPLOYEE_KEY''" IS NOT NULL,''LEFT JOIN DISC_DEDUPE_PROD.PUBLIC.VW_EMPLOYEE_MATCH_LIST EML ON coalesce(WHE.DW_EMPLOYEE_KEY,f.value:values."''||"''EMPLOYEE_KEY''"||''"::STRING) = EML.EMPLOYEE_KEY 
'','''')	
||IFF("''CLIENT_KEY''" IS NOT NULL,''LEFT JOIN DW_PROD.INTEGRATION.DIM_CLIENT_MERGED DCM ON f.value:values."''||"''CLIENT_KEY''"||''"::STRING = DCM.ORIGINAL_CLIENT_KEY\\n'','''') 
||''WHERE f.SURVEY_ID=''''''||:SURVEY_ID||''''''  AND f.key = ''''result''''\\n''
||IFF("''CLIENT_KEY''" IS NOT NULL,''AND f.value:values.''||"''CLIENT_KEY''"||''::STRING IS NOT NULL;'','''')
INTO :SQL
FROM MAPPING_COLUMN;

execute immediate SQL;
return ''Succeeded.'';

END;
';