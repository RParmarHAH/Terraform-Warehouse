create or replace view DW_PROD.STAGE.VW_CURRENT_DELETED_MATRIXCARE_DIM_INVOICE(
	INVOICE_KEY
) as
WITH INVOICE_DETAILS AS 
(
	SELECT INVOICE_DETAILS.INVD_INVHID AS INVH_ID, 
		SUM(NVL(INVOICE_DETAILS.INVD_TOTALCHARGES, 0) + NVL(INVOICE_DETAILS.INVD_TOTALREVADJUSTMENTS, 0)) AS AMOUNT_BILLED,
		SUM(INVOICE_DETAILS.INVD_TOTALPAYMENTS * -1) AS AMOUNT_COLLECTED, -- Payments are in negative amounts 
		SUM(INVOICE_DETAILS.INVD_BALANCE) AS AMOUNT_OUTSTANDING,
		MAX(PAYMENT_POSTING.POST_POSTEDDATE) AS FINAL_PAYMENT_DATE,
		MAX(
			GREATEST(
				NVL(INVOICE_DETAILS.ETL_LAST_UPDATED_DATE, '1/1/1900'),
				NVL(PAYMENT_POSTING.ETL_LAST_UPDATED_DATE, '1/1/1900'))) AS ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.MATRIXCARE.STVHC_T_INVOICEDETAILS AS INVOICE_DETAILS
	LEFT JOIN (
		SELECT POST_INVOICEDETAILID, MAX(POST_POSTEDDATE) AS POST_POSTEDDATE, MAX(ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
		FROM DISC_PROD.MATRIXCARE.STVHC_T_PAYMENTPOSTING
		GROUP BY POST_INVOICEDETAILID
	) AS PAYMENT_POSTING
		ON PAYMENT_POSTING.POST_INVOICEDETAILID = INVOICE_DETAILS.INVD_ID 
	GROUP BY INVOICE_DETAILS.INVD_INVHID
),
 CLIENT AS 
(
	SELECT * FROM 
	(
		SELECT CLI_ID,MASTER_ID
		FROM DISC_DEDUPE_PROD.MATRIXCARE.CLIENT_MASTER_LIST 
	) 
	UNION
	SELECT * FROM 
	(
		SELECT DISTINCT ID AS CLI_ID,MASTER_ID
		FROM DISC_DEDUPE_PROD.MATRIXCARE.CLIENT_MATCH_LIST
		WHERE CLI_ID NOT IN (SELECT CLI_ID FROM DISC_DEDUPE_PROD.MATRIXCARE.CLIENT_MASTER_LIST)
	))
,OLD_DATA AS 
(
	SELECT MD5('MATRIXCARE' || '-' || INVOICE_HEADER.INVH_ID::STRING || '-' || 'MATRIXCARE') AS INVOICE_KEY,
		MD5('MATRIXCARE' || '-' || INVOICE_HEADER.INVH_CLIENTID::STRING || '-' || 'MATRIXCARE') AS CLIENT_KEY,
		MD5('MATRIXCARE' || '-' || INVOICE_HEADER.INVH_BRANCHID::STRING || '-' || 'MATRIXCARE') AS BRANCH_KEY
	FROM DISC_PROD.MATRIXCARE.HIST_STVHC_T_INVOICEHEADER AS INVOICE_HEADER
	LEFT JOIN DISC_PROD.MATRIXCARE.STVHC_T_PAYERS AS PAYERS
		ON PAYERS.PAY_ID = INVOICE_HEADER.INVH_PAYERID 
	LEFT JOIN DISC_PROD.MATRIXCARE.STVHC_T_PAYERTYPE AS PAYER_TYPE
		ON PAYER_TYPE.PAYTYP_ID = PAYERS.PAY_PAYERTYPEID 
		LEFT JOIN CLIENT C 
	    ON C.CLI_ID = INVOICE_HEADER.INVH_CLIENTID
	LEFT JOIN INVOICE_DETAILS AS INVOICE_DETAILS
		ON INVOICE_DETAILS.INVH_ID = INVOICE_HEADER.INVH_ID
			WHERE (INVOICE_HEADER.ETL_LAST_UPDATED_DATE >= '1900-01-01'
		OR INVOICE_DETAILS.ETL_LAST_UPDATED_DATE >= '1900-01-01')
		AND INVOICE_HEADER.ETL_DELETED_FLAG = TRUE
		AND CAST(INVOICE_HEADER.ETL_LAST_UPDATED_DATE AS DATE) IN (SELECT CAST(MAX(ETL_LAST_UPDATED_DATE) AS DATE) FROM DISC_PROD.MATRIXCARE.HIST_STVHC_T_INVOICEHEADER)
)
,ALL_DATA AS 
(
	SELECT O.INVOICE_KEY, O.CLIENT_KEY , 
	COALESCE (B.CONVERGED_BRANCH_KEY,O.BRANCH_KEY) AS BRANCH_KEY
	FROM OLD_DATA O 
    --LEFT JOIN DISC_PROD.MATRIXCARE.MATRIXCARE_MASTER_CLIENT_MAPPING_ALL MCM ON MCM.CLIENT_KEY = O.CLIENT_KEY
    LEFT JOIN DISC_PROD.MATRIXCARE.MATRIXCARE_MASTER_BRANCH_MAPPING B ON B.BRANCH_KEY=O.BRANCH_KEY
    )
SELECT INVOICE_KEY FROM ALL_DATA;