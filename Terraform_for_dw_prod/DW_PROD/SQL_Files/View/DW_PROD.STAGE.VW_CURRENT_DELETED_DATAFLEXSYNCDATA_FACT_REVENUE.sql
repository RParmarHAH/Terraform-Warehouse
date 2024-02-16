create or replace view DW_PROD.STAGE.VW_CURRENT_DELETED_DATAFLEXSYNCDATA_FACT_REVENUE(
	REVENUE_KEY
) as
WITH paid_off as (
    SELECT
           inv.DBNAME,
           inv.INVOICENO,
           SUM(OUTSANDINGAMOUNT) AS OUTSANDINGAMOUNT
    FROM DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES inv
    WHERE  inv.ETL_DELETED_FLAG = FALSE
    GROUP BY 1,2
    HAVING SUM(OUTSANDINGAMOUNT) = 0
), AR_DIM_INVOICE_CHANGED_DATA AS (
	SELECT DISTINCT I.DBNAME, I.INVOICENUMBER, I.OFFICE, I.PERIOD, I.CONTRACTCODE,
		MD5(I.DBNAME || '-' || I.INVOICENUMBER || '-' || 
			I.OFFICE || '-' || I.PERIOD || '-' || I.CONTRACTCODE || '-' || 'DATAFLEXSYNCDATA-DFARINVOICES') AS INVOICE_KEY
	FROM DISC_PROD.DATAFLEXSYNCDATA.HIST_DFARINVOICES I
	WHERE I.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		AND I.ETL_DELETED_FLAG = TRUE
		AND CAST(I.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_PROD.DATAFLEXSYNCDATA.HIST_DFARINVOICES)
), AR_DIM_INVOICE AS (
	SELECT INV.DBNAME, INV.INVOICENUMBER, INV.SUPPLEMENTNO,
		DATEFROMPARTS(LEFT(TRIM(INV.PERIOD), 4), RIGHT(TRIM(INV.PERIOD), 2), 1) AS PERIOD_DATE,
		INV.PERIOD, INV.CONTRACTCODE AS CONTRACT_CODE, INV.OFFICE, INV.SERVICEAREA,
		CHANGED_DATA.INVOICE_KEY,
    	COALESCE(BRANCH.BRANCH_KEY, MD5(INV.DBNAME || '-' || INV.OFFICE || '-' || 'DATAFLEXSYNCDATA')) AS BRANCH_KEY,
		COALESCE(BRANCH.BRANCH_NAME, CONCAT(INV.DBNAME, '-Unknown')) AS BRANCH_NAME,
		TRY_CAST(CONCAT(-100, INV.OFFICE) AS INTEGER) AS DUMMY_CLIENT_NUMBER, -- Dummy clients/employees are in Dim_Client with -100 appended to office number
		TRY_CAST(CONCAT(-100, INV.OFFICE) AS INTEGER) AS DUMMY_EMPLOYEE_NUMBER,
		TRY_CAST(CONCAT(-100, INV.OFFICE) AS INTEGER)::STRING AS DUMMY_SUPERVISOR_CODE,
		MD5(INV.DBNAME || '-' || DUMMY_CLIENT_NUMBER || '-' || 'DATAFLEXSYNCDATA-DUMMY') AS DUMMY_CLIENT_KEY,
		MD5(INV.DBNAME || '-' || DUMMY_EMPLOYEE_NUMBER || '-' || '1900-01-01' || '-' || 'DATAFLEXSYNCDATA-DUMMY') AS DUMMY_EMPLOYEE_KEY,
		MD5(INV.DBNAME || '-' || DUMMY_SUPERVISOR_CODE || '-' || 'DATAFLEXSYNCDATA-DUMMY') AS DUMMY_SUPERVISOR_KEY,
		MD5(INV.DBNAME || '-' || INV.CONTRACTCODE || '-' || 'DATAFLEXSYNCDATA') AS CONTRACT_KEY,
		INV.DATECREATED, INV.HOURSBILLED AS HOURS_BILLED, INV.AMOUNTBILLED AS AMOUNT_BILLED, INV.CLIENTBILLED AS NUMBER_OF_CLIENTS,
		INV.OUTSTANDING AS AMOUNT_OUTSTANDING, INV.GROSSPAID AS AMOUNT_COLLECTED,
		INV.LASTPAYDATE 
	FROM AR_DIM_INVOICE_CHANGED_DATA AS CHANGED_DATA
	JOIN DISC_PROD.DATAFLEXSYNCDATA.HIST_DFARINVOICES INV
		ON INV.DBNAME = CHANGED_DATA.DBNAME AND INV.INVOICENUMBER = CHANGED_DATA.INVOICENUMBER 
			AND INV.OFFICE = CHANGED_DATA.OFFICE AND INV.PERIOD = CHANGED_DATA.PERIOD AND INV.CONTRACTCODE = CHANGED_DATA.CONTRACTCODE
	LEFT JOIN HAH.DIM_BRANCH AS BRANCH
		ON BRANCH.SOURCE_SYSTEM_ID = 3 AND BRANCH.SYSTEM_CODE = INV.DBNAME AND BRANCH.OFFICE_CODE = INV.OFFICE::STRING
	WHERE INV.ETL_DELETED_FLAG = TRUE
		AND CAST(INV.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_PROD.DATAFLEXSYNCDATA.HIST_DFARINVOICES)
), CLIENT_DATA AS
(
	SELECT * FROM
	(
		SELECT TRIM(DBNAME) AS MASTER_DBNAME, "NUMBER" AS MASTER_CLIENT_NUMBER, TRIM(DBNAME) AS DBNAME, "NUMBER" AS CLIENT_NUMBER,
			OFFICENUMBER AS OFFICE_NUMBER
		FROM DISC_DEDUPE_PROD.DATAFLEXSYNCDATA.CLIENT_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT TRIM(MASTER.DBNAME) AS MASTER_DBNAME, MASTER."NUMBER" AS MASTER_CLIENT_NUMBER, TRIM(MATCH.DBNAME) AS DBNAME, MATCH."NUMBER" AS CLIENT_NUMBER,
			MATCH.OFFICENUMBER AS OFFICE_NUMBER
		FROM DISC_DEDUPE_PROD.DATAFLEXSYNCDATA.CLIENT_MATCH_LIST AS MATCH
        JOIN DISC_DEDUPE_PROD.DATAFLEXSYNCDATA.CLIENT_MASTER_LIST AS MASTER 
            ON MASTER.MASTER_ID = MATCH.MASTER_ID
        WHERE MATCH.ID <> MATCH.MASTER_ID
	)
)
, EMPLOYEES AS 
(
	SELECT *,TO_DATE('1900-01-01', 'YYYY-MM-DD') AS EFFECTIVE_FROM_DATE, TO_DATE('9999-12-31', 'YYYY-MM-DD') AS EFFECTIVE_TO_DATE 
	FROM 
	(
		SELECT 
			TRIM(DBNAME) AS MASTER_DBNAME, 
			"NUMBER" AS MASTER_EMPLOYEE_NUMBER,
			TRIM(DBNAME) AS DBNAME, 
			"NUMBER" AS EMPLOYEE_NUMBER 
		FROM DISC_DEDUPE_PROD.DATAFLEXSYNCDATA.EMPLOYEE_MASTER_LIST
	) 
	UNION
	SELECT *,TO_DATE('1900-01-01', 'YYYY-MM-DD') AS EFFECTIVE_FROM_DATE, TO_DATE('9999-12-31', 'YYYY-MM-DD') AS EFFECTIVE_TO_DATE 
	FROM 
	(
		SELECT 
            TRIM(MASTER.DBNAME) AS MASTER_DBNAME, 
            MASTER."NUMBER" AS MASTER_EMPLOYEE_NUMBER, 
            TRIM(MATCH.DBNAME) AS DBNAME, 
            MATCH."NUMBER" AS EMPLOYEE_NUMBER
		FROM DISC_DEDUPE_PROD.DATAFLEXSYNCDATA.EMPLOYEE_MATCH_LIST AS MATCH
        JOIN DISC_DEDUPE_PROD.DATAFLEXSYNCDATA.EMPLOYEE_MASTER_LIST AS MASTER
            ON MASTER.MASTER_ID = MATCH.MASTER_ID
        WHERE MATCH.ID <> MATCH.MASTER_ID
	)
)
SELECT 
     MD5(NVL(dte.CALENDAR_DATE, '1900-01-01') || '-' || COALESCE(oc.OFFICENUMBER, tt.OFFCENO::string,'-1') || '-'
       || UPPER(NVL(TRIM(tt.EMPLOYEENUMBER),'')) || '-' || NVL(det.CLIENTNUMBER,-1) || '-' || COALESCE(det.CONTRACTCODE, inv.CONTRACTCODE, '-1')
       || '-' || det.INVOICENO || '-' || '3' || '-' || NVL(tt.SUPERVISORCODE,'Unknown-'||det.DBNAME) || '-'
       || COALESCE(tt.BILLCODE,det.BILLCODE,'Unknown') || '-' || det.REFERENCENO ||'-' || 'DATAFLEXSYNCDATA') AS REVENUE_KEY
FROM DISC_PROD.DATAFLEXSYNCDATA.HIST_DFINVOICEDETAILS det
LEFT JOIN paid_off po
   ON det.INVOICENO = po.INVOICENO
       and det.DBNAME = po.DBNAME
LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES inv
   ON det.DBNAME = inv.DBNAME
   AND det.INVOICENO = inv.INVOICENO
   AND inv.ETL_DELETED_FLAG = FALSE
LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFCONTRACTS con ON det.DBNAME = con.DBNAME AND det.CONTRACTCODE = con.CONTRACTCODE
   AND con.ETL_DELETED_FLAG = FALSE
LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFCLIENTSUPERVISORS spr ON det.DBNAME = spr.DBNAME AND det.CLIENTNUMBER = spr.CLIENTNUMBER
   AND con.PAYORCODE = spr.BUSINESSLINE AND spr.ETL_DELETED_FLAG = FALSE
--LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFCLIENTS cli ON det.DBNAME = cli.DBNAME AND det.CLIENTNUMBER = cli.NUMBER
LEFT JOIN CLIENT_DATA cli ON det.DBNAME = cli.DBNAME AND det.CLIENTNUMBER = cli.Client_number
LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFOFFICES oc ON cli.DBNAME = oc.DBNAME AND cli.OFFICE_NUMBER = oc.OFFICENUMBER
   AND oc.ETL_DELETED_FLAG = FALSE
LEFT JOIN HAH.DIM_DATE dte ON det.DATEFROM <= dte.CALENDAR_DATE AND NVL(det.DATETO, det.DATEFROM) >= dte.CALENDAR_DATE
LEFT JOIN (SELECT DISTINCT year(hr.SERVICEDATE) || RIGHT('0' || month(hr.SERVICEDATE),2) as period, hr.SERVICEDATE::date AS service_date
           , ts.EMPLOYEENUMBER, ts.CLIENTNUMBER, ts.BILLCODE, ts.SUPERVISORCODE, ts.OFFCENO, ts.DBNAME, ts.CONTRACTCODE
           , SUM(hr.SERVICEHOURS) OVER (PARTITION BY hr.SERVICEDATE, ts.EMPLOYEENUMBER, CLIENTNUMBER, BILLCODE, hr.DBNAME, CONTRACTCODE) as SRVHOURS
           ,  IFF(hr.SERVICEHOURS > 0, SRVHOURS
               / SUM(hr.SERVICEHOURS) OVER (PARTITION BY hr.SERVICEDATE, CLIENTNUMBER, BILLCODE, hr.DBNAME, CONTRACTCODE), 0) as RATIO
   FROM DISC_PROD.DATAFLEXSYNCDATA.ALL_TIMESHEETSHOURS  hr
   JOIN DISC_PROD.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS  ts ON hr.DBNAME = ts.DBNAME AND hr.REFERENCENO = ts.REFERENCENO
       AND ts.ETL_DELETED_FLAG = FALSE
   WHERE CONTRACTCODE = 'R' AND hr.ETL_DELETED_FLAG = FALSE
   --GROUP BY period, service_date, ts.EMPLOYEENUMBER, ts.CLIENTNUMBER, ts.BILLCODE, ts.SUPERVISORCODE, ts.OFFCENO, ts.DBNAME, ts.CONTRACTCODE
   ) tt
           ON inv.CLIENTNUMBER = tt.CLIENTNUMBER AND inv.CONTRACTCODE = tt.CONTRACTCODE
           AND dte.CALENDAR_DATE = tt.service_date AND inv.PERIOD = tt.period AND det.DBNAME = tt.DBNAME
           AND (det.EMPLOYEENO1 IS NULL OR det.EMPLOYEENO1 = tt.EMPLOYEENUMBER)
           AND (det.BILLCODE = '' OR det.BILLCODE = tt.BILLCODE)
left join EMPLOYEES EMP on tt.EMPLOYEENUMBER=EMP.EMPLOYEE_number and tt.DBNAME=EMP.DBNAME
WHERE det.ETL_DELETED_FLAG = TRUE and det.DATEFROM <= dte.CALENDAR_DATE AND NVL(det.DATETO, det.DATEFROM) >= dte.CALENDAR_DATE
	AND (det.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		OR inv.ETL_LAST_UPDATED_DATE >= '1900-01-01')
	AND CAST(det.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_PROD.DATAFLEXSYNCDATA.HIST_DFINVOICEDETAILS)
--AND det.INVOICENO = 14060335 --AND det.DBNAME = 'IN' AND dte.CALENDAR_DATE = '2016-12-05'
-- AND det.INVOICENO = 6464 AND det.DBNAME = 'MI' --AND dte.CALENDAR_DATE = '2013-10-01'
-- Bulk billing invoices (from DfArInvoices -- unique key for details is INV.DBNAME, INV.INVOICENUMBER, INV.OFFICE, INV.PERIOD, INV.CONTRACTCODE, INV.SERVICEAREA, INV.SUPPLEMENTNO)
UNION ALL
SELECT MD5(
   INV.DBNAME || '-' ||	INV.PERIOD || '-' || INV.OFFICE || '-' || INV.DUMMY_EMPLOYEE_NUMBER || '-' || INV.DUMMY_CLIENT_NUMBER || '-' || 
	INV.CONTRACT_CODE || '-' || INV.INVOICENUMBER || '-' || INV.DUMMY_SUPERVISOR_CODE || '-' || 
   INV.SERVICEAREA || '-' || INV.SUPPLEMENTNO || '-' || 'DATAFLEXSYNCDATA-DFARINVOICES') AS REVENUE_KEY
FROM AR_DIM_INVOICE AS INV
GROUP BY REVENUE_KEY, INV.PERIOD_DATE, INV.BRANCH_KEY, INV.DUMMY_EMPLOYEE_KEY, INV.DUMMY_CLIENT_KEY, INV.CONTRACT_KEY,
	INV.INVOICE_KEY, INV.DUMMY_SUPERVISOR_KEY, COALESCE(INV.DATECREATED, '1900-01-01'), INV.LASTPAYDATE, INV.BRANCH_NAME, INV.DUMMY_EMPLOYEE_NUMBER, INV.DUMMY_CLIENT_NUMBER, INV.CONTRACT_CODE,
	INV.INVOICENUMBER::STRING, INV.DBNAME, INV.DUMMY_SUPERVISOR_CODE;