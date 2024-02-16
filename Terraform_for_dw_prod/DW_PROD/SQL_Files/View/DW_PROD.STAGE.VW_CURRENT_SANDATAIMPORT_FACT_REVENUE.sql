create or replace view DW_PROD.STAGE.VW_CURRENT_SANDATAIMPORT_FACT_REVENUE(
	REVENUE_KEY
) as
WITH VISITS AS (
	SELECT V.VISIT_KEY, V.SYSTEM_CODE AS AGENCYID, V.SERVICE_DATE AS DATE,V.SERVICEID, V.CLIENT_NUMBER AS CLIENTID, V.CONTRACT_CODE AS ADMISSIONTYPE, V.OFFICE_CODE, V.BRANCH_NAME, V.EMPLOYEE_ID AS STAFFAGENCYID,
		V.HOURS_SERVED / SUM(V.HOURS_SERVED) OVER (PARTITION BY V.SYSTEM_CODE, V.CLIENT_NUMBER, V.CONTRACT_CODE, V.SERVICE_DATE) AS RATIO_DURATION,
		V.ETL_LAST_UPDATED_DATE
	FROM (
		SELECT V.VISIT_KEY, CASE WHEN V.BILL_CODE IN ('CARECO','VBPCG') THEN 'CC_'||V.SYSTEM_CODE ELSE V.SYSTEM_CODE END AS SYSTEM_CODE, 
		B.OFFICE_CODE, V.BILL_CODE AS SERVICEID,B.OFFICE_NUMBER, B.BRANCH_NAME, V.CLIENT_NUMBER, V.CONTRACT_CODE, V.SERVICE_DATE, V.EMPLOYEE_ID, V.HOURS_SERVED, V.ETL_LAST_UPDATED_DATE
		FROM HAH.FACT_VISIT V
		LEFT JOIN HAH.DIM_BRANCH B ON B.BRANCH_KEY = V.BRANCH_KEY
		WHERE V.SOURCE_SYSTEM_ID = 4 AND V.CONFIRMED_FLAG = 'YES'  -- V.STATUS_CODE IN ('02', '03', '04') /* Confirmed Visits */ 
		AND V.HOURS_SERVED > 0
	) AS V
), INVOICES AS (
	SELECT CASE WHEN D.SERVICEID IN ('CARECO','VBPCG') THEN 'CC_'||H.AGENCYID
	ELSE 	H.AGENCYID END AS AGENCYID , H.INVOICENUMBER, D.INVOICELINEID,D.SERVICEID, D.HCPCS, D.UNITTYPEID, D.DURATION, H.BILLCODE, D.DATEFROM, D.DATETHRU, 
		CA.CLIENTID, H.ADMISSIONID, CA.ADMISSIONTYPE, DATE_TRUNC(MONTH, D.DATEFROM) AS REPORT_MONTH,
		H.INVOICEDATE, H.STATUSID, H.STATUSCHANGEDATE, D.RATE, D.BILLEDAMOUNT, D.PAIDAMOUNT, D.NETAMOUNT,
		GREATEST(COALESCE(H.ETL_LAST_UPDATED_DATE, '1/1/1900'), COALESCE(D.ETL_LAST_UPDATED_DATE, '1/1/1900')) AS ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.SANDATAIMPORT.SANDATA_INVOICEHEADER H
	LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_INVOICEDETAILS D ON D.AGENCYID = H.AGENCYID AND D.INVOICENUMBER = H.INVOICENUMBER 
	LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS CA ON CA.AGENCYID = H.AGENCYID AND CA.ADMISSIONID = H.ADMISSIONID 
), CHANGED_DATA AS (
	-- Select changed data based on entire month, since invoice's datefrom/datethru can be a range of dates
	SELECT VISITS.AGENCYID, DATE_TRUNC(MONTH, VISITS.DATE) AS REPORT_MONTH, VISITS.CLIENTID, VISITS.ADMISSIONTYPE
	FROM VISITS AS VISITS
	WHERE VISITS.ETL_LAST_UPDATED_DATE >= '1900-01-01'
	UNION 
	SELECT INVOICES.AGENCYID, DATE_TRUNC(MONTH, INVOICES.DATEFROM) AS REPORT_MONTH, INVOICES.CLIENTID, INVOICES.ADMISSIONTYPE
	FROM INVOICES AS INVOICES
	WHERE INVOICES.ETL_LAST_UPDATED_DATE >= '1900-01-01'
),
EMPLOYEE AS 
(
	SELECT * FROM
	(
		SELECT STAFFAGENCYID, MASTER_ID, AGENCYID
		FROM DISC_DEDUPE_PROD.SANDATAIMPORT.EMPLOYEE_MASTER_LIST
        WHERE AGENCYID=8485
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT STAFFAGENCYID, MASTER_ID, AGENCYID
		FROM DISC_DEDUPE_PROD.SANDATAIMPORT.EMPLOYEE_MATCH_LIST
		WHERE STAFFAGENCYID NOT IN (SELECT STAFFAGENCYID FROM DISC_DEDUPE_PROD.SANDATAIMPORT.EMPLOYEE_MASTER_LIST ) 
        AND AGENCYID=8485
	) 
), CLIENT AS
(
	SELECT * FROM
	(
		SELECT CLIENTID, MASTER_ID, AGENCYID
		FROM DISC_DEDUPE_PROD.SANDATAIMPORT.CLIENT_MASTER_LIST
        WHERE AGENCYID=8485 
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT CLIENTID, MASTER_ID, AGENCYID
		FROM DISC_DEDUPE_PROD.SANDATAIMPORT.CLIENT_MATCH_LIST
		WHERE CLIENTID NOT IN (SELECT CLIENTID FROM DISC_DEDUPE_PROD.SANDATAIMPORT.CLIENT_MASTER_LIST ) 
        AND AGENCYID=8485
	))
SELECT --TOP 100
      MD5(inv.AGENCYID || '-' || TO_VARCHAR(COALESCE(dte.CALENDAR_DATE, '1/1/1900'), 'YYYYMMDD') || '-' || inv.INVOICELINEID || '-' || NVL(vs.VISIT_KEY, '-1') || '-'|| 'SANDATAIMPORT') AS REVENUE_KEY
FROM INVOICES INV
JOIN CHANGED_DATA CD
	ON CD.AGENCYID = INV.AGENCYID AND CD.CLIENTID = INV.CLIENTID AND CD.ADMISSIONTYPE = INV.ADMISSIONTYPE AND CD.REPORT_MONTH = INV.REPORT_MONTH
LEFT JOIN HAH.DIM_DATE dte
    ON inv.DATEFROM <= dte.CALENDAR_DATE AND inv.DATETHRU >= dte.CALENDAR_DATE
LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS cle
    ON inv.ADMISSIONID = cle.ADMISSIONID 
	AND CASE WHEN INV.SERVICEID IN ('CARECO','VBPCG') 
    THEN inv.AGENCYID = 'CC_'||cle.AGENCYID 
    ELSE inv.AGENCYID = cle.AGENCYID  END 
LEFT JOIN VISITS AS VS
	ON CASE WHEN INV.SERVICEID IN ('CARECO','VBPCG') THEN 
		VS.AGENCYID = 'CC_'||CLE.AGENCYID 
		ELSE VS.AGENCYID = CLE.AGENCYID END
	AND VS.CLIENTID = CLE.CLIENTID AND VS.ADMISSIONTYPE = CLE.ADMISSIONTYPE AND VS.DATE = DTE.CALENDAR_DATE
-- LEFT JOIN DISC_PROD.BI_Repository.EXTERNALIDS eid
--     ON cle.LocationId = eid.ExtID
--         AND eid.Typ = 'L'
--         AND eid.DBNAME = 'PA'
LEFT JOIN HAH.DIM_BRANCH BRANCH
    ON BRANCH.SYSTEM_CODE = cle.AGENCYID AND BRANCH.OFFICE_CODE = cle.LOCATIONID
--LEFT JOIN HAH.DIM_EMPLOYEE e
--	ON NVL(vs.STAFFAGENCYID,'-1') = e.EMPLOYEE_ID
--	AND nvl(inv.AGENCYID,'S') =e.SYSTEM_CODE
--    AND NVL(dte.CALENDAR_DATE, '1900-01-01') >= e.EFFECTIVE_FROM_DATE
--    AND NVL(dte.CALENDAR_DATE, '1900-01-01') < e.EFFECTIVE_TO_DATE
  LEFT JOIN EMPLOYEE STF ON INV.AGENCYID= STF.AGENCYID AND VS.STAFFAGENCYID = STF.STAFFAGENCYID
  LEFT JOIN CLIENT CL ON INV.AGENCYID= CL.AGENCYID AND CLE.CLIENTID =CL.CLIENTID
WHERE inv.AGENCYID  in ('8485','CC_8485');