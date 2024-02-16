CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_DATAFLEXSYNCDATA_ORPHAN_BRANCH("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
--*****************************************************************************************************************************
-- NAME:  DATAFLEXSYNCDATA_ORPHAN_BRANCH
--
-- PURPOSE: 
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 12/05/2023	TRUSHALI RAMOLIYA			Initial Development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_PROD.STAGE.DATAFLEXSYNCDATA_ORPHAN_BRANCH

--There is null values for column - OFFICENO in DISC_PROD.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS  for respective column-  DBNAME in DISC_PROD.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS.

SELECT DISTINCT 
md5(f.DBNAME || ''-'' || COALESCE(ts.OffceNo, -1) || ''-'' ||  ''DATAFLEXSYNCDATA'') AS BRANCH_KEY,
COALESCE(b.OfficeName, ''UNKNOWN'') AS BRANCH_NAME ,
f.DBNAME AS SYSTEM_CODE,
3 AS SOURCE_SYSTEM_ID,
''AMS'' AS SOURCE_SYSTEM_TYPE,
IFF(ts.OffceNo = 0, ''00'', ts.OffceNo::NUMBER) AS OFFICE_NUMBER,
IFF(ts.OffceNo = 0, ''00'', ts.OffceNo::NUMBER) AS OFFICE_CODE,
COALESCE(b.OfficeName, ''UNKNOWN'') AS OFFICE_NAME,
COALESCE(b.OfficeName, ''UNKNOWN'') AS OFFICE_NAME_ALT,
NULL AS DEPARTMENT_NAME,
NULL AS BRANCH_SERVICE_LINE,
FALSE AS PARENT_FLAG,
md5(f.DBNAME || ''-'' || COALESCE(ts.OffceNo, -1) || ''-'' ||  ''DATAFLEXSYNCDATA'') AS PARENT_BRANCH_KEY,
IFF(ts.OffceNo = 0, ''00'', ts.OffceNo::NUMBER) AS PARENT_OFFICE_NUMBER,
IFF(ts.OffceNo = 0, ''00'', ts.OffceNo::NUMBER) AS PARENT_OFFICE_CODE,
f.DBNAME || ''-'' || COALESCE(b.OfficeName, ''UNKNOWN'') || ''-'' ||  '' ('' || IFF(ts.OffceNo = 0, ''00'', ts.OffceNo::STRING) || '')''  AS PARENT_BRANCH_NAME,
NULL AS OFFICE_ADDRESS1,
NULL AS OFFICE_ADDRESS2,
NULL AS OFFICE_CITY,
f.DBNAME AS OFFICE_STATE_CODE,
NULL AS OFFICE_ZIP,
NULL AS OFFICE_PHONE,
NULL AS OFFICE_TOLL_FREE_PHONE,
NULL AS OFFICE_FAX,
f.DBNAME || ''-'' || COALESCE(b.OfficeName, ''UNKNOWN'') || ''-'' ||  '' ('' || IFF(ts.OffceNo = 0, ''00'', ts.OffceNo::STRING) || '')''  AS DETAILED_OFFICE_NAME,
-1 AS REGION_NUMBER,
NULL AS REGION_NAME,
NULL AS REGION_MANAGER,
NULL AS REGION_MANAGER_EMPLOYEE_KEY,
NULL AS SUBREGION_NAME,
NULL AS PRIMARY_BRANCH_MANAGER_NAME,
NULL AS PRIMARY_BRANCH_EMAIL,
NULL AS PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY,
NULL AS SECONDARY_BRANCH_MANAGER_NAME,
NULL AS SECONDARY_BRANCH_EMAIL,
NULL AS SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY,
NULL AS RISKCONNECT_NODE_KEY,
NULL AS RISKCONNECT_NAME,
NULL AS HR_OFFICE_NUMBER,
NULL AS HR_OFFICE_NAME,
FALSE AS ACTIVE_FLAG,
TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
CURRENT_USER AS ETL_INSERTED_BY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
CURRENT_USER AS ETL_LAST_UPDATED_BY,
FALSE AS ETL_DELETED_FLAG,
FALSE AS ETL_INFERRED_MEMBER_FLAG 
FROM DISC_PROD.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS TS1 
RIGHT JOIN DISC_PROD.DATAFLEXSYNCDATA.ALL_TIMESHEETSHOURS f
	ON f.DbName = ts1.DbName 
	AND f.ReferenceNo = ts1.ReferenceNo 
	AND f.WeekendDate = ts1.WeekendDate 				--  To avoid getting 1 - many join between TSH and Mapping table DFI
LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS TS 															-- This join will only be used to get fields, the previous TS1 join''s purpose is to just act as mapping between TABLES, using same TS table for both causes issues 
	ON TS.DBNAME = F.DBNAME AND TS.REFERENCENO = F.REFERENCENO AND F.WEEKENDDATE = TS.WEEKENDDATE
LEFT JOIN DISC_PROD.DataFlexSyncData.DfOffices b 
	ON ts.OFFCENO = b.OfficeNumber 
	AND ts.DBNAME = b.DBNAME
WHERE  f.DBNAME || ''-'' || COALESCE(ts.OffceNo, -1) NOT IN (SELECT DISTINCT OFFICES.DBNAME || ''-'' || OFFICES.OFFICENUMBER FROM DISC_PROD.DATAFLEXSYNCDATA.DFOFFICES offices)
UNION 
--NO RESPECTIVE VALUE FOR COLUMN  - INTID(NULL) FOR TABLE DISC_PROD.PUBLIC.VW_DATAFLEX_SANDATA_PENDING_VISITS
SELECT 
md5( ''IL'' || ''-'' || ''-1'' || ''-'' || ''DATAFLEXSYNCDATA'') AS BRANCH_KEY,
''UNKNOWN'' AS BRANCH_NAME ,
''IL - 8380'' AS SYSTEM_CODE,
3 AS SOURCE_SYSTEM_ID,
''AMS'' AS SOURCE_SYSTEM_TYPE,
-1 AS OFFICE_NUMBER,
-1 AS OFFICE_CODE,
''UNKNOWN'' AS OFFICE_NAME,
''UNKNOWN'' AS OFFICE_NAME_ALT,
NULL AS DEPARTMENT_NAME,
NULL AS BRANCH_SERVICE_LINE,
FALSE AS PARENT_FLAG,
md5( ''IL'' || ''-'' || ''-1'' || ''-'' || ''DATAFLEXSYNCDATA'') AS PARENT_BRANCH_KEY,
-1 AS PARENT_OFFICE_NUMBER,
-1 AS PARENT_OFFICE_CODE,
''IL'' || ''-'' || ''UNKNOWN'' || ''-'' ||  ''('' || -1 || '')''  AS PARENT_BRANCH_NAME,
NULL AS OFFICE_ADDRESS1,
NULL AS OFFICE_ADDRESS2,
NULL AS OFFICE_CITY,
''IL'' AS OFFICE_STATE_CODE,
NULL AS OFFICE_ZIP,
NULL AS OFFICE_PHONE,
NULL AS OFFICE_TOLL_FREE_PHONE,
NULL AS OFFICE_FAX,
''IL'' || ''-'' || ''UNKNOWN'' || ''-'' ||  ''('' || -1 || '')''  AS DETAILED_OFFICE_NAME,
-1 AS REGION_NUMBER,
NULL AS REGION_NAME,
NULL AS REGION_MANAGER,
NULL AS REGION_MANAGER_EMPLOYEE_KEY,
NULL AS SUBREGION_NAME,
NULL AS PRIMARY_BRANCH_MANAGER_NAME,
NULL AS PRIMARY_BRANCH_EMAIL,
NULL AS PRIMARY_BRANCH_MANAGER_EMPLOYEE_KEY,
NULL AS SECONDARY_BRANCH_MANAGER_NAME,
NULL AS SECONDARY_BRANCH_EMAIL,
NULL AS SECONDARY_BRANCH_MANAGER_EMPLOYEE_KEY,
NULL AS RISKCONNECT_NODE_KEY,
NULL AS RISKCONNECT_NAME,
NULL AS HR_OFFICE_NUMBER,
NULL AS HR_OFFICE_NAME,
FALSE AS ACTIVE_FLAG,
TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
CURRENT_USER AS ETL_INSERTED_BY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
CURRENT_USER AS ETL_LAST_UPDATED_BY,
FALSE AS ETL_DELETED_FLAG,
FALSE AS ETL_INFERRED_MEMBER_FLAG 
;
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    ';