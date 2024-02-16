resource "snowflake_procedure" "DW_HAH_GET_STAGE_EDISON_FACT_REVENUE" {
	name ="GET_STAGE_EDISON_FACT_REVENUE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

	   
						  
                BEGIN
--*****************************************************************************************************************************
-- NAME:  EDISON_FACT_REVENUE
--
-- PURPOSE: Creates one row per revenue according to EDISON
--
-- DEVELOPMENT LOG:
-- DATE        	AUTHOR                	NOTES:
-- --------    	-------------------   	-----------------------------------------------------------------------------------------------
-- 05/09/2022	Moin Saiyed          	Initial development
-- 08/09/2022   Mirisha Jarecha         Revised revenue category, subcategory logic
-- 15/03/2023 	Shikhar Saxena			Changes in branch key logic for Corporate branch
-- 24/11/2023	Preeti Sharma		    Added Bill_Unit_Type Column for RCM(Requested By Natalie)
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.EDISON_FACT_REVENUE
WITH EMPLOYEE AS
(
	SELECT * FROM
	(
		SELECT CAREGIVERID,MASTER_ID,CAREGIVERID AS ORIGINAL_RECORD_ID
		--,BRANCHID,OFFICEID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.EMPLOYEE_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT CAREGIVERID,MASTER_ID,CAREGIVERID AS ORIGINAL_RECORD_ID
		--,BRANCHID,OFFICEID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.EMPLOYEE_MATCH_LIST
		WHERE CAREGIVERID NOT IN (SELECT CAREGIVERID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.EMPLOYEE_MASTER_LIST )
	)
)
, CLIENT AS 
(
	SELECT * FROM
	(
		SELECT MD5((AGENCYID||''-''||MASTER_ID||''-''||''EDISON'' )) as CLIENT_KEY,
		PATIENTID,MASTER_ID,PATIENTID AS ORIGINAL_RECORD_ID,AGENCYID
		--,OFFICEID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CLIENT_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT MD5((AGENCYID||''-''||MASTER_ID||''-''||''EDISON'' )) as CLIENT_KEY,
		PATIENTID,MASTER_ID,PATIENTID AS ORIGINAL_RECORD_ID,AGENCYID
		--,OFFICEID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CLIENT_MATCH_LIST
		WHERE PATIENTID NOT IN (SELECT PATIENTID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CLIENT_MASTER_LIST )
	)
)
,VISIT_DATA AS
( SELECT DISTINCT VISITID,AGENCYID,CONTRACTID FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.VISITS WHERE AGENCYID = 155)
/*,
	MAXCOORDS AS
(
	SELECT
		PROVIDERCOORDINATORID,
		COORDINATORID,
		COORDINATORNAME,
		COORDINATORSRNO,
		AGENCYID,
		PATIENTID ,
		ROW_NUMBER() OVER (PARTITION BY PATIENTID,AGENCYID,
		COORDINATORSRNO
	ORDER BY
		CREATEDDATE DESC) RN
	FROM
		DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PROVIDERPATIENTCOORDINATORS
	WHERE
		AGENCYID = 155 
) */
,
	COORDINATOR AS
(
	SELECT
		P.PATIENTID,
		--ADMISSIONID,
		PC1.COORDINATORID AS COORDINATORID1,
		PC1.COORDINATORNAME AS COORDINATORNAME1
	FROM
		CLIENT P
	JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PROVIDERPATIENTCOORDINATORS PC1 ON
		P.PATIENTID = PC1.PATIENTID
		AND P.AGENCYID = PC1.AGENCYID
		AND PC1.COORDINATORSRNO = 1
		-- INNER JOIN DUE TO SOME DATA ARE ORPHAN IN CLIENT
	WHERE
		P.AGENCYID = 155
)
, PAYMENT_DATA1
AS 
(
	SELECT 
PAYMENTS.INVOICEDETAILID 
,MIN(PAYMENTS.INVOICEDATE) AS INVOICEDATE
,MAX(PAYMENTS.PAIDDATE) AS PAIDDATE
,SUM(BILLEDAMOUNT) AS BILLEDAMOUNT
,SUM(NVL(PAYMENTS.PAIDAMOUNT, 0) + NVL(PAYMENTS.ADJUSTMENT, 0) + NVL(PAYMENTS.TTADJUSTMENT, 0) + NVL(PAYMENTS.WRITEOFF, 0) + NVL(PAYMENTS.OTHERADJUSTMENT, 0))  AS PAIDAMOUNT
FROM 
DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PAYMENTS PAYMENTS
WHERE AGENCYID = 155
GROUP BY PAYMENTS.INVOICEDETAILID
)
, PAYMENT_DATA2
AS
(
	SELECT VISITID
,PAYERID,SUM(NVL(PAIDAMOUNT, 0) + NVL(ADJUSTMENT, 0) + NVL(TTADJUSTMENT, 0) + NVL(WRITEOFF, 0) + NVL(OTHERADJUSTMENT, 0))
 AS PAIDAMOUNT FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.BILLING_PAIDVISITS_REPL 
	GROUP BY VISITID,PAYERID 
	--ON INVOICE.VISITID = PR.VISITID AND INVOICE.PAYERID = PR.PAYERID 
)
, EDISON_REVENUE_SEG AS
(
   	SELECT VISITID, REVENUE_CATEGORY, REVENUE_SUBCATEGORY_NAME, REVENUE_SUBCATEGORY_CODE 
	FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.VW_EDISON_REVENUE_SEG
	GROUP BY VISITID, REVENUE_CATEGORY, REVENUE_SUBCATEGORY_NAME, REVENUE_SUBCATEGORY_CODE
)
SELECT	DISTINCT
		MD5(''EDISON'' ||''-''|| INVOICE.InvoiceDetailID ||''-''|| INVOICE.VISITID ||''-''|| ''EDISON'') AS REVENUE_KEY
		,DATE_TRUNC (DAY,VISITS.VISITDATE) AS REPORT_DATE
		,MD5(''EDISON'' || ''-'' || ''EDISON CORPORATE OFFICE'' || ''-'' || ''EDISON'') AS BRANCH_KEY
		,DE.EMPLOYEE_KEY AS EMPLOYEE_KEY
		,DC.CLIENT_KEY AS CLIENT_KEY
		,MD5(VISITS.AGENCYID || ''-'' || NVL(SC.CONTRACTID,-1) || ''-'' || NVL(CR.CONTRACTRATEID, -1) || ''-'' || NVL(SC.SERVICECODEID, -1) || ''-'' || 
		NVL(RS.REVENUE_SUBCATEGORY_CODE, ''UNKNOWN'') ||''EDISON'') AS CONTRACT_KEY
		,MD5(''EDISON'' || ''-'' || INV_HEAD.AGENCYID || ''-'' || INV_HEAD.INVOICEHEADERID || ''-'' || ''EDISON'') AS INVOICE_KEY
		,17 AS SOURCE_SYSTEM_ID
		,MD5(''EDISON'' || ''-'' || VISITS.AGENCYID || ''-'' || NVL(COORDINATOR.COORDINATORID1,-1) || ''-'' || ''EDISON'') AS SUPERVISOR_KEY
		,DATE_TRUNC(DAY,(COALESCE(PAYMENTS.INVOICEDATE,INVOICE.CREATEDDATE))) AS REVENUE_DATE -- NEED TO CONFIRM WITH DAVID
		,DATE_TRUNC(DAY,PAYMENTS.PAIDDATE) AS PAYMENT_DATE -- NEED TO CONFIRM WITH DAVID AFTER PAYMENT TABLE CONFIRMATION DATE_TRUNC(DAY,PAYMENTS.PAIDDATE)
		,''EDISON CORPORATE OFFICE'' AS BRANCH_NAME
		,TO_NUMBER(DE.EMPLOYEE_ID) AS EMPLOYEE_ID
		,DC.CLIENT_NUMBER AS CLIENT_NUMBER
		,NVL(TO_VARCHAR(SC.CONTRACTID), ''Unknown'') AS CONTRACT_CODE
		,INV_HEAD.VENDORINVOICENUMBER AS INVOICE_NUMBER
		,''Regular'' AS INVOICE_TYPE --NEED TO CONFIRM
		,CASE WHEN INVOICE.INVRATETYPE =''Hourly'' THEN ''HOURLY''
	 		  WHEN INVOICE.INVRATETYPE = ''Daily'' THEN ''DAILY''
	 		  WHEN INVOICE.INVRATETYPE = ''Visit'' THEN ''VISIT''
	     END AS BILL_UNIT_TYPE
		,1 AS NUMBER_OF_CLIENTS --NEED TO CONFIRM
		,''EDISON'' AS SYSTEM_CODE
		,VISITS.COORDINATORID AS SUPERVISOR_CODE 
		,NVL(TO_VARCHAR(SC.SERVICECODE), ''Unknown'') AS BILL_CODE --NEED TO CONFIRM THIS COLUMN IS OKAY OR NEED TO TAKE ANOTHER COLUMN?--VISITS.INVSERVICECODEID/SERVICECODE.SERVICECODE?--SERVICECODE.SERVICECODE have too long strings
		--,(INVOICE.BILLEDHOURS/60) AS INVOICE_HOURS
		/*
        ,CASE 
            WHEN CHARINDEX(''T1020'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VISITS.VISITSTARTTIME, VISITS.VISITENDTIME)/60.0,0) > 13 THEN 13
            WHEN CHARINDEX(''S5126'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VISITS.VISITSTARTTIME, VISITS.VISITENDTIME)/60.0,0) > 13 THEN 13
            WHEN CHARINDEX(''S5151'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VISITS.VISITSTARTTIME, VISITS.VISITENDTIME)/60.0,0) > 13 THEN 13
             WHEN CHARINDEX(''PCA LEVEL II LIVE IN 263200'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VISITS.VISITSTARTTIME, VISITS.VISITENDTIME)/60.0,0) > 13 THEN 13
            WHEN CHARINDEX(''HHA LIVE IN'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VISITS.VISITSTARTTIME, VISITS.VISITENDTIME)/60.0,0) > 13 THEN 13
            WHEN CHARINDEX(''C LIVE IN'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VISITS.VISITSTARTTIME, VISITS.VISITENDTIME)/60.0,0) > 13 THEN 13
            WHEN CHARINDEX(''PCA LIVE-IN'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VISITS.VISITSTARTTIME, VISITS.VISITENDTIME)/60.0,0) > 13 THEN 13
            WHEN CHARINDEX(''HHA LIVE-IN OVERTIME'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VISITS.VISITSTARTTIME, VISITS.VISITENDTIME)/60.0,0) > 13 THEN 13
            WHEN CHARINDEX(''2405004 LIVE IN'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VISITS.VISITSTARTTIME, VISITS.VISITENDTIME)/60.0,0) > 13 THEN 13
             ELSE
                    IFNULL(DATEDIFF("MI",VISITS.VISITSTARTTIME, VISITS.VISITENDTIME)/60.0,0)
                                                                                END AS PAIDHOURS
		*/
        , NVL(ROUND(INVOICE.BILLEDHOURS / 60.00, 2), 0.00) AS INVOICE_HOURS 
        ,INVOICE.BILLEDRATE AS INVOICE_RATE
		, COALESCE(INVOICE.BILLEDAMOUNT, 0) AS AMOUNT_BILLED
		, COALESCE(PR.PAIDAMOUNT,PAYMENTS.PAIDAMOUNT,0) AS AMOUNT_COLLECTED--NVL(PAYMENTS.PAIDAMOUNT, 0) + NVL(PAYMENTS.ADJUSTMENT, 0) + NVL(PAYMENTS.TTADJUSTMENT, 0) + NVL(PAYMENTS.WRITEOFF, 0) + NVL(PAYMENTS.OTHERADJUSTMENT, 0) AS AMOUNT_COLLECTED
		, NVL((AMOUNT_BILLED - AMOUNT_COLLECTED),0) AS AMOUNT_OUTSTANDING,--CASE INVOICE.VISITPAYMENTSTATUS WHEN 1 THEN NVL(INVOICE.BILLEDAMOUNT, 0) ELSE 0 END AS AMOUNT_OUTSTANDING,
		 -- AS PER DAVID NEED TO TAKE DATA FROM tblinvoicedetails_REPL NOT FROM PAYMENT, AS PER OLD STRUCTURE FROM PAYMENT TABLE AMOUNT_BILLED - (AMOUNT_COLLECTED + (SUM(NVL(PAYMENTS.ADJUSTMENT, 0) + NVL(PAYMENTS.TTADJUSTMENT, 0) + NVL(PAYMENTS.WRITEOFF, 0) + NVL(PAYMENTS.OTHERADJUSTMENT, 0))))
		-- ETL Fields
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
                        
  		, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	    , CURRENT_USER as ETL_INSERTED_BY
	    , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_UPDATED_DATE
	    , CURRENT_USER AS ETL_LAST_UPDATED_BY
	    , 0 AS ETL_DELETED_FLAG
	FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.tblinvoicedetails_REPL INVOICE
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.OFFICE_OFFICES_REPL O ON O.OFFICEID = INVOICE.OFFICEID
	INNER JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.TBLINVOICEHEADER_REPL INV_HEAD
	ON INVOICE.INVOICEHEADERID = INV_HEAD.INVOICEHEADERID
	INNER JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.tblVisits_REPL VISITS ON INVOICE.VISITID = VISITS.VISITID --INNER JOIN DUE TO THERE 8 VISIT ID IN tblinvoicedetails_REPL BUT NOT IN VisitContracts_REPL
        AND VISITS.PAYERID = INVOICE.PAYERID
INNER JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.VISITS VS
	ON VS.VISITID = VISITS.VISITID 
		--AND VS.PAYERID = INVOICE.PAYERID	
INNER JOIN EMPLOYEE E ON INVOICE.CAREGIVERID = E.CAREGIVERID --INNER JOIN DUE TO THERE 3882 CAREGIVERID IN tblinvoicedetails_REPL BUT NOT IN EMPLOYEE -- need TO ask dedupe team / david
INNER JOIN HAH.DIM_EMPLOYEE DE ON TO_NUMBER(DE.EMPLOYEE_ID) = E.MASTER_ID AND DE.SYSTEM_CODE = ''EDISON''	
INNER JOIN CLIENT C ON INVOICE.PATIENTID = C.PATIENTID
	INNER JOIN HAH.DIM_CLIENT DC ON  
  DC.CLIENT_KEY = C.CLIENT_KEY
	AND DC.SYSTEM_CODE = ''EDISON''								
	LEFT JOIN PAYMENT_DATA2 PR ON INVOICE.VISITID = PR.VISITID AND INVOICE.PAYERID = PR.PAYERID 
	LEFT JOIN PAYMENT_DATA1 PAYMENTS ON INVOICE.INVOICEDETAILID  = PAYMENTS.INVOICEDETAILID 
	JOIN VISIT_DATA V ON VISITS.VISITID = V.VISITID AND VISITS.AGENCYID = V.AGENCYID
	JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.VISITINFO_REPL VINFO
ON
		VISITS.VISITID = VINFO.VISITID
		AND VISITS.AGENCYID = VINFO.AGENCYID
	LEFT JOIN COORDINATOR
ON
		C.PATIENTID = COORDINATOR.PATIENTID
	INNER JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.SERVICECODES SC 
ON
		INVOICE.INVSERVICECODEID = SC.SERVICECODEID
		AND SC.AGENCYID = VISITS.AGENCYID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CONTRACTRATES CR
ON
		SC.CONTRACTID = CR.CONTRACTID
		AND SC.AGENCYID = CR.AGENCYID
		AND SC.SERVICECODEID = CR.SERVICECODEID
		AND CR.TODATE::DATE > GETDATE()
		AND CR.FROMDATE::DATE <= GETDATE()
LEFT JOIN EDISON_REVENUE_SEG RS
		ON RS.VISITID = VISITS.VISITID
WHERE INVOICE.AGENCYID  = 155
;
    RETURN ''SUCCESS'';

						 
    END;
    
 EOT
}

