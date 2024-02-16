create or replace view DW_PROD.STAGE.SANDATAIMPORT_FACT_REVENUE_TEMP_VIEW(
	OLD_REVENUE_KEY,
	NEW_REVENUE_KEY,
	OLD_CONTRACT_KEY,
	NEW_CONTRACT_KEY,
	OLD_INVOICE_KEY,
	NEW_INVOICE_KEY,
	OLD_SYSTEM_CODE,
	NEW_SYSTEM_CODE
) as
WITH VISITS AS (
	SELECT V.VISIT_KEY, V.SYSTEM_CODE AS AGENCYID, V.SERVICE_DATE AS DATE,V.SERVICEID, V.CLIENT_NUMBER AS CLIENTID, V.CONTRACT_CODE AS ADMISSIONTYPE, V.OFFICE_CODE, V.BRANCH_NAME, V.EMPLOYEE_ID AS STAFFAGENCYID,
		DIV0(V.HOURS_SERVED , SUM(V.HOURS_SERVED) OVER (PARTITION BY V.SYSTEM_CODE, V.CLIENT_NUMBER, V.CONTRACT_CODE, V.SERVICE_DATE)) AS RATIO_DURATION,
		V.ETL_LAST_UPDATED_DATE
	FROM (
		SELECT V.VISIT_KEY,CASE WHEN V.BILL_CODE IN ('VBPCG') THEN 'CC_'||V.SYSTEM_CODE ELSE V.SYSTEM_CODE  END AS SYSTEM_CODE, B.OFFICE_CODE, V.BILL_CODE AS SERVICEID, B.OFFICE_NUMBER, B.BRANCH_NAME, V.CLIENT_NUMBER, V.CONTRACT_CODE, V.SERVICE_DATE, V.EMPLOYEE_ID, V.HOURS_SERVED, V.ETL_LAST_UPDATED_DATE
		FROM DW_PROD.HAH.FACT_VISIT V
		LEFT JOIN DW_PROD.HAH.DIM_BRANCH B ON B.BRANCH_KEY = V.BRANCH_KEY
		WHERE V.SOURCE_SYSTEM_ID = 4 AND V.CONFIRMED_FLAG='YES'
		--AND V.STATUS_CODE IN ('02', '03', '04') /* Confirmed Visits */ 
		AND V.HOURS_SERVED > 0				
	) AS V
), INVOICES AS (
	SELECT CASE WHEN D.SERVICEID IN ('VBPCG') THEN 'CC_'||H.AGENCYID
	ELSE 	H.AGENCYID END AS AGENCYID , H.INVOICENUMBER, D.INVOICELINEID,D.SERVICEID, D.HCPCS, D.UNITTYPEID, D.DURATION, H.BILLCODE, D.DATEFROM, D.DATETHRU, 
		CA.CLIENTID, H.ADMISSIONID, CA.ADMISSIONTYPE, DATE_TRUNC(MONTH, D.DATEFROM) AS REPORT_MONTH,
		H.INVOICEDATE, H.STATUSID, H.STATUSCHANGEDATE, D.RATE, D.BILLEDAMOUNT, D.PAIDAMOUNT, D.NETAMOUNT AS NETAMOUNT_OLD, -- MODIFIED ON 0401
SUM(D.BILLEDAMOUNT) OVER (PARTITION BY H.INVOICENUMBER ORDER BY H.INVOICENUMBER) AS TOTALBILLED, -- ADDED BY PJSHAH ON 19/12
		GREATEST(COALESCE(H.ETL_LAST_UPDATED_DATE, '1/1/1900'), COALESCE(D.ETL_LAST_UPDATED_DATE, '1/1/1900')) AS ETL_LAST_UPDATED_DATE
--	,SUM(CASE WHEN NVL(D.PAIDAMOUNT,0) <> NVL(ABS(PM.PAYMENTAMOUNT),0) THEN (NVL(D.BILLEDAMOUNT,0)-NVL(ABS(PM.PAYMENTAMOUNT),0))  ELSE D.NETAMOUNT END )
--	 OVER (PARTITION BY H.INVOICENUMBER ORDER BY H.INVOICENUMBER) AS NETAMOUNT -- ADDED ON 0401
	,CASE  D.UNITTYPEID WHEN '01' THEN 
                              SUM(CASE WHEN NVL(ABS(D.PAIDAMOUNT),0) <> NVL(ABS(PM.PAYMENTAMOUNT),0) AND NVL((PM.PAYMENTAMOUNT),0)<>0 THEN (NVL(D.BILLEDAMOUNT,0)-NVL((PM.PAYMENTAMOUNT),0))  
                                     -- WHEN NVL(ABS(D.PAIDAMOUNT),0) > NVL(ABS(PM.PAYMENTAMOUNT),0) AND NVL((PM.PAYMENTAMOUNT),0)<>0 THEN (NVL(D.BILLEDAMOUNT,0)-NVL((D.PAIDAMOUNT),0))    
                            ELSE D.NETAMOUNT END )
                             OVER (PARTITION BY H.INVOICENUMBER ORDER BY H.INVOICENUMBER) 
     ELSE 
      SUM(CASE WHEN NVL(ABS(D.PAIDAMOUNT),0) <> NVL(ABS(PM.PAYMENTAMOUNT),0) AND NVL((PM.PAYMENTAMOUNT),0)<>0 THEN (NVL(D.BILLEDAMOUNT,0)-NVL((PM.PAYMENTAMOUNT),0))  
             -- WHEN NVL(ABS(D.PAIDAMOUNT),0) > NVL(ABS(PM.PAYMENTAMOUNT),0) AND NVL((PM.PAYMENTAMOUNT),0)<>0 THEN (NVL(D.BILLEDAMOUNT,0)-NVL((D.PAIDAMOUNT),0))    
    ELSE (D.NETAMOUNT)  END )
     OVER (PARTITION BY H.INVOICENUMBER ORDER BY H.INVOICENUMBER) 
     END
 	AS NETAMOUNT  --Changed on 31/01/23
	FROM DISC_PROD.SANDATAIMPORT.SANDATA_INVOICEHEADER H
	LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_INVOICEDETAILS D ON D.AGENCYID = H.AGENCYID AND D.INVOICENUMBER = H.INVOICENUMBER 
	LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS CA ON CA.AGENCYID = H.AGENCYID AND CA.ADMISSIONID = H.ADMISSIONID 
	LEFT JOIN (SELECT INVOICEDETAILID, SUM(PAYMENTAMOUNT) AS PAYMENTAMOUNT FROM DISC_PROD.SANDATAIMPORT.SANDATA_PAYMENTDETAILS GROUP BY INVOICEDETAILID)	PM 
	ON PM.INVOICEDETAILID =D.INVOICELINEID --7666239
	WHERE H.AGENCYID = 8485
), CHANGED_DATA AS (
	-- Select changed data based on entire month, since invoice's datefrom/datethru can be a range of dates
	SELECT VISITS.AGENCYID, DATE_TRUNC(MONTH, VISITS.DATE) AS REPORT_MONTH, VISITS.CLIENTID, VISITS.ADMISSIONTYPE 
	FROM VISITS AS VISITS
	
	UNION 
	SELECT INVOICES.AGENCYID, DATE_TRUNC(MONTH, INVOICES.DATEFROM) AS REPORT_MONTH, INVOICES.CLIENTID, INVOICES.ADMISSIONTYPE 
	FROM INVOICES AS INVOICES
	
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
SELECT 

 

MD5('8485' || '-' || TO_VARCHAR(COALESCE(dte.CALENDAR_DATE, '1/1/1900'), 'YYYYMMDD') || '-' || inv.INVOICELINEID || '-' || NVL(vs.VISIT_KEY, '-1') || '-'|| 'SANDATAIMPORT') OLD_REVENUE_KEY,

CASE WHEN INV.SERVICEID in ('VBPCG')
THEN 
MD5(inv.AGENCYID || '-' || TO_VARCHAR(COALESCE(dte.CALENDAR_DATE, '1/1/1900'), 'YYYYMMDD') || '-' || inv.INVOICELINEID || '-' || NVL(vs.VISIT_KEY, '-1') || '-'|| 'SANDATAIMPORT') 
ELSE  
MD5('8485' || '-' || TO_VARCHAR(COALESCE(dte.CALENDAR_DATE, '1/1/1900'), 'YYYYMMDD') || '-' || inv.INVOICELINEID || '-' || NVL(vs.VISIT_KEY, '-1') || '-'|| 'SANDATAIMPORT')
END AS NEW_REVENUE_KEY,
	
md5(nvl('8485','S') || '-' || NVL(cle.ADMISSIONTYPE,'Unknown') || '-'  ||  'SANDATAIMPORT') AS OLD_CONTRACT_KEY,
	 
CASE WHEN INV.SERVICEID in ('VBPCG')
THEN md5(nvl(inv.AGENCYID,'S') || '-' || NVL(cle.ADMISSIONTYPE,'Unknown') || '-'  ||  'SANDATAIMPORT')
ELSE md5(nvl('8485','S') || '-' || NVL(cle.ADMISSIONTYPE,'Unknown') || '-'  ||  'SANDATAIMPORT') END  AS NEW_CONTRACT_KEY,
      
md5(nvl('8485','S') ||'-'|| coalesce(inv.INVOICENUMBER,'-1') ||'-'|| 'SANDATAIMPORT') AS OLD_INVOICE_KEY,
	  
CASE WHEN INV.SERVICEID in ('VBPCG')
THEN md5(nvl(inv.AGENCYID,'S') ||'-'|| coalesce(inv.INVOICENUMBER,'-1') ||'-'|| 'SANDATAIMPORT')
ELSE md5(nvl('8485','S') ||'-'|| coalesce(inv.INVOICENUMBER,'-1') ||'-'|| 'SANDATAIMPORT') END AS NEW_INVOICE_KEY,
     
'8485' AS OLD_SYSTEM_CODE,
	 
CASE WHEN INV.SERVICEID in ('VBPCG')
	  THEN inv.AGENCYID 
	  ELSE '8485' END AS NEW_SYSTEM_CODE
     
	 
FROM INVOICES INV
JOIN CHANGED_DATA CD
	ON CD.AGENCYID = INV.AGENCYID AND CD.CLIENTID = INV.CLIENTID AND CD.ADMISSIONTYPE = INV.ADMISSIONTYPE AND CD.REPORT_MONTH = INV.REPORT_MONTH
LEFT JOIN DW_PROD.HAH.DIM_DATE dte
    ON inv.DATEFROM <= dte.CALENDAR_DATE AND inv.DATETHRU >= dte.CALENDAR_DATE
LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS cle
    ON inv.ADMISSIONID = cle.ADMISSIONID 
	AND CASE WHEN INV.SERVICEID in ('VBPCG') 
    THEN inv.AGENCYID = 'CC_'||cle.AGENCYID 
    ELSE inv.AGENCYID = cle.AGENCYID  END 
LEFT JOIN VISITS AS VS
	ON CASE WHEN INV.SERVICEID in ('VBPCG') THEN 
		VS.AGENCYID = 'CC_'||CLE.AGENCYID 
		ELSE VS.AGENCYID = CLE.AGENCYID END
	AND VS.CLIENTID = CLE.CLIENTID AND VS.ADMISSIONTYPE = CLE.ADMISSIONTYPE AND VS.DATE = DTE.CALENDAR_DATE

LEFT JOIN DW_PROD.HAH.DIM_BRANCH BRANCH
    ON BRANCH.SYSTEM_CODE = cle.AGENCYID AND BRANCH.OFFICE_CODE = cle.LOCATIONID

  LEFT JOIN EMPLOYEE STF ON INV.AGENCYID= STF.AGENCYID AND VS.STAFFAGENCYID = STF.STAFFAGENCYID
    LEFT JOIN CLIENT CL ON INV.AGENCYID= CL.AGENCYID AND CLE.CLIENTID =CL.CLIENTID
WHERE inv.AGENCYID in ('VBPCG');