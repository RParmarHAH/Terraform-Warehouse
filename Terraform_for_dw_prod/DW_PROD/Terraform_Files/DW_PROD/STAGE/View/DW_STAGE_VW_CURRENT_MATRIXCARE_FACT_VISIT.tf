resource "snowflake_view" "DW_STAGE_VW_CURRENT_MATRIXCARE_FACT_VISIT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_MATRIXCARE_FACT_VISIT"
	statement = <<-SQL
	 
WITH SCHEDULE_PAYERS AS
	(
	SELECT DISTINCT SCHCP_SCHEDULEID
	,FIRST_VALUE(SCHCP_PAYERID) OVER (PARTITION BY SCHCP_SCHEDULEID ORDER BY SCHCP_SEQNO,SCHCP_ID) SCHCP_PAYERID
	,MAX(COALESCE(ETL_LAST_UPDATED_DATE, '1/1/1900')) OVER (PARTITION BY SCHCP_SCHEDULEID) ETL_LAST_UPDATED_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULEPAYERS 
	)
, CLIENT_PAYERS AS
	(
		SELECT DISTINCT CLIPAY_CLIENTID
		,FIRST_VALUE(CLIPAY_PAYERID) OVER (PARTITION BY CLIPAY_CLIENTID ORDER BY CLIPAY_SEQNO DESC) CLIPAY_PAYERID
		,FIRST_VALUE(COALESCE(ETL_LAST_UPDATED_DATE, '1/1/1900')) OVER (PARTITION BY CLIPAY_CLIENTID ORDER BY CLIPAY_SEQNO DESC) ETL_LAST_UPDATED_DATE
		FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CLIENTPAYERS 
	)
, PAYER_BRANCH AS
	(
			 SELECT  DISTINCT PAYBR_BRANCH_ID 
			,FIRST_VALUE(PAYBR_PAYERID) OVER (PARTITION BY PAYBR_BRANCH_ID ORDER BY PAYBR_CREATEDDATE DESC) PAYBR_PAYERID
			,FIRST_VALUE(COALESCE(ETL_LAST_UPDATED_DATE, '1/1/1900')) OVER (PARTITION BY PAYBR_BRANCH_ID ORDER BY PAYBR_CREATEDDATE DESC) ETL_LAST_UPDATED_DATE
			FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_PAYERBRANCHES 
	) 	
, INVOICE_PAYERS AS
	(	
		SELECT DISTINCT INVD_SCHEDULEID --,INH.INVH_ID AS INVH_ID
		,FIRST_VALUE(INH.INVH_ID) OVER(PARTITION BY INVD_SCHEDULEID ORDER BY INVH_INVOICEDATE DESC) INVH_ID
		,FIRST_VALUE(INVD_SCHEDULEPAYERID) OVER(PARTITION BY INVD_SCHEDULEID ORDER BY INVH_INVOICEDATE DESC) INV_PAYERID
		,FIRST_VALUE(INH.ETL_LAST_UPDATED_DATE) OVER(PARTITION BY INVD_SCHEDULEID ORDER BY INVH_INVOICEDATE DESC) ETL_LAST_UPDATED_DATE
		FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEHEADER INH 
	 	JOIN  DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEDETAILS IND ON INH.INVH_ID = IND.INVD_INVHID 
	)
, BILL_RATES AS
	(
		SELECT * FROM 
		(
		SELECT SCHEDULEID,starttime, endtime, unittype,units,actualrate
		,ROW_NUMBER() OVER (PARTITION  BY SCHEDULEID ORDER BY RBS_ID DESC) AS ROWRBS_ID 
		,MAX(COALESCE(ETL_LAST_UPDATED_DATE, '1/1/1900')) OVER (PARTITION  BY SCHEDULEID ORDER BY RBS_ID DESC)  ETL_LAST_UPDATED_DATE
		FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_RATEBILLSHIFTS 
		) WHERE ROWRBS_ID =1
	)
, INVOICE_DETAILS AS 
	(
		SELECT INVOICE_DETAILS.INVD_INVHID AS INVH_ID, 
		SUM(NVL(INVOICE_DETAILS.INVD_TOTALCHARGES, 0) + NVL(INVOICE_DETAILS.INVD_TOTALREVADJUSTMENTS, 0)) AS AMOUNT_BILLED,
		SUM(INVOICE_DETAILS.INVD_TOTALPAYMENTS * -1) AS AMOUNT_COLLECTED, -- Payments are in negative amounts 
		SUM(INVOICE_DETAILS.INVD_BALANCE) AS AMOUNT_OUTSTANDING,
		MAX(PAYMENT_POSTING.POST_POSTEDDATE) AS FINAL_PAYMENT_DATE,
		MAX(GREATEST(NVL(INVOICE_DETAILS.ETL_LAST_UPDATED_DATE, '1/1/1900'),
				NVL(PAYMENT_POSTING.ETL_LAST_UPDATED_DATE, '1/1/1900'))) AS ETL_LAST_UPDATED_DATE
		FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEDETAILS AS INVOICE_DETAILS
		LEFT JOIN (
			SELECT POST_INVOICEDETAILID, MAX(POST_POSTEDDATE) AS POST_POSTEDDATE, MAX(ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
			FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_PAYMENTPOSTING
			GROUP BY POST_INVOICEDETAILID
		) AS PAYMENT_POSTING
		ON PAYMENT_POSTING.POST_INVOICEDETAILID = INVOICE_DETAILS.INVD_ID 
		GROUP BY INVOICE_DETAILS.INVD_INVHID
	)
	, TEMP_INVOICE_STATUS AS
	(
		SELECT  SCH.SCH_ID,CASE WHEN INVOICE_HEADER.INVH_CANCELDATE IS NOT NULL THEN 'Cancelled'
			WHEN INVOICE_DETAILS.AMOUNT_COLLECTED >= INVOICE_DETAILS.AMOUNT_BILLED THEN 'Paid'
			WHEN INVOICE_DETAILS.AMOUNT_COLLECTED > 0 THEN 'Partially Paid'
			WHEN INVOICE_DETAILS.AMOUNT_BILLED > 0 THEN 'Billed'
			WHEN NVL(INVOICE_DETAILS.AMOUNT_BILLED, 0) = 0 THEN 'Unbilled'
			ELSE NULL END AS INVOICE_STATUS_NAME
			--,MD5(7  || '-' ||'MATRIXCARE' || '-' || INVOICE_STATUS_NAME) AS VISIT_STATUS_KEY			
			FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULES AS SCH
			LEFT JOIN INVOICE_PAYERS INV ON INV.INVD_SCHEDULEID = SCH.SCH_ID
			LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEHEADER AS INVOICE_HEADER ON INVOICE_HEADER.INVH_ID = INV.INVH_ID
			LEFT JOIN INVOICE_DETAILS AS INVOICE_DETAILS ON INVOICE_DETAILS.INVH_ID = INVOICE_HEADER.INVH_ID			
	)
	,DERIVED_STATUS AS 
		(
			SELECT DISTINCT SCH.SCH_ID
			,CASE WHEN SCHSTATUS.SCHST_NAME IN ('NTS','NTS_') THEN 'NTS' ELSE SCHSTATUS.SCHST_NAME END AS DISC_VISIT_CODE
			,CASE WHEN SCHSTATUS.SCHST_NAME = 'C' THEN 'Completed'
			WHEN SCHSTATUS.SCHST_NAME = 'COR' THEN 'Needs Correction'
			WHEN SCHSTATUS.SCHST_NAME = 'CV-19' THEN 'Covid-19 Hold or Cancel'
			WHEN SCHSTATUS.SCHST_NAME = 'DD-AV' THEN 'DD Annual Visit'
			WHEN SCHSTATUS.SCHST_NAME = 'DD-QV' THEN 'DD Quarterly Visit'
			WHEN SCHSTATUS.SCHST_NAME = 'H' THEN 'Hospitalization' 
			WHEN SCHSTATUS.SCHST_NAME = 'R' THEN 'Refused'
			WHEN SCHSTATUS.SCHST_NAME = 'S' THEN 'Scheduled'
			WHEN SCHSTATUS.SCHST_NAME = 'NS' THEN 'Caregiver No Show' 
			WHEN SCHSTATUS.SCHST_NAME = 'T' THEN 'Telephony Completed' 
			WHEN SCHSTATUS.SCHST_NAME = 'AVAIL' THEN 'Available Hours' 	
	   		WHEN SCHSTATUS.SCHST_NAME = 'HOLD' THEN 'On Hold- Misc Reason' 
		   WHEN SCHSTATUS.SCHST_NAME = 'OPEN' THEN 'Open Shift'
		   WHEN SCHSTATUS.SCHST_NAME = 'XCG' THEN 'Cancelled by caregiver'
		   WHEN SCHSTATUS.SCHST_NAME = 'XC' THEN 'Cancelled by client'
		   WHEN SCHSTATUS.SCHST_NAME = 'XO' THEN 'Cancelled no staff'
   		   WHEN SCHSTATUS.SCHST_NAME = 'XX' THEN 'Delete Shift'
   		   WHEN SCHSTATUS.SCHST_NAME IN ('NTS','NTS_') THEN 'No Time Sheet'
   		   WHEN SCHSTATUS.SCHST_NAME = 'TCOR' THEN 'Telephony Needs Correction'
   		   WHEN SCHSTATUS.SCHST_NAME = 'TH' THEN 'Telehealth' 
		   ELSE NULL END AS DISC_VISIT_STATUS
			,INVS.INVOICE_STATUS_NAME AS DISC_INVOICE_STATUS
			,CASE WHEN DISC_VISIT_STATUS ='Scheduled' AND SCH.SCH_CAREGIVERID IS NULL AND SCH.SCH_STARTTIME > CURRENT_DATE() THEN '01OPENFUTURE' 
			WHEN DISC_VISIT_STATUS ='Scheduled' AND SCH.SCH_CAREGIVERID IS NOT NULL AND SCH.SCH_STARTTIME > CURRENT_DATE() THEN '01FUTURE'
			WHEN DISC_VISIT_STATUS ='Scheduled' AND SCH.SCH_CAREGIVERID IS NULL AND SCH.SCH_STARTTIME <= CURRENT_DATE() THEN '01OPEN' 
			WHEN DISC_VISIT_STATUS ='Scheduled' AND SCH.SCH_CAREGIVERID IS NOT NULL AND SCH.SCH_STARTTIME <= CURRENT_DATE() THEN 'Scheduled' 
			ELSE DISC_VISIT_STATUS END AS DERIVED_DISC_STATUS
			,MD5(7  || '-' ||'MATRIXCARE' || '-' || NVL(DERIVED_DISC_STATUS,'S') || '-' || NVL(DISC_INVOICE_STATUS,'S')) AS VISIT_STATUS_KEY
			FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULES AS SCH
			LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULESTATUS AS SCHSTATUS 
			ON SCH.SCH_SCHEDULESTATUSID = SCHSTATUS.SCHST_ID
			LEFT JOIN TEMP_INVOICE_STATUS INVS ON INVS.SCH_ID = SCH.SCH_ID
		),
		CLIENT AS 
(
	SELECT * FROM 
	(
		SELECT CLI_ID,MASTER_ID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.CLIENT_MASTER_LIST 
	) 
	UNION
	SELECT * FROM 
	(
		SELECT DISTINCT ID AS CLI_ID,MASTER_ID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.CLIENT_MATCH_LIST
		WHERE CLI_ID NOT IN (SELECT CLI_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.CLIENT_MASTER_LIST)
	)),
	 EMPLOYEE AS 
(
	SELECT * FROM
	(
		SELECT CAR_ID, MASTER_ID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.EMPLOYEE_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT CAR_ID, MASTER_ID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.EMPLOYEE_MATCH_LIST
		WHERE CAR_ID NOT IN (SELECT CAR_ID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.MATRIXCARE.EMPLOYEE_MASTER_LIST ) 
	) ),
	SUPERVISORS AS
(
	SELECT DISTINCT COALESCE(ADM.ADM_SUPERVISORID, ADM.ADM_COORDINATORID, ADM.ADM_INTERNALCASEMGRID) AS SUPERVISOR_CODE,
	MAX(ADM.ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_ADMISSIONS ADM
	WHERE COALESCE(ADM.ADM_SUPERVISORID, ADM.ADM_COORDINATORID, ADM.ADM_INTERNALCASEMGRID) IS NOT NULL
	GROUP BY 1
  UNION
   SELECT DISTINCT NVL( mccg.CAR_SUPERVISOR, mccg.CAR_MANAGER) AS SUPERVISOR_CODE,
    MAX( mccg.ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
	FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CAREGIVER mccg
	WHERE NVL( mccg.CAR_SUPERVISOR, mccg.CAR_MANAGER) IS NOT NULL
  GROUP BY 1
  )
SELECT DISTINCT
	MD5('MATRIXCARE' || '-' || SCH.SCH_ID || '-' || 'MATRIXCARE') AS VISIT_KEY
FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULES AS SCH
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULESTATUS AS SCHSTATUS ON SCH.SCH_SCHEDULESTATUSID = SCHSTATUS.SCHST_ID
LEFT JOIN DERIVED_STATUS DSTATUS ON SCH.SCH_ID = DSTATUS.SCH_ID
LEFT JOIN HAH.DIM_VISIT_STATUS_MAPPING VSM ON DSTATUS.VISIT_STATUS_KEY = VSM.VISIT_STATUS_KEY  
--LEFT JOIN HAH.DIM_VISIT_STATUS_MAPPING VSM ON DSTATUS.DERIVED_DISC_STATUS = VSM.DERIVED_DISC_STATUS  
--AND VSM.SYSTEM_CODE = 'MATRIXCARE' AND VSM.SOURCE_SYSTEM_ID = 7
--LEFT JOIN TEMP_INVOICE_STATUS INVS ON INVS.SCH_ID = SCH.SCH_ID
--LEFT JOIN HAH.DIM_VISIT_STATUS_MAPPING VSM2 ON INVS.INVOICE_STATUS_NAME = VSM2.INVOICE_STATUS_NAME 
--AND VSM2.SYSTEM_CODE = 'MATRIXCARE' AND VSM2.SOURCE_SYSTEM_ID = 7
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_CAREGIVER AS CARE ON CARE.CAR_ID = SCH.SCH_CAREGIVERID
LEFT JOIN EMPLOYEE AS EMP ON EMP.CAR_ID = SCH.SCH_CAREGIVERID 
LEFT JOIN HAH.DIM_EMPLOYEE DE
		ON DE.EMPLOYEE_ID = EMP.MASTER_ID
			AND DE.SOURCE_SYSTEM_ID = '7'
LEFT JOIN CLIENT AS CLI ON CLI.CLI_ID = SCH.SCH_CLIENTID 
LEFT JOIN BILL_RATES BR ON BR.SCHEDULEID = SCH.SCH_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_BRANCHES AS BRANCH ON BRANCH.BR_ID = SCH.SCH_BRANCHID 
AND  BRANCH.BR_NAME NOT LIKE  '%Training%'
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.MATRIXCARE_MASTER_BRANCH_MAPPING BRANCH_MAPPING ON BRANCH_MAPPING.OFFICE_CODE = SCH.SCH_BRANCHID::STRING 
AND BRANCH_MAPPING.SOURCE_SYSTEM_ID = 7 AND BRANCH_MAPPING.SYSTEM_CODE = 'MATRIXCARE' 
LEFT JOIN SCHEDULE_PAYERS AS SCHPAYER ON SCH.SCH_ID = SCHPAYER.SCHCP_SCHEDULEID
LEFT JOIN CLIENT_PAYERS CP ON SCH.SCH_CLIENTID = CP.CLIPAY_CLIENTID 
LEFT JOIN PAYER_BRANCH PB ON PB.PAYBR_BRANCH_ID = SCH.SCH_BRANCHID 
LEFT JOIN INVOICE_PAYERS INV ON INV.INVD_SCHEDULEID = SCH.SCH_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEHEADER AS INVOICE_HEADER ON INVOICE_HEADER.INVH_ID = INV.INVH_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_ADMISSIONS  ADM ON ADM.ADM_ID = SCH.SCH_ADMISSIONID
LEFT JOIN SUPERVISORS S ON S.SUPERVISOR_CODE= COALESCE(ADM.ADM_SUPERVISORID, ADM.ADM_COORDINATORID, ADM.ADM_INTERNALCASEMGRID,CARE.CAR_SUPERVISOR,CARE.CAR_MANAGER)
WHERE (SCH.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		OR SCHSTATUS.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		OR BRANCH.ETL_LAST_UPDATED_DATE >= '1900-01-01'
	    OR CARE.ETL_LAST_UPDATED_DATE >= '1900-01-01'
	    OR PB.ETL_LAST_UPDATED_DATE >= '1900-01-01'
	    OR CP.ETL_LAST_UPDATED_DATE >= '1900-01-01'
	    OR SCHPAYER.ETL_LAST_UPDATED_DATE >= '1900-01-01'
	    OR BR.ETL_LAST_UPDATED_DATE >= '1900-01-01'
	    OR INV.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		OR BRANCH_MAPPING.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		)
	AND IFF(SCH.SCH_STARTTIME IS NULL OR SCH.SCH_ENDTIME IS NULL, 
		CASE WHEN SCH.SCH_BILLRATEUNITFLAG =0 THEN CAST(SCH.SCH_PAYUNITS/(60/NULLIF(SCH.SCH_PAYRATEUNITFLAG, 0)) AS DECIMAL(18,3)) ELSE 
			CAST(SCH.SCH_UNITS/(60/NULLIF(SCH.SCH_BILLRATEUNITFLAG, 0)) AS DECIMAL(18,3)) END,
		CAST(DATEDIFF(MINUTE, SCH.SCH_STARTTIME, SCH.SCH_ENDTIME) AS DECIMAL(18, 3)) / 60.0) > 0;
SQL
	or_replace = true 
	is_secure = false 
}

