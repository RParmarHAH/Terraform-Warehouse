create or replace view DW_PROD.STAGE.VW_CURRENT_DATAFLEXSYNCDATA_DIM_CLIENT(
	CLIENT_KEY
) as
WITH TIMESHEET_0 AS(
SELECT
MAX(MAX(H.SERVICEDATE)) OVER (PARTITION BY T.CLIENTNUMBER, h.dbname) AS LAST_SERVICE_DATE
,MIN(MIN(H.SERVICEDATE)) OVER (PARTITION BY T.CLIENTNUMBER, h.dbname) AS FIRST_SERVICE_DATE
,MAX(MAX(H.SERVICEDATE)) OVER (PARTITION BY T.CLIENTNUMBER, h.dbname, CO.REVENUECATEGORY) AS LAST_SERVICE_DATE_BY_SERVICE_LINE
,MIN(MIN(H.SERVICEDATE)) OVER (PARTITION BY T.CLIENTNUMBER, h.dbname, CO.REVENUECATEGORY) AS FIRST_SERVICE_DATE_BY_SERVICE_LINE
,T.CLIENTNUMBER AS CLIENT_NUMBER
,DATEDIFF('day', LAST_SERVICE_DATE,CURRENT_DATE()) AS DAYS_SINCE_LAST_SERVICE
, h.dbname
, CO.REVENUECATEGORY AS SERVICE_LINE
, DATE_TRUNC(MONTH, H.SERVICEDATE) AS REPORT_MONTH
, SUM(H.SERVICEHOURS) AS SERVICE_HOURS
,GREATEST(NVL(MAX(H.ETL_LAST_UPDATED_DATE), '1900-01-01'), NVL(MAX(CO.ETL_LAST_UPDATED_DATE), '1900-01-01')) AS ETL_LAST_UPDATED_DATE
FROM DISC_PROD.DATAFLEXSYNCDATA.ALL_TIMESHEETSHOURS H
JOIN DISC_PROD.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS T ON T.REFERENCENO = H.REFERENCENO AND T.DBNAME = H.DBNAME AND T.WEEKENDDATE = H.WEEKENDDATE
LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFCONTRACTS CO ON CO.CONTRACTCODE = T.CONTRACTCODE AND CO.DBNAME = T.DBNAME 
GROUP BY
T.CLIENTNUMBER, h.dbname, CO.REVENUECATEGORY, DATE_TRUNC(MONTH, H.SERVICEDATE)
),
TIMESHEET AS (
	SELECT DISTINCT TIMESHEETS_LAST.DBNAME, TIMESHEETS_LAST.CLIENT_NUMBER, TIMESHEETS_LAST.FIRST_SERVICE_DATE, TIMESHEETS_LAST.LAST_SERVICE_DATE, TIMESHEETS_LAST.DAYS_SINCE_LAST_SERVICE,
		TIMESHEETS_LAST.SERVICE_LINE, TIMESHEETS_LAST.REPORT_MONTH, TIMESHEETS_LAST.SERVICE_HOURS AS SERVICE_HOURS_LATEST_MONTH,
		MAX(TIMESHEETS_LAST.ETL_LAST_UPDATED_DATE) OVER (PARTITION BY TIMESHEETS_LAST.DBNAME, TIMESHEETS_LAST.CLIENT_NUMBER) AS ETL_LAST_UPDATED_DATE 
	FROM TIMESHEET_0 AS TIMESHEETS
	JOIN TIMESHEET_0 AS TIMESHEETS_LAST 
		ON TIMESHEETS_LAST.CLIENT_NUMBER = TIMESHEETS.CLIENT_NUMBER AND TIMESHEETS_LAST.DBNAME = TIMESHEETS.DBNAME AND TIMESHEETS_LAST.SERVICE_LINE = TIMESHEETS.SERVICE_LINE
			AND TIMESHEETS_LAST.REPORT_MONTH = DATE_TRUNC(MONTH, TIMESHEETS.LAST_SERVICE_DATE_BY_SERVICE_LINE) 
),
BULK_BILLING_CLIENTS AS (
	SELECT I.DBNAME, I.OFFICE,
		TRY_CAST(CONCAT(-100, I.OFFICE) AS INTEGER) AS DUMMY_CLIENT_NUMBER,
		COALESCE(B.BRANCH_NAME, CONCAT(I.DBNAME, '-Unknown')) AS BRANCH_NAME,
		MAX(GREATEST(COALESCE(I.ETL_LAST_UPDATED_DATE, '1/1/1900'), COALESCE(B.ETL_LAST_UPDATED_DATE, '1/1/1900'))) AS ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.DATAFLEXSYNCDATA.DFARINVOICES I
	LEFT JOIN HAH.DIM_BRANCH B ON B.SOURCE_SYSTEM_ID = 3 AND B.SYSTEM_CODE = I.DBNAME AND B.OFFICE_NUMBER = I.OFFICE
	GROUP BY I.DBNAME, I.OFFICE, COALESCE(B.BRANCH_NAME, CONCAT(I.DBNAME, '-Unknown'))
),
SUPERVISORS AS (
--SELECT B.DBNAME, B.CLIENTNUMBER , A."CODE" SUPERVISORCODE , A."NAME" NAME, MAX(GREATEST(COALESCE(A.ETL_LAST_UPDATED_DATE, '1/1/1900'), COALESCE(B.ETL_LAST_UPDATED_DATE, '1/1/1900'))) AS ETL_LAST_UPDATED_DATE
--FROM DISC_PROD.DATAFLEXSYNCDATA.DFSUPERVISORS A
--LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFCLIENTSUPERVISORS B
--ON B.SUPERVISORCODE = A.CODE AND A.DBNAME = B.DBNAME
--GROUP BY B.DBNAME, B.CLIENTNUMBER , A.CODE, A."NAME"
SELECT SPV_LIST.DBNAME, SPV_LIST.CLIENT_NUMBER, SPV_LIST.SUPERVISORCODE, 
	COALESCE(T1.FIRST_SERVICE_DATE, T2.FIRST_SERVICE_DATE) AS FIRST_SERVICE_DATE, COALESCE(T1.LAST_SERVICE_DATE, T2.LAST_SERVICE_DATE) AS LAST_SERVICE_DATE, COALESCE(T1.DAYS_SINCE_LAST_SERVICE, T2.DAYS_SINCE_LAST_SERVICE) AS DAYS_SINCE_LAST_SERVICE,
	SPV_LIST.SERVICE_LINE, 
	GREATEST(SPV_LIST.ETL_LAST_UPDATED_DATE, NVL(SPV.ETL_LAST_UPDATED_DATE, '1900-01-01'), NVL(T1.ETL_LAST_UPDATED_DATE, '1900-01-01'), NVL(T2.ETL_LAST_UPDATED_DATE, '1900-01-01')) AS ETL_LAST_UPDATED_DATE,
	COALESCE(SPV."NAME", SPV_LIST.DBNAME || ' - Unknown') AS SUPERVISORNAME,
	ROW_NUMBER() OVER(PARTITION BY SPV_LIST.DBNAME, SPV_LIST.CLIENT_NUMBER ORDER BY CASE WHEN SPV_LIST.SERVICE_LINE IS NOT NULL THEN 0 ELSE 1 END, COALESCE(T1.REPORT_MONTH, T2.REPORT_MONTH) DESC, COALESCE(T1.SERVICE_HOURS_LATEST_MONTH, T2.SERVICE_HOURS_LATEST_MONTH) DESC, COALESCE(T1.LAST_SERVICE_DATE, T2.LAST_SERVICE_DATE) DESC) AS ROW_NUM
FROM (
	SELECT DCS.DBNAME, DCS.CLIENTNUMBER AS CLIENT_NUMBER, DCS.SUPERVISORCODE, DCS.BUSINESSLINE AS SERVICE_LINE, NVL(DCS.ETL_LAST_UPDATED_DATE, '1900-01-01') AS ETL_LAST_UPDATED_DATE 
	FROM DISC_PROD.DATAFLEXSYNCDATA.DFCLIENTSUPERVISORS AS DCS
	UNION ALL
	SELECT C.DBNAME, C."NUMBER" AS CLIENT_NUMBER, C.SUPERVISORCODE, NULL AS SERVICE_LINE, NVL(C.ETL_LAST_UPDATED_DATE, '1900-01-01') AS ETL_LAST_UPDATED_DATE 
	FROM DISC_PROD.DATAFLEXSYNCDATA.DFCLIENTS AS C
) AS SPV_LIST
LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFSUPERVISORS AS SPV
	ON SPV.DBNAME = SPV_LIST.DBNAME AND SPV.CODE = SPV_LIST.SUPERVISORCODE
LEFT JOIN TIMESHEET AS T1
	ON T1.DBNAME = SPV_LIST.DBNAME AND T1.CLIENT_NUMBER = SPV_LIST.CLIENT_NUMBER AND T1.SERVICE_LINE = SPV_LIST.SERVICE_LINE
LEFT JOIN TIMESHEET AS T2
	ON T1.DBNAME IS NULL 
		AND T2.DBNAME = SPV_LIST.DBNAME AND T2.CLIENT_NUMBER = SPV_LIST.CLIENT_NUMBER 
)
SELECT
md5(F.DBNAME || '-' || F.NUMBER || '-' || 'DATAFLEXSYNCDATA' ) AS CLIENT_KEY --PK
FROM DISC_PROD.DATAFLEXSYNCDATA.DFCLIENTS F
LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFOFFICES O ON O.DBNAME = F.DBNAME AND O.OFFICENUMBER = F.OFFICENUMBER 
--LEFT JOIN TIMESHEET T ON T.CLIENT_NUMBER = F.NUMBER AND t.dbname = f.dbname
LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DfSupervisors DFS ON F.SUPERVISORCODE = DFS.CODE AND f.DBNAME = DFS.DBNAME
LEFT JOIN SUPERVISORS S1 ON S1.CLIENT_NUMBER = F."NUMBER" AND S1.DBNAME = F.DBNAME AND S1.ROW_NUM = 1
LEFT JOIN SUPERVISORS S2 ON S2.CLIENT_NUMBER = F."NUMBER" AND S2.DBNAME = F.DBNAME AND S2.ROW_NUM = 2
LEFT JOIN HAH.DIM_STATE ST ON ST.STATE_ISO_CODE = F.STATE
WHERE (F.ETL_LAST_UPDATED_DATE >= '1900-01-01'
OR O.ETL_LAST_UPDATED_DATE >= '1900-01-01'
OR S1.ETL_LAST_UPDATED_DATE >= '1900-01-01'
OR S2.ETL_LAST_UPDATED_DATE >= '1900-01-01')
-- Bulk Billing Clients (used for DfArInvoices)
UNION ALL
SELECT md5(C.DBNAME || '-' || C.DUMMY_CLIENT_NUMBER || '-' || 'DATAFLEXSYNCDATA-DUMMY' ) AS CLIENT_KEY
FROM BULK_BILLING_CLIENTS C
WHERE C.ETL_LAST_UPDATED_DATE >= '1900-01-01';