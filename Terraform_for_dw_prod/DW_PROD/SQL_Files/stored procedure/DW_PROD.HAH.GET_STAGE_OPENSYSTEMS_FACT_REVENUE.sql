CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_OPENSYSTEMS_FACT_REVENUE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN 
--*****************************************************************************************************************************
-- NAME:  OPENSYSTEMS_FACT_REVENUE
--
-- PURPOSE: Creates One Row Per REVENUE According to OPENSYSTEMS
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   ---------------------------------------------------------------
-- 14/11/2022  Jay Prajapati         Initial Development
-- 24/11/2023	Preeti Sharma		 Added Bill_Unit_Type Column for RCM(Requested By Natalie)
--***************************************************************************************************************************

INSERT OVERWRITE INTO DW_PROD.STAGE.OPENSYSTEMS_FACT_REVENUE
WITH CLIENT AS
(
	SELECT * FROM
	(
		SELECT PATIENTID, MASTER_ID, OFFICEID
		FROM DISC_DEDUPE_PROD.HHAEXCHANGEOPENSYSTEMS.CLIENT_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT PATIENTID, MASTER_ID, OFFICEID
		FROM DISC_DEDUPE_PROD.HHAEXCHANGEOPENSYSTEMS.CLIENT_MATCH_LIST
		WHERE PATIENTID NOT IN (SELECT PATIENTID FROM DISC_DEDUPE_PROD.HHAEXCHANGEOPENSYSTEMS.CLIENT_MASTER_LIST )
	)
)
, EMPLOYEE AS
(
	SELECT * FROM
	(
		SELECT CAREGIVERID, MASTER_ID, OFFICEID
		FROM DISC_DEDUPE_PROD.HHAEXCHANGEOPENSYSTEMS.EMPLOYEE_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT CAREGIVERID, MASTER_ID, OFFICEID
		FROM DISC_DEDUPE_PROD.HHAEXCHANGEOPENSYSTEMS.EMPLOYEE_MATCH_LIST
		WHERE CAREGIVERID NOT IN (SELECT CAREGIVERID FROM DISC_DEDUPE_PROD.HHAEXCHANGEOPENSYSTEMS.EMPLOYEE_MASTER_LIST )
	)
)
, BILLING AS (
SELECT
DET.INVOICEDETAILID
	 , MIN(PT.INVOICEDATE) AS FIRST_INVOICE_DATE
	 , MAX(BV.DEPOSITDATE) AS FINAL_PAID_DATE
	 , SUM(BV.PAIDAMOUNT) AS PAID_AMOUNT
	 , SUM(BV.WRITEOFF) AS WRITEOFFAMOUNT
	 , SUM(BV.ADJUSTMENT+BV.TTADJUSTMENT+BV.OTHERADJUSTMENT) AS ADJUSTMENTS
	 , SUM(BV.CREDITS) AS CREDITS
FROM DISC_PROD.HHAEXCHANGEOPENSYSTEMS.TBLINVOICEDETAILS_REPL DET
LEFT JOIN DISC_PROD.HHAEXCHANGEOPENSYSTEMS.BILLING_PAIDVISITS_REPL BV ON BV.VISITID = DET.VISITID
AND BV.PATIENTID = DET.PATIENTID
LEFT JOIN DISC_PROD.HHAEXCHANGEOPENSYSTEMS.PAYMENTS PT ON PT.INVOICEDETAILID = DET.INVOICEDETAILID
GROUP BY DET.INVOICEDETAILID
)
, CONTRACTS AS (
	SELECT
		 SC.SERVICECODEID
		, SC.SERVICECODE
		, SC.CONTRACTID
		, CR.CONTRACTRATEID
		, IFNULL(C.STATE,PR.STATE) AS STATE
	FROM DISC_PROD.HHAEXCHANGEOPENSYSTEMS.SERVICECODES SC
	LEFT JOIN DISC_PROD.HHAEXCHANGEOPENSYSTEMS.PAYER_REPL PR ON IFNULL(PR.CONTRACTID,PR.PAYERID) = SC.CONTRACTID
	LEFT JOIN DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CONTRACTS C ON SC.CONTRACTID = C.CONTRACTID
	LEFT JOIN DISC_PROD.HHAEXCHANGEOPENSYSTEMS.CONTRACTRATES CR ON SC.SERVICECODEID = CR.SERVICECODEID
AND CR.TODATE :: DATE > GETDATE()
AND CR.FROMDATE :: DATE <= GETDATE()
)
SELECT
	 MD5(''OPENSYSTEMS'' || ''-'' || INV_HED.INVOICEHEADERID || ''-'' ||INV_DET.INVOICEDETAILID || ''-'' || ''HHAEXCHANGE'') AS REVENUE_KEY
	, DATE_TRUNC(DAY, INV_DET.VISITDATE::DATE) AS REPORT_DATE
	, MD5(''OPENSYSTEMS'' || ''-'' || OFFICE.OFFICEID || ''-'' || ''HHAEXCHANGE'') AS BRANCH_KEY
	, MD5(''OPENSYSTEMS'' || ''-'' || EMP.MASTER_ID || ''-'' || ''HHAEXCHANGE'') AS EMPLOYEE_KEY
	, MD5(''OPENSYSTEMS'' || ''-'' || CLI.MASTER_ID || ''-'' || ''HHAEXCHANGE'') AS CLIENT_KEY
	, MD5(''OPENSYSTEMS'' || ''-'' ||NVL(C.CONTRACTID,''-1'') || ''-'' || NVL(C.CONTRACTRATEID,-1) || ''-'' || NVL(C.SERVICECODEID,-1)|| ''-'' || ''HHAEXCHANGE'') AS CONTRACT_KEY
	, MD5(''OPENSYSTEMS'' || ''-'' || INV_HED.INVOICEHEADERID || ''-'' || ''HHAEXCHANGE'') AS INVOICE_KEY
	, 17 AS SOURCE_SYSTEM_ID
	, MD5(''OPENSYSTEMS'' || ''-'' || NVL(SUP.COORDINATORID,-1) || ''-'' || ''HHAEXCHANGE'') AS SUPERVISOR_KEY
	, DATE_TRUNC(DAY,COALESCE(BNG.FIRST_INVOICE_DATE,INV_DET.CREATEDDATE)::DATE) AS REVENUE_DATE
	, DATE_TRUNC(DAY,BNG.FINAL_PAID_DATE::DATE) AS PAYMENT_DATE
	, UPPER(TRIM(OFFICE.OFFICENAME)) AS BRANCH_NAME
	, NVL(EMP.CAREGIVERID, EMP.MASTER_ID) AS EMPLOYEE_ID
	, NVL(CLI.PATIENTID, CLI.MASTER_ID) AS CLIENT_NUMBER
	, C.CONTRACTID AS CONTRACT_CODE
	, INV_HED.VENDORINVOICENUMBER AS INVOICE_NUMBER
	, ''Regular'' AS INVOICE_TYPE
	, CASE WHEN INV_DET.INVRATETYPE =''Hourly'' THEN ''HOURLY''
           WHEN INV_DET.INVRATETYPE =''Daily'' THEN ''DAILY''
           WHEN INV_DET.INVRATETYPE =''Visit'' THEN ''VISIT''
      ELSE NULL END AS BILL_UNIT_TYPE
	, 1 AS NUMBER_OF_CLIENTS
	, CONCAT(''OPENSYSTEMS - '',TRIM(OFFICE.STATE)) AS SYSTEM_CODE
	, NVL(SUP.COORDINATORID,''-1'') AS SUPERVISOR_CODE
	, TRIM(C.SERVICECODE) AS BILL_CODE
	, NVL(ROUND(INV_DET.BILLEDHOURS/60,2) ,0) AS INVOICE_HOURS
	, INV_DET.BILLEDRATE AS INVOICE_RATE
	, NVL(INV_DET.BILLEDAMOUNT,0) AS AMOUNT_BILLED
	, NVL(BNG.PAID_AMOUNT,0) AS AMOUNT_COLLECTED
	, AMOUNT_BILLED - AMOUNT_COLLECTED AS AMOUNT_OUTSTANDING
	, :STR_ETL_TASK_KEY AS ETL_TASK_KEY 
	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
												 
	, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	, CURRENT_USER as ETL_INSERTED_BY
	, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_UPDATED_DATE
	, CURRENT_USER AS ETL_LAST_UPDATED_BY
	, 0 AS ETL_DELETED_FLAG
FROM DISC_PROD.HHAEXCHANGEOPENSYSTEMS.TBLINVOICEDETAILS_REPL INV_DET
INNER JOIN DISC_PROD.HHAEXCHANGEOPENSYSTEMS.TBLINVOICEHEADER_REPL INV_HED ON INV_DET.INVOICEHEADERID = INV_HED.INVOICEHEADERID
INNER JOIN CLIENT CLI ON INV_HED.PATIENTID = CLI.PATIENTID
INNER JOIN EMPLOYEE EMP ON INV_DET.CAREGIVERID = EMP.CAREGIVERID
INNER JOIN DISC_PROD.HHAEXCHANGEOPENSYSTEMS.OFFICE_OFFICES_REPL OFFICE ON INV_HED.OFFICEID = OFFICE.OFFICEID
LEFT JOIN BILLING BNG ON INV_DET.INVOICEDETAILID = BNG.INVOICEDETAILID
LEFT JOIN DISC_PROD.HHAEXCHANGEOPENSYSTEMS.TBLVISITS_REPL VISIT ON INV_DET.VISITID = VISIT.VISITID
LEFT JOIN DISC_PROD.HHAEXCHANGEOPENSYSTEMS.TBLCOORDINATOR_REPL SUP ON VISIT.COORDINATORID = SUP.COORDINATORID
LEFT JOIN CONTRACTS C ON INV_DET.INVSERVICECODEID = C.SERVICECODEID ;
RETURN ''SUCCESS'';
END;
';