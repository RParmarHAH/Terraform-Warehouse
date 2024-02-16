CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_COSTALSYNCDATA_DIM_VISIT_STATUS_MAPPING("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result varchar(1000);
BEGIN

--*****************************************************************************************************************************
-- NAME:  COSTALSYNCDATA_DIM_VISIT_STATUS_MAPPING
--
-- PURPOSE: Creates one row per status
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 01/16/23    Shraddha Sejpal       Initial Development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.COSTALSYNCDATA_DIM_VISIT_STATUS_MAPPING 
WITH DATA AS(
SELECT *, CASE WHEN STATUS IN (''T'') AND VISITTIME = ''Past'' THEN ''TentativePast'' 
	 WHEN STATUS IN (''S'') AND VISITTIME = ''Past'' THEN ''ScheduledPast'' 
	 WHEN STATUS IN (''O'') AND VISITTIME = ''Past'' THEN ''OpenPast'' ELSE STATUS
	 END AS DERIVED_DISC_STATUS FROM (
SELECT S.DB,CASE S.DB WHEN ''SHC_ALTRUS'' THEN 1 WHEN ''SHC_SAVANNAH'' THEN 2 ELSE -1 END AS SOURCE_SYSTEM_ID,
TRIM(SCHEDULE_STATUS_CODE) AS STATUS,
CASE WHEN SCHEDULE_DATE <CURRENT_DATE() THEN ''Past'' ELSE ''Future'' END AS VISITTIME	
FROM DISC_PROD.COSTALSYNCDATA.CV_Schedules s 
))
SELECT DISTINCT MD5(DATA.DB ||''-''|| DATA.DERIVED_DISC_STATUS) AS VISIT_STATUS_KEY,
DATA.SOURCE_SYSTEM_ID, 
DATA.DB AS SYSTEM_CODE, 
DATA.DERIVED_DISC_STATUS AS DERIVED_DISC_STATUS,
NULL AS DISC_SCHEDULE_STATUS,STATUS AS DISC_VISIT_STATUS, 
NULL AS DISC_INVOICE_STATUS, NULL AS DISC_PAYROLL_STATUS,
CASE WHEN STATUS IN (''VS'',''PN'',''PC'',''C'',''UN'',''T'',''S'') THEN ''s01''
	 WHEN STATUS IN (''O'') THEN ''s02'' 
	 WHEN STATUS IN (''ER'') THEN ''s03'' END AS SCHEDULE_STATUS_CODE,
CASE WHEN STATUS IN (''VS'',''PN'',''PC'',''C'',''UN'',''T'',''S'') THEN ''Scheduled''
	 WHEN STATUS IN (''O'') THEN ''Scheduled-Open'' 
     WHEN STATUS IN (''ER'') THEN ''Rescheduled'' END AS SCHEDULE_STATUS_NAME,
CASE WHEN STATUS IN (''VS'',''PN'',''PC'',''C'',''UN'',''T'',''S'') THEN ''Scheduled''
	 WHEN STATUS IN (''O'') THEN ''Scheduled-Open''
     WHEN STATUS IN (''ER'') THEN ''Rescheduled'' END AS SCHEDULE_STATUS_DESCRIPTION,
CASE WHEN STATUS IN (''VP'',''VB'',''V'',''P'',''B'',''BP'',''C'') THEN ''v04''
	 WHEN STATUS IN (''PN'',''PC'',''OH'',''ND'',''HS'',''HR'',''EN'',''EC'',''DE'') THEN ''v03''
	 WHEN STATUS IN (''UN'',''T'',''O'') AND VISITTIME = ''Past'' THEN ''v03''
	 WHEN STATUS IN (''S'') AND VISITTIME= ''Future'' THEN ''v01'' END AS VISIT_STATUS_CODE,
CASE WHEN STATUS IN (''VP'',''VB'',''V'',''P'',''B'',''BP'',''C'') THEN ''Completed''
	 WHEN STATUS IN (''PN'',''PC'',''OH'',''ND'',''HS'',''HR'',''EN'',''EC'',''DE'') THEN ''Did not happen''
	 WHEN STATUS IN (''UN'',''T'',''O'') AND VISITTIME = ''Past'' THEN ''Did not happen''
	 WHEN STATUS IN (''S'') AND VISITTIME= ''Future'' THEN ''Future'' END AS VISIT_STATUS_NAME,
CASE WHEN STATUS IN (''VP'',''VB'',''V'',''P'',''B'',''BP'',''C'') THEN ''Completed''
	 WHEN STATUS IN (''PN'',''PC'',''OH'',''ND'',''HS'',''HR'',''EN'',''EC'',''DE'') THEN ''Did not happen''
	 WHEN STATUS IN (''UN'',''T'',''O'') AND VISITTIME = ''Past'' THEN ''Did not happen''
	 WHEN STATUS IN (''S'') AND VISITTIME= ''Future'' THEN ''Future'' END AS VISIT_STATUS_DESCRIPTION,
CASE WHEN STATUS IN (''VB'',''V'',''BP'',''B'') THEN ''i03'' END AS INVOICE_STATUS_CODE,
CASE WHEN STATUS IN (''VB'',''V'',''BP'',''B'') THEN ''Billed'' END AS INVOICE_STATUS_NAME,
CASE WHEN STATUS IN (''VB'',''V'',''BP'',''B'') THEN ''Billed'' END AS INVOICE_STATUS_DESCRIPTION,
CASE WHEN STATUS IN (''V'',''P'',''BP'') THEN ''p03'' END AS PAYROLL_STATUS_CODE,
CASE WHEN STATUS IN (''V'',''P'',''BP'') THEN ''Paid'' END AS PAYROLL_STATUS_NAME,
CASE WHEN STATUS IN (''V'',''P'',''BP'') THEN ''Paid'' END AS PAYROLL_STATUS_DESCRIPTION,
CASE WHEN TRIM(DATA.STATUS) IN (''B'',''BP'',''C'',''P'',''V'',''VB'',''VP'') THEN ''YES'' 
     WHEN TRIM(DATA.STATUS) IN (''CC'',''DE'',''EC'',''EN'',''ER'',''HR'',''HS'',''M'',''ND'',''O'',''OH'',''PC'',''PN'',''PR'',''R2'',''S'',''SV'',''T'',''UN'',''VS'') 
     THEN ''NO'' ELSE ''UNKNOWN'' END AS CONFIRMED_FLAG,
NULL AS CONSISTENT_FLAG
FROM DATA;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';