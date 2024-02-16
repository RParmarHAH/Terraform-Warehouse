CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_DATAFLEXSYNCDATA_DIM_VISIT_STATUS_MAPPING("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME:  DATAFLEXSYNCDATA_DIM_VISIT_STATUS_MAPPING
--
-- PURPOSE: Creates one row per status
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 02/13/23     Saurav Purohit      Initial Development
-- 04/21/23		Saurav Purohit		Added logic to fetch status mapping for non - confirmed visits/Future Schedules from Sandata
-- 11/20/23		Saurav Purohit		Removed NULL Employee number condition as its not needed & it is also causing dup key issue 
--									when ref no from timesheethours is not found in dftimesheets table.
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.DATAFLEXSYNCDATA_DIM_VISIT_STATUS_MAPPING (SOURCE_SYSTEM_ID, SYSTEM_CODE, DISC_SCHEDULE_STATUS, DISC_INVOICE_STATUS, DISC_VISIT_STATUS, DISC_PAYROLL_STATUS, DERIVED_DISC_STATUS, VISIT_STATUS_KEY,
SCHEDULE_STATUS_CODE, SCHEDULE_STATUS_NAME, SCHEDULE_STATUS_DESCRIPTION, VISIT_STATUS_CODE, VISIT_STATUS_NAME, VISIT_STATUS_DESCRIPTION, INVOICE_STATUS_CODE, 
INVOICE_STATUS_NAME, INVOICE_STATUS_DESCRIPTION, PAYROLL_STATUS_CODE, PAYROLL_STATUS_NAME, PAYROLL_STATUS_DESCRIPTION, CONFIRMED_FLAG, CONSISTENT_FLAG)
with 
DF_IMPORT_VISITS AS 																-- Using only 1 record from multiple records per scheduleid just for mapping between DF and SD
(
SELECT ROW_NUMBER()OVER(PARTITION BY VISITKEY, TRACKINGID, WEEKENDDATE, STATE, SERVICEDATE ORDER BY IMPORTTASKID DESC, LINEID DESC) RNO,
		VISITKEY,
		split_part(VISITKEY, ''_'',  3)::NUMBER AS SCHEDULEID,
		split_part(VISITKEY, ''_'',  2) AS AGENCYID,
		TRACKINGID, WEEKENDDATE, STATE, SERVICEDATE 
FROM DISC_PROD.SANDATAEXCHANGE.DFIMPORT_IMPORTVISITS
WHERE ISIMPORTED = TRUE AND NVL(TRACKINGID,0) <> 0
QUALIFY RNO = 1			   
)
, SDV AS  
(SELECT 
NVL(SCH.AGENCYID, SD.AGENCYID) AS AGENCYID,
CASE NVL(SCH.AGENCYID, SD.AGENCYID) WHEN ''8380'' THEN ''IL'' WHEN ''8463'' THEN ''MO'' END AS DFDBNAME,
IFF(BI.STAFFAGENCYID = '''', NULL, BI.STAFFAGENCYID)::NUMBER AS BI_STAFFAGENCYID,
IFF(SD.STAFFAGENCYID = '''', NULL, SD.STAFFAGENCYID)::NUMBER AS SD_STAFFAGENCYID,
NVL(BI_STAFFAGENCYID, SD_STAFFAGENCYID) AS STAFFAGENCYID,
NVL(SCH.STATUS, SD.EVENTSTATUS ) AS STATUS,
NVL(SCH.SCHEDULEDATE , SD."DATE") AS SCHEDULEDATE 
FROM DISC_PROD.SANDATAIMPORT.SANDATA_SCHEDULES SCH 
FULL OUTER JOIN DISC_PROD.SANDATAIMPORT.SANDATA_VISITS SD 
ON SCH.SCHEDULEID = SD.SCHEDULEID AND SCH.AGENCYID = SD.AGENCYID
LEFT JOIN DISC_PROD.BI_REPOSITORY.SANDATAVISITS BI ON SCH.SCHEDULEID = BI.SCHEDULEID AND SCH.AGENCYID = BI.AGENCYID
WHERE NVL(SCH.AGENCYID, sd.AGENCYID) IN (''8380'',''8463'')  AND NVL(SCH.STATUS, SD.EVENTSTATUS ) IN (''01'',''09'',''10'')
)
	,DF AS 
	(
	SELECT DISTINCT
	3 AS SOURCE_SYSTEM_ID,
	F.DBNAME AS SYSTEM_CODE,
	CASE WHEN f.PAID = TRUE THEN ''05''
		WHEN f.PAID = FALSE AND f.BILLED = TRUE THEN ''04''
		ELSE ''02''
		END AS STATUS1,		-- DF STATUSES
	NULL AS DISC_SCHEDULE_STATUS,
	NULL AS DISC_INVOICE_STATUS,
	   CASE STATUS1 
        WHEN ''02'' THEN ''Confirmed''
        WHEN ''04'' THEN ''Billed''
        WHEN ''05'' THEN ''Paid''
        END AS DISC_VISIT_STATUS,
        iff(TS.PAIDFLAG = '''',NULL,TS.PAIDFLAG) AS DISC_PAYROLL_STATUS,
        CASE WHEN F.SERVICEDATE::DATE <> COALESCE(MIN(SV.ADJUSTEDTIMEIN),F.SERVICEDATE)::DATE THEN 
        	CASE STATUS1 WHEN ''02'' THEN ''Rescheduled-Confirmed''
        				WHEN ''04'' THEN ''Rescheduled-Billed''
        				WHEN ''05'' THEN ''Rescheduled-Paid''
        				END
		ELSE DISC_VISIT_STATUS
        END AS DERIVED_DISC_STATUS,	
        md5(3 ||''-''||F.DBNAME||''-''||nvl(DERIVED_DISC_STATUS,''Unknown'')||''-''||nvl(DISC_PAYROLL_STATUS,''Unknown'')) as VISIT_STATUS_KEY,
		-------------------------------------------------------------------------
	CASE 
		--WHEN MAX(TS.EMPLOYEENUMBER) IS NULL THEN ''s02'' 
		WHEN --MAX(TS.EMPLOYEENUMBER) IS NOT NULL AND 
		COALESCE(MIN(SV.ADJUSTEDTIMEIN),F.SERVICEDATE)::DATE = F.SERVICEDATE::DATE THEN ''s01''
		WHEN COALESCE(MIN(SV.ADJUSTEDTIMEIN),F.SERVICEDATE)::DATE<>F.SERVICEDATE::DATE THEN ''s03''
		ELSE NULL 
		END AS SCHEDULE_STATUS_CODE,
		-------------------------------------------------------------------------
	CASE  
		--WHEN MAX(TS.EMPLOYEENUMBER) IS NULL THEN ''Scheduled-Open'' 
		WHEN --MAX(TS.EMPLOYEENUMBER) IS NOT NULL AND 
		COALESCE(MIN(SV.ADJUSTEDTIMEIN),F.SERVICEDATE)::DATE = F.SERVICEDATE::DATE THEN ''Scheduled''
		WHEN COALESCE(MIN(SV.ADJUSTEDTIMEIN),F.SERVICEDATE)::DATE<>F.SERVICEDATE::DATE THEN ''Rescheduled''
		ELSE NULL
		END AS SCHEDULE_STATUS_NAME,
		-------------------------------------------------------------------------
	CASE  
		WHEN COALESCE(MIN(SV.ADJUSTEDTIMEIN),F.SERVICEDATE)::DATE = F.SERVICEDATE::DATE THEN ''A visit is in the future and has not been performed yet or no calls have hit the visit yet (can go to hold or confirmed)''
		WHEN COALESCE(MIN(SV.ADJUSTEDTIMEIN),F.SERVICEDATE)::DATE <> F.SERVICEDATE::DATE THEN ''Either the visit or the first shift of the visit has been Rescheduled''
		END AS SCHEDULE_STATUS_DESCRIPTION,
		-------------------------------------------------------------------------
	CASE  
        WHEN STATUS1 IN  (''02'',''04'',''05'') THEN ''v04''
        ELSE NULL
        END AS VISIT_STATUS_CODE, 
		-------------------------------------------------------------------------
	CASE  
        WHEN STATUS1 IN (''02'',''04'',''05'') THEN ''Completed''	
		ELSE NULL
        END AS VISIT_STATUS_NAME,
		-------------------------------------------------------------------------
	CASE 
        WHEN STATUS1= ''02'' THEN ''The visit is complete and has either confirmed on its own or manually confirmed and is ready to bill or pay (can go in process)''
        WHEN STATUS1 IN (''04'',''05'') THEN ''The visit was confirmed that it happened and billed'' ELSE NULL
        END AS VISIT_STATUS_DESCRIPTION,
		-------------------------------------------------------------------------
    CASE STATUS1
		WHEN ''02'' THEN ''i02'' 
		WHEN ''04'' THEN ''i03'' 
		WHEN ''05'' THEN ''i03'' ELSE NULL
		END AS INVOICE_STATUS_CODE,
		-------------------------------------------------------------------------
	CASE STATUS1
		WHEN ''02'' THEN ''Unbilled''
		WHEN ''04'' THEN ''Billed''
		WHEN ''05'' THEN ''Billed'' ELSE NULL
		END AS INVOICE_STATUS_NAME,
		-------------------------------------------------------------------------
	CASE STATUS1
		WHEN ''02'' THEN ''The visit is complete and has either confirmed on its own or manually confirmed and is ready to bill or pay (can go in process)''
		WHEN ''04'' THEN ''The visit was confirmed that it happened and billed'' 
		WHEN ''05'' THEN ''The visit was confirmed that it happened and billed & Paid'' ELSE NULL
		END AS INVOICE_STATUS_DESCRIPTION,
		-------------------------------------------------------------------------
	CASE
		WHEN TS.PAIDFLAG = ''Y'' THEN ''p03'' WHEN TS.PAIDFLAG=''0'' THEN ''p02'' WHEN TS.PAIDFLAG=''R'' THEN ''p01'' ELSE NULL END
		 AS PAYROLL_STATUS_CODE,
	CASE
		WHEN TS.PAIDFLAG =''Y'' THEN ''Paid'' WHEN TS.PAIDFLAG=''0'' THEN ''Unpaid'' WHEN TS.PAIDFLAG=''R'' THEN ''Not Payable'' ELSE NULL END
		 AS PAYROLL_STATUS_NAME,
	CASE 
		WHEN TS.PAIDFLAG =''Y'' THEN ''The visit is complete and the employee is paid'' 
		WHEN TS.PAIDFLAG =''0'' THEN ''The visit is complete and has either confirmed on its own or manually confirmed and is ready to bill or pay'' 
		WHEN TS.PAIDFLAG =''R'' THEN ''Not Payable as either the visit or payment has been cancelled'' 
		ELSE NULL END AS PAYROLL_STATUS_DESCRIPTION,
		CASE WHEN STATUS1 IN (''02'',''04'',''05'') THEN ''YES''
		 --WHEN STATUS1 IN (''01'',''09'',''10'') THEN ''NO'' 
		 ELSE ''UNKNOWN'' END AS CONFIRMED_FLAG,
	NULL AS CONSISTENT_FLAG
FROM DISC_PROD.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS TS1 
LEFT JOIN DF_IMPORT_VISITS DFI 																		-- ONLY IL AND MO CAN COME USING THIS JOIN FROM SANDATA
	ON TS1.TRACKINGID = DFI.TRACKINGID 
	AND TS1.WEEKENDDATE = DFI.WEEKENDDATE 
	AND TS1.DBNAME = DFI.STATE 
LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_VISITS SV
	ON DFI.SCHEDULEID = SV.SCHEDULEID  
	AND DFI.AGENCYID = SV.AGENCYID
	AND TS1.clientnumber::varchar=SV.CLIENTOTHERID 
	AND DFI.SERVICEDATE = SV.DATE
LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_SCHEDULES SCH 
	ON  DFI.SCHEDULEID = SCH.SCHEDULEID  
	AND DFI.AGENCYID = SCH.AGENCYID
	AND DFI.SERVICEDATE = SCH.SCHEDULEDATE
RIGHT JOIN DISC_PROD.DATAFLEXSYNCDATA.ALL_TIMESHEETSHOURS f
	ON f.DbName = ts1.DbName 
	AND f.ReferenceNo = ts1.ReferenceNo 
	AND f.WeekendDate = ts1.WeekendDate 
	AND F.SERVICEDATE = IFF(F.SERVICEDATE = COALESCE(SV.DATE,SCH.SCHEDULEDATE),COALESCE(SV.DATE,SCH.SCHEDULEDATE),F.SERVICEDATE) -- ONLY JOIN ON servicedate WHEN mapping IS possible, otherwise will GET TS.DATA ONLY FOR visits mapped WITH sd AND rest will have NULL
	AND F.SERVICEDATE = IFF(F.SERVICEDATE = DFI.SERVICEDATE,DFI.SERVICEDATE,NVL(DFI.SERVICEDATE,F.SERVICEDATE))					--  To avoid getting 1 - many join between TSH and Mapping table DFI
LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS TS 																-- This join will only be used to get fields, the previous TS1 join''s purpose is to just act as mapping between tables
	ON TS.DBNAME = F.DBNAME AND TS.REFERENCENO = F.REFERENCENO AND F.WEEKENDDATE = TS.WEEKENDDATE
GROUP BY f.dbname,F.PAID,F.BILLED,TS.PAIDFLAG, f.SERVICEDATE
)
,
SD AS 
(SELECT DISTINCT 
3 AS SOURCE_SYSTEM_ID,
	CASE DFDBNAME WHEN ''IL'' THEN ''IL - 8380'' WHEN ''MO'' THEN ''MO - 8463'' END AS SYSTEM_CODE,
	NULL AS DISC_SCHEDULE_STATUS,
	NULL AS DISC_INVOICE_STATUS,
	   CASE STATUS
        WHEN ''01'' THEN ''Pending''
        WHEN ''09'' THEN ''Hold''
        WHEN ''10'' THEN ''Cancelled''
        END AS DISC_VISIT_STATUS,
    NULL AS DISC_PAYROLL_STATUS,
        CASE WHEN STATUS =''01'' AND STAFFAGENCYID IS NULL AND SCHEDULEDATE > CURRENT_DATE() THEN ''01OPENFUTURE'' 
		WHEN STATUS =''01'' AND STAFFAGENCYID IS NOT NULL AND SCHEDULEDATE > CURRENT_DATE() THEN ''01FUTURE''
		WHEN STATUS =''01'' AND STAFFAGENCYID IS NULL AND SCHEDULEDATE <= CURRENT_DATE() THEN ''01OPEN'' 
		WHEN STATUS =''01'' AND STAFFAGENCYID IS NOT NULL AND SCHEDULEDATE <= CURRENT_DATE() THEN ''01'' 
		ELSE STATUS END
		AS DERIVED_DISC_STATUS,	
md5(3 ||''-''||DFDBNAME||''-''||nvl(DISC_VISIT_STATUS,''Unknown'')||''-''||DERIVED_DISC_STATUS) as VISIT_STATUS_KEY,
CASE 
		WHEN STATUS =''01'' AND STAFFAGENCYID IS NULL THEN ''s02'' 
		WHEN STATUS =''01'' AND STAFFAGENCYID IS NOT NULL THEN ''s01''
		WHEN STATUS =''10'' THEN ''s05'' ELSE ''s01'' 
		END AS SCHEDULE_STATUS_CODE, 
	CASE  
		WHEN STATUS =''01'' AND STAFFAGENCYID IS NULL THEN ''Scheduled-Open'' 
		WHEN STATUS =''01'' AND STAFFAGENCYID IS NOT NULL THEN ''Scheduled''
		WHEN STATUS =''10'' THEN ''Cancelled'' ELSE ''Scheduled''
		END AS SCHEDULE_STATUS_NAME,
	CASE STATUS 
		WHEN ''10'' THEN ''A visit has been cancelled and is no longer taking place (can be set back to confirmed, hold or pending)'' 
		ELSE ''A visit is in the future and has not been performed yet or no calls have hit the visit yet (can go to hold or confirmed)''
		END AS SCHEDULE_STATUS_DESCRIPTION,
	CASE  
		WHEN STATUS= ''01'' AND SCHEDULEDATE > CURRENT_DATE() THEN ''v01''
        WHEN STATUS= ''09'' THEN ''v02''
        WHEN STATUS= ''10'' THEN ''v03''
        ELSE NULL
        END AS VISIT_STATUS_CODE, ---added generalized status codes FOR ALL SOURCE systems.
	CASE  
	    WHEN STATUS= ''01'' AND SCHEDULEDATE > CURRENT_DATE() THEN ''Future''
        WHEN STATUS= ''09'' THEN ''In Review''
        WHEN STATUS= ''10'' THEN ''Did not happen''
        ELSE NULL
        END AS VISIT_STATUS_NAME,
	CASE 
	 	WHEN STATUS= ''01'' AND SCHEDULEDATE > CURRENT_DATE() THEN ''A visit is in the future and has not been performed yet or no calls have hit the visit yet (can go to hold or confirmed)''
        WHEN STATUS= ''09'' THEN ''A visit has an exception or missing a call and needs to be manually confirmed (can go to confirmed, pending or cancelled) (once a exception is put on a visit via the system, it moves from pending to hold)''
        WHEN STATUS= ''10'' THEN ''A visit has been cancelled and is no longer taking place (can be set back to confirmed, hold or pending)''
        ELSE NULL
        END AS VISIT_STATUS_DESCRIPTION,
	NULL AS INVOICE_STATUS_NAME,
	NULL AS INVOICE_STATUS_CODE,
	NULL AS INVOICE_STATUS_DESCRIPTION,
	--
	NULL AS PAYROLL_STATUS_CODE,
	NULL AS PAYROLL_STATUS_NAME,
	NULL AS PAYROLL_STATUS_DESCRIPTION,
	''NO'' AS CONFIRMED_FLAG,
	NULL AS CONSISTENT_FLAG
FROM SDV)
,FINAL AS
(SELECT SOURCE_SYSTEM_ID, SYSTEM_CODE, DISC_SCHEDULE_STATUS, DISC_INVOICE_STATUS, DISC_VISIT_STATUS, DISC_PAYROLL_STATUS, DERIVED_DISC_STATUS, VISIT_STATUS_KEY,
SCHEDULE_STATUS_CODE, SCHEDULE_STATUS_NAME, SCHEDULE_STATUS_DESCRIPTION, VISIT_STATUS_CODE, VISIT_STATUS_NAME, VISIT_STATUS_DESCRIPTION, INVOICE_STATUS_CODE, 
INVOICE_STATUS_NAME, INVOICE_STATUS_DESCRIPTION, PAYROLL_STATUS_CODE, PAYROLL_STATUS_NAME, PAYROLL_STATUS_DESCRIPTION, CONFIRMED_FLAG, CONSISTENT_FLAG 
FROM DF 
UNION
SELECT SOURCE_SYSTEM_ID, SYSTEM_CODE, DISC_SCHEDULE_STATUS, DISC_INVOICE_STATUS, DISC_VISIT_STATUS, DISC_PAYROLL_STATUS, DERIVED_DISC_STATUS, VISIT_STATUS_KEY,
SCHEDULE_STATUS_CODE, SCHEDULE_STATUS_NAME, SCHEDULE_STATUS_DESCRIPTION, VISIT_STATUS_CODE, VISIT_STATUS_NAME, VISIT_STATUS_DESCRIPTION, INVOICE_STATUS_CODE, 
INVOICE_STATUS_NAME, INVOICE_STATUS_DESCRIPTION, PAYROLL_STATUS_CODE, PAYROLL_STATUS_NAME, PAYROLL_STATUS_DESCRIPTION, CONFIRMED_FLAG, CONSISTENT_FLAG 
FROM SD)
SELECT * FROM FINAL;
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    ';