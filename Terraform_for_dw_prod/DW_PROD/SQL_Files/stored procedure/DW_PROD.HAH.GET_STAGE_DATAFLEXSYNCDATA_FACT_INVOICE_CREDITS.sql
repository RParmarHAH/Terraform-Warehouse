CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_DATAFLEXSYNCDATA_FACT_INVOICE_CREDITS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME:  DATAFLEXSYNCDATA_FACT_INVOICE_CREDITS
--
-- PURPOSE: Creates one row per payment/credit according to DataFlexSyncData
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR               NOTES:
-- --------    -------------------  -----------------------------------------------------------------------------------------------
-- 04/12/21    Mir Ali              Initial Development
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.DATAFLEXSYNCDATA_FACT_INVOICE_CREDITS (
	CREDIT_KEY, REPORT_DATE, BRANCH_KEY, CLIENT_KEY, CONTRACT_KEY, INVOICE_KEY,
	SOURCE_SYSTEM_ID, SYSTEM_CODE, PERIOD, PERIOD_DATE, PAYMENT_DATE, BRANCH_NAME, CLIENT_NUMBER, CONTRACT_CODE, SERVICE_AREA,
	INVOICE_TYPE, NUMBER_OF_INVOICES, INVOICE_NUMBER, CREDIT_TYPE, CREDIT_AMOUNT, 
	PAYMENT_NUMBER, PAYMENT_NOTES, CHECK_NUMBER, AUDIT_NUMBER, WRITEOFF_REASON_CODE, WRITEOFF_REASON_DESCRIPTION,
	ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY, ETL_DELETED_FLAG
)
WITH STATE_PAYMENTS AS (
	SELECT COALESCE(INVOICE_PAYMENTS.PAYMENTDATETIME, INVOICE_PAYMENTS.ADDEDDATE, INVOICE_PAYMENTS.CREATEDDATE) AS REPORT_DATE,
		3 AS SOURCE_SYSTEM_ID,
		INVOICE_PAYMENTS.DBNAME AS SYSTEM_CODE,
		INVOICE_PAYMENTS.REFERENCENO AS REFERENCE_NUMBER,
		COALESCE(NULLIF(TRIM(INVOICE_PAYMENTS.PERIOD), ''''), INVOICES.PERIOD) AS PERIOD,
		CAST(INVOICE_PAYMENTS.PAYMENTDATETIME AS DATETIME) AS PAYMENT_DATE,
		COALESCE(NULLIF(INVOICE_PAYMENTS.CLIENTNUMBER, 0), NULLIF(INVOICES.CLIENTNUMBER, 0), -1) AS CLIENT_NUMBER,
		COALESCE(NULLIF(TRIM(INVOICE_PAYMENTS.CONTRACTCODE), ''''), NULLIF(TRIM(INVOICES.CONTRACTCODE), ''''), ''Unknown'') AS CONTRACT_CODE,
		COALESCE(NULLIF(INVOICES.OFFICE, 0), -1) AS OFFICE_NUMBER, 
		NULL AS SERVICE_AREA,
		''Regular'' AS INVOICE_TYPE,
		1 AS NUMBER_OF_INVOICES,
		NVL(INVOICE_PAYMENTS.INVOICENO, -1)::STRING AS INVOICE_NUMBER,
--		COALESCE(INVOICES.AMOUNTBILLED, INVOICE_PAYMENTS.BILLEDAMOUNT) AS BILL_AMOUNT, -- Removed because this is same as from Dim_Invoice
		IFF(INVOICE_PAYMENTS.CODE = ''WO'', ''Write Off'', ''State Payment'') AS CREDIT_TYPE,
		NVL(INVOICE_PAYMENTS.PAIDAMOUNT, 0) AS CREDIT_AMOUNT,
--		INVOICE_PAYMENTS.SUPPLEMENTNO AS PAYMENT_NUMBER,
		NULL AS PAYMENT_NOTES,
		INVOICE_PAYMENTS.CHECKNUMBER AS CHECK_NUMBER,
		INVOICE_PAYMENTS.AUDITNO AS AUDIT_NUMBER,
		COALESCE(NULLIF(INVOICE_PAYMENTS.WRITEOFFREASON::STRING, 0), NULLIF(TRIM(INVOICE_PAYMENTS.CODE), '''')) AS WRITEOFF_REASON_CODE,
		''Unknown ('' || WRITEOFF_REASON_CODE || '')'' AS WRITEOFF_REASON_DESCRIPTION,
		GREATEST(
			COALESCE(MAX(INVOICE_PAYMENTS.ETL_LAST_UPDATED_DATE) OVER (PARTITION BY SYSTEM_CODE, INVOICE_NUMBER), ''1/1/1900''),
			COALESCE(MAX(INVOICES.ETL_LAST_UPDATED_DATE) OVER (PARTITION BY SYSTEM_CODE, INVOICE_NUMBER), ''1/1/1900'')
		) AS ETL_LAST_UPDATED_DATE 
	FROM DISC_PROD.DATAFLEXSYNCDATA.DFINVOICEPAYMENTS AS INVOICE_PAYMENTS
	LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES AS INVOICES ON INVOICES.DBNAME = INVOICE_PAYMENTS.DBNAME AND INVOICES.INVOICENO = INVOICE_PAYMENTS.INVOICENO 
),
STATE_COPAY_PAYMENTS AS (
	-- Co-Pay Payments
	SELECT COALESCE(INVOICE_PAYMENTS.PAYMENTDATETIME, INVOICE_PAYMENTS.ADDEDDATE, INVOICE_PAYMENTS.CREATEDDATE) AS REPORT_DATE,
		3 AS SOURCE_SYSTEM_ID,
		INVOICE_PAYMENTS.DBNAME AS SYSTEM_CODE,
		INVOICE_PAYMENTS.REFERENCENO AS REFERENCE_NUMBER,
		COALESCE(NULLIF(TRIM(INVOICE_PAYMENTS.PERIOD), ''''), INVOICES.PERIOD) AS PERIOD,
		CAST(INVOICE_PAYMENTS.PAYMENTDATETIME AS DATETIME) AS PAYMENT_DATE,
		COALESCE(NULLIF(INVOICE_PAYMENTS.CLIENTNUMBER, 0), NULLIF(INVOICES.CLIENTNUMBER, 0), -1) AS CLIENT_NUMBER,
		COALESCE(NULLIF(TRIM(INVOICE_PAYMENTS.CONTRACTCODE), ''''), NULLIF(TRIM(INVOICES.CONTRACTCODE), ''''), ''Unknown'') AS CONTRACT_CODE,
		COALESCE(NULLIF(INVOICES.OFFICE, 0), -1) AS OFFICE_NUMBER, 
		NULL AS SERVICE_AREA,
		''Regular'' AS INVOICE_TYPE,
		1 AS NUMBER_OF_INVOICES,
		NVL(INVOICE_PAYMENTS.INVOICENO, -1)::STRING AS INVOICE_NUMBER,
		''Co-Pay Payment'' AS CREDIT_TYPE,
		INVOICE_PAYMENTS.COPAY AS CREDIT_AMOUNT,
		NULL AS PAYMENT_NOTES,
		INVOICE_PAYMENTS.CHECKNUMBER AS CHECK_NUMBER,
		INVOICE_PAYMENTS.AUDITNO AS AUDIT_NUMBER,
		COALESCE(NULLIF(INVOICE_PAYMENTS.WRITEOFFREASON::STRING, 0), NULLIF(TRIM(INVOICE_PAYMENTS.CODE), '''')) AS WRITEOFF_REASON_CODE,
		''Unknown ('' || WRITEOFF_REASON_CODE || '')'' AS WRITEOFF_REASON_DESCRIPTION,
		GREATEST(
			COALESCE(MAX(INVOICE_PAYMENTS.ETL_LAST_UPDATED_DATE) OVER (PARTITION BY SYSTEM_CODE, INVOICE_NUMBER), ''1/1/1900''),
			COALESCE(MAX(INVOICES.ETL_LAST_UPDATED_DATE) OVER (PARTITION BY SYSTEM_CODE, INVOICE_NUMBER), ''1/1/1900'')
		) AS ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.DATAFLEXSYNCDATA.DFINVOICEPAYMENTS AS INVOICE_PAYMENTS
	LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES AS INVOICES ON INVOICES.DBNAME = INVOICE_PAYMENTS.DBNAME AND INVOICES.INVOICENO = INVOICE_PAYMENTS.INVOICENO 
	WHERE INVOICE_PAYMENTS.COPAY <> 0
),
CLIENT_PAYMENTS AS (
	SELECT COALESCE(PAYMENTS.PAYDATE, PAYMENTS.CHANGEDDATE, PAYMENTS.ADDEDDATE, PAYMENTS.CREATEDDATE) AS REPORT_DATE,
		3 AS SOURCE_SYSTEM_ID,
		PAYMENTS.DBNAME AS SYSTEM_CODE,
		COALESCE(PAYMENT_DETAILS.REFERENCENO, PAYMENTS.REFERENCENO) AS REFERENCE_NUMBER,
		INVOICES.PERIOD, -- Could be null
		CAST(REPORT_DATE AS DATETIME) AS PAYMENT_DATE,
		COALESCE(NULLIF(PAYMENT_DETAILS.CLIENTNUMBER, 0), NULLIF(PAYMENTS.CLIENTNUMBER, 0), NULLIF(INVOICES.CLIENTNUMBER, 0), -1) AS CLIENT_NUMBER,
		COALESCE(NULLIF(TRIM(PAYMENT_DETAILS.CONTRACTCODE), ''''), NULLIF(TRIM(PAYMENTS.CONTRACTCODE), ''''), NULLIF(TRIM(INVOICES.CONTRACTCODE), ''''), ''Unknown'') AS CONTRACT_CODE,
		COALESCE(NULLIF(INVOICES.OFFICE, 0), -1) AS OFFICE_NUMBER, 
		INVOICES.SERVICEAREA AS SERVICE_AREA,
		''Regular'' AS INVOICE_TYPE,
		COALESCE(INVOICE_COUNT.NUMBER_OF_INVOICES, 1) AS NUMBER_OF_INVOICES, -- Using our own calculated value, rather than from DfPayments.NumbersOfInvoices
		NVL(PAYMENT_DETAILS.INVOICENO, -1)::STRING AS INVOICE_NUMBER,
		IFF(PAYMENTS.CODE = ''WO'', ''Write Off'', ''Client Payment'') AS CREDIT_TYPE,
		COALESCE(PAYMENT_DETAILS.AMOUNT, PAYMENTS.AMOUNT) AS CREDIT_AMOUNT,
--		PAYMENTS.PAYMENTNO AS PAYMENT_NUMBER,
		NULL AS PAYMENT_NOTES,
		PAYMENTS.CHECKNUMBER AS CHECK_NUMBER,
		COALESCE(PAYMENT_DETAILS.AUDITNO, PAYMENTS.AUDITNO) AS AUDIT_NUMBER,
		COALESCE(NULLIF(PAYMENTS.WRITEOFFREASON::STRING, 0), NULLIF(TRIM(PAYMENTS.CODE), '''')) AS WRITEOFF_REASON_CODE,
		''Unknown ('' || WRITEOFF_REASON_CODE || '')'' AS WRITEOFF_REASON_DESCRIPTION,
		GREATEST(
			COALESCE(MAX(PAYMENTS.ETL_LAST_UPDATED_DATE) OVER (PARTITION BY SYSTEM_CODE, INVOICE_NUMBER), ''1/1/1900''),
			COALESCE(MAX(PAYMENT_DETAILS.ETL_LAST_UPDATED_DATE) OVER (PARTITION BY SYSTEM_CODE, INVOICE_NUMBER), ''1/1/1900'')
		) AS ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.DATAFLEXSYNCDATA.DFPAYMENTS AS PAYMENTS
	LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFPAYMENTDETAILS AS PAYMENT_DETAILS
		ON PAYMENT_DETAILS.DBNAME = PAYMENTS.DBNAME AND PAYMENT_DETAILS.PAYMENTNO = PAYMENTS.PAYMENTNO
	LEFT JOIN (
		SELECT DBNAME, PAYMENTNO, COUNT(DISTINCT INVOICENO) AS NUMBER_OF_INVOICES
		FROM DISC_PROD.DATAFLEXSYNCDATA.DFPAYMENTDETAILS 
		GROUP BY DBNAME, PAYMENTNO 
	) AS INVOICE_COUNT
		ON INVOICE_COUNT.DBNAME = PAYMENTS.DBNAME AND INVOICE_COUNT.PAYMENTNO = PAYMENTS.PAYMENTNO
	LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFINVOICES AS INVOICES
		ON INVOICES.DBNAME = PAYMENT_DETAILS.DBNAME AND INVOICES.INVOICENO = PAYMENT_DETAILS.INVOICENO 
),
LUMP_SUM_ARPAYMENTS AS (
	SELECT PAYMENTS.PAYMENTDATETIME AS REPORT_DATE,
		3 AS SOURCE_SYSTEM_ID,
		PAYMENTS.DBNAME AS SYSTEM_CODE,
		PAYMENTS.REFERENCENO AS REFERENCE_NUMBER,
		PAYMENTS.PERIOD,
		CAST(PAYMENTS.PAYMENTDATETIME AS DATETIME) AS PAYMENT_DATE,
		TRY_CAST(CONCAT(-100, PAYMENTS.OFFICENO) AS INTEGER) AS CLIENT_NUMBER,
		COALESCE(NULLIF(TRIM(PAYMENTS.CONTRACTCODE), ''''), ''Unknown'') AS CONTRACT_CODE,
		PAYMENTS.OFFICENO AS OFFICE_NUMBER, 
		INVOICES.SERVICEAREA AS SERVICE_AREA,
		''Lump Sum'' AS INVOICE_TYPE,
		1 AS NUMBER_OF_INVOICES,
		NVL(INVOICES.INVOICENUMBER, ''-1'')::STRING AS INVOICE_NUMBER, 
		IFF(PAYMENTS.CODE = ''WO'', ''Write Off'', ''Lump Sum Payment'') AS CREDIT_TYPE,
		PAYMENTS.PAYMENTAMOUNT AS CREDIT_AMOUNT,
		PAYMENTS.SUPPLEMENTNO,
		PAYMENTS.PAYMENTDESCRIPTION AS PAYMENT_NOTES,
		PAYMENTS.CHECKNUMBER AS CHECK_NUMBER,
		PAYMENTS.AUDITNO AS AUDIT_NUMBER,
		NULL AS WRITEOFF_REASON_CODE,
		NULL AS WRITEOFF_REASON_DESCRIPTION,
		GREATEST(
			COALESCE(MAX(PAYMENTS.ETL_LAST_UPDATED_DATE) OVER (PARTITION BY SYSTEM_CODE, INVOICE_NUMBER), ''1/1/1900''),
			COALESCE(MAX(INVOICES.ETL_LAST_UPDATED_DATE) OVER (PARTITION BY SYSTEM_CODE, INVOICE_NUMBER), ''1/1/1900'')
		) AS ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.DATAFLEXSYNCDATA.DFARPAYMENTS AS PAYMENTS
	LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFARINVOICES AS INVOICES
		ON INVOICES.DBNAME = PAYMENTS.DBNAME AND INVOICES.OFFICE = PAYMENTS.OFFICENO
			AND	INVOICES.PERIOD = PAYMENTS.PERIOD AND INVOICES.CONTRACTCODE = PAYMENTS.CONTRACTCODE 
			AND INVOICES.SUPPLEMENTNO = PAYMENTS.SUPPLEMENTNO  
	WHERE TRIM(NVL(PAYMENTS.PERIOD, '''')) <> ''''
),
LUMP_SUM_ARPAYMENTS_FROM_ARINVOICES AS (
	SELECT COALESCE(INVOICES.LASTPAYDATE, INVOICES.DATECREATED) AS REPORT_DATE,
		3 AS SOURCE_SYSTEM_ID,
		INVOICES.DBNAME AS SYSTEM_CODE,
		INVOICES.REFERENCENO AS REFERENCE_NUMBER,
		INVOICES.PERIOD,
		CAST(INVOICES.LASTPAYDATE AS DATETIME) AS PAYMENT_DATE,
		TRY_CAST(CONCAT(-100, INVOICES.OFFICE) AS INTEGER) AS CLIENT_NUMBER,
		COALESCE(NULLIF(TRIM(INVOICES.CONTRACTCODE), ''''), ''Unknown'') AS CONTRACT_CODE,
		COALESCE(PAYMENTS.OFFICE_NUMBER, INVOICES.OFFICE, -1) AS OFFICE_NUMBER, 
		INVOICES.SERVICEAREA AS SERVICE_AREA,
		''Lump Sum'' AS INVOICE_TYPE,
		1 AS NUMBER_OF_INVOICES, -- Need to implement
		INVOICES.INVOICENUMBER AS INVOICE_NUMBER, -- Need to implement
		''Lump Sum Payment'' AS CREDIT_TYPE,
		INVOICES.GROSSPAID AS CREDIT_AMOUNT,
--		INVOICES.SUPPLEMENTNO AS PAYMENT_NUMBER,
		NULL AS PAYMENT_NOTES,
		NULL AS CHECK_NUMBER,
		NULL AS AUDIT_NUMBER,
		NULL AS WRITEOFF_REASON_CODE,
		NULL AS WRITEOFF_REASON_DESCRIPTION,
		COALESCE(MAX(INVOICES.ETL_LAST_UPDATED_DATE) OVER (PARTITION BY SYSTEM_CODE, INVOICE_NUMBER), ''1/1/1900'') AS ETL_LAST_UPDATED_DATE
	FROM DISC_PROD.DATAFLEXSYNCDATA.DFARINVOICES AS INVOICES
	LEFT JOIN LUMP_SUM_ARPAYMENTS AS PAYMENTS
		ON PAYMENTS.SYSTEM_CODE = INVOICES.DBNAME AND PAYMENTS.OFFICE_NUMBER = INVOICES.OFFICE 
			AND PAYMENTS.PERIOD = INVOICES.PERIOD AND PAYMENTS.CONTRACT_CODE = INVOICES.CONTRACTCODE 
			AND PAYMENTS.SUPPLEMENTNO = INVOICES.SUPPLEMENTNO 
	WHERE PAYMENTS.SYSTEM_CODE IS NULL
),
RESULTS AS (
	SELECT LIST.CREDIT_KEY,
		LIST.REPORT_DATE,
		COALESCE(BRANCH.BRANCH_KEY, MD5(LIST.SYSTEM_CODE || ''-'' || LIST.OFFICE_NUMBER || ''-'' || ''DATAFLEXSYNCDATA'')) AS BRANCH_KEY,
		MD5(LIST.SYSTEM_CODE || ''-'' || LIST.CLIENT_NUMBER || ''-'' || IFF(LIST.INVOICE_TYPE = ''Lump Sum'', ''DATAFLEXSYNCDATA-DUMMY'', ''DATAFLEXSYNCDATA'')) AS CLIENT_KEY,
		MD5(LIST.SYSTEM_CODE || ''-'' || LIST.CONTRACT_CODE || ''-'' || ''DATAFLEXSYNCDATA'') AS CONTRACT_KEY,
		LIST.INVOICE_KEY,
		LIST.SOURCE_SYSTEM_ID,
		LIST.SYSTEM_CODE,
		LIST.PERIOD,
		LIST.PERIOD_DATE,
		LIST.PAYMENT_DATE,
		COALESCE(BRANCH.BRANCH_NAME, LIST.SYSTEM_CODE || ''-Unknown'') AS BRANCH_NAME,
		LIST.CLIENT_NUMBER,
		LIST.CONTRACT_CODE,
		LIST.SERVICE_AREA,
		LIST.INVOICE_TYPE,
		LIST.NUMBER_OF_INVOICES,
		LIST.INVOICE_NUMBER,
		LIST.CREDIT_TYPE,
		LIST.CREDIT_AMOUNT,
		LIST.PAYMENT_NUMBER,
		LIST.PAYMENT_NOTES,
		LIST.CHECK_NUMBER,
		LIST.AUDIT_NUMBER,
		LIST.WRITEOFF_REASON_CODE,
		LIST.WRITEOFF_REASON_DESCRIPTION
	FROM (
		SELECT MD5(DATA.SYSTEM_CODE || ''-'' || DATA.CLIENT_NUMBER || ''-'' || DATA.CONTRACT_CODE || ''-'' || 
				DATA.INVOICE_NUMBER || ''-'' || NVL(DATA.PERIOD, '''') || ''-'' || DATA.REPORT_DATE || ''-'' ||
				DATA.PAYMENT_NUMBER || ''-'' || ''DATAFLEXSYNCDATA-STATE PAYMENTS'') AS CREDIT_KEY,
			DATA.REPORT_DATE,
			DATA.SOURCE_SYSTEM_ID,
			DATA.SYSTEM_CODE,
			DATA.REFERENCE_NUMBER,
			DATA.PERIOD,
			DATA.PERIOD_DATE,
			DATA.PAYMENT_DATE,
			DATA.CLIENT_NUMBER,
			DATA.CONTRACT_CODE,
			DATA.OFFICE_NUMBER,
			DATA.SERVICE_AREA,
			DATA.INVOICE_TYPE,
			DATA.NUMBER_OF_INVOICES,
			DATA.INVOICE_NUMBER,
			MD5(DATA.SYSTEM_CODE || ''-'' || DATA.INVOICE_NUMBER || ''-'' || ''DATAFLEXSYNCDATA'') AS INVOICE_KEY,
			DATA.CREDIT_TYPE,
			DATA.CREDIT_AMOUNT,
			DATA.PAYMENT_NUMBER,
			DATA.PAYMENT_NOTES,
			DATA.CHECK_NUMBER,
			DATA.AUDIT_NUMBER,
			DATA.WRITEOFF_REASON_CODE,
			DATA.WRITEOFF_REASON_DESCRIPTION
		FROM (
			SELECT *,
				DATEFROMPARTS(LEFT(PERIOD, 4), RIGHT(PERIOD, 2), 1) AS PERIOD_DATE,
				ROW_NUMBER() OVER(
					PARTITION BY SYSTEM_CODE, INVOICE_NUMBER, COALESCE(PERIOD_DATE, CAST(REPORT_DATE AS DATE)) 
					ORDER BY PAYMENT_DATE, REFERENCE_NUMBER -- Payment number is by Invoice Number and Period Date, followed by Payment datetime
				) AS PAYMENT_NUMBER
			FROM STATE_PAYMENTS
			WHERE STATE_PAYMENTS.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
		) AS DATA
		UNION ALL
		SELECT MD5(DATA.SYSTEM_CODE || ''-'' || DATA.CLIENT_NUMBER || ''-'' || DATA.CONTRACT_CODE || ''-'' || 
				DATA.INVOICE_NUMBER || ''-'' || NVL(DATA.PERIOD, '''') || ''-'' || DATA.REPORT_DATE || ''-'' ||
				DATA.PAYMENT_NUMBER || ''-'' || ''DATAFLEXSYNCDATA-STATE COPAY PAYMENTS'') AS CREDIT_KEY,
			DATA.REPORT_DATE,
			DATA.SOURCE_SYSTEM_ID,
			DATA.SYSTEM_CODE,
			DATA.REFERENCE_NUMBER,
			DATA.PERIOD,
			DATA.PERIOD_DATE,
			DATA.PAYMENT_DATE,
			DATA.CLIENT_NUMBER,
			DATA.CONTRACT_CODE,
			DATA.OFFICE_NUMBER,
			DATA.SERVICE_AREA,
			DATA.INVOICE_TYPE,
			DATA.NUMBER_OF_INVOICES,
			DATA.INVOICE_NUMBER,
			MD5(DATA.SYSTEM_CODE || ''-'' || DATA.INVOICE_NUMBER || ''-'' || ''DATAFLEXSYNCDATA'') AS INVOICE_KEY,
			DATA.CREDIT_TYPE,
			DATA.CREDIT_AMOUNT,
			DATA.PAYMENT_NUMBER,
			DATA.PAYMENT_NOTES,
			DATA.CHECK_NUMBER,
			DATA.AUDIT_NUMBER,
			DATA.WRITEOFF_REASON_CODE,
			DATA.WRITEOFF_REASON_DESCRIPTION
		FROM (
			SELECT *,
				DATEFROMPARTS(LEFT(PERIOD, 4), RIGHT(PERIOD, 2), 1) AS PERIOD_DATE,
				ROW_NUMBER() OVER(
					PARTITION BY SYSTEM_CODE, INVOICE_NUMBER, COALESCE(PERIOD_DATE, CAST(REPORT_DATE AS DATE)) 
					ORDER BY PAYMENT_DATE, REFERENCE_NUMBER -- Payment number is by Invoice Number and Period Date, followed by Payment datetime
				) AS PAYMENT_NUMBER
			FROM STATE_COPAY_PAYMENTS
			WHERE STATE_COPAY_PAYMENTS.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
		) AS DATA
		UNION ALL
		SELECT MD5(DATA.SYSTEM_CODE || ''-'' || DATA.CLIENT_NUMBER || ''-'' || DATA.CONTRACT_CODE || ''-'' || 
				DATA.INVOICE_NUMBER || ''-'' || NVL(DATA.PERIOD, '''') || ''-'' || DATA.REPORT_DATE || ''-'' ||
				DATA.PAYMENT_NUMBER || ''-'' || ''DATAFLEXSYNCDATA-CLIENT PAYMENTS'') AS CREDIT_KEY,
			DATA.REPORT_DATE,
			DATA.SOURCE_SYSTEM_ID,
			DATA.SYSTEM_CODE,
			DATA.REFERENCE_NUMBER,
			DATA.PERIOD,
			DATA.PERIOD_DATE,
			DATA.PAYMENT_DATE,
			DATA.CLIENT_NUMBER,
			DATA.CONTRACT_CODE,
			DATA.OFFICE_NUMBER,
			DATA.SERVICE_AREA,
			DATA.INVOICE_TYPE,
			DATA.NUMBER_OF_INVOICES,
			DATA.INVOICE_NUMBER,
			MD5(DATA.SYSTEM_CODE || ''-'' || DATA.INVOICE_NUMBER || ''-'' || ''DATAFLEXSYNCDATA'') AS INVOICE_KEY,
			DATA.CREDIT_TYPE,
			DATA.CREDIT_AMOUNT,
			DATA.PAYMENT_NUMBER,
			DATA.PAYMENT_NOTES,
			DATA.CHECK_NUMBER,
			DATA.AUDIT_NUMBER,
			DATA.WRITEOFF_REASON_CODE,
			DATA.WRITEOFF_REASON_DESCRIPTION
		FROM (
			SELECT *,
				DATEFROMPARTS(LEFT(PERIOD, 4), RIGHT(PERIOD, 2), 1) AS PERIOD_DATE,
				ROW_NUMBER() OVER(
					PARTITION BY SYSTEM_CODE, INVOICE_NUMBER, COALESCE(PERIOD_DATE, CAST(REPORT_DATE AS DATE)) 
					ORDER BY PAYMENT_DATE, REFERENCE_NUMBER -- Payment number is by Invoice Number and Period Date, followed by Payment datetime
				) AS PAYMENT_NUMBER
			FROM CLIENT_PAYMENTS
			WHERE CLIENT_PAYMENTS.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
		) AS DATA
		UNION ALL
		SELECT MD5(DATA.SYSTEM_CODE || ''-'' || DATA.CLIENT_NUMBER || ''-'' || DATA.CONTRACT_CODE || ''-'' || 
				DATA.INVOICE_NUMBER || ''-'' || NVL(DATA.PERIOD, '''') || ''-'' || DATA.REPORT_DATE || ''-'' ||
				DATA.PAYMENT_NUMBER || ''-'' || ''DATAFLEXSYNCDATA-LUMP SUM PAYMENTS'') AS CREDIT_KEY,
			DATA.REPORT_DATE,
			DATA.SOURCE_SYSTEM_ID,
			DATA.SYSTEM_CODE,
			DATA.REFERENCE_NUMBER,
			DATA.PERIOD,
			DATA.PERIOD_DATE,
			DATA.PAYMENT_DATE,
			DATA.CLIENT_NUMBER,
			DATA.CONTRACT_CODE,
			DATA.OFFICE_NUMBER,
			DATA.SERVICE_AREA,
			DATA.INVOICE_TYPE,
			DATA.NUMBER_OF_INVOICES,
			DATA.INVOICE_NUMBER,
			MD5(DATA.SYSTEM_CODE || ''-'' || DATA.INVOICE_NUMBER || ''-'' || 
				DATA.OFFICE_NUMBER || ''-'' || NVL(DATA.PERIOD, '''') || ''-'' || DATA.CONTRACT_CODE || ''-'' || ''DATAFLEXSYNCDATA-DFARINVOICES'') AS INVOICE_KEY,
			DATA.CREDIT_TYPE,
			DATA.CREDIT_AMOUNT,
			DATA.PAYMENT_NUMBER,
			DATA.PAYMENT_NOTES,
			DATA.CHECK_NUMBER,
			DATA.AUDIT_NUMBER,
			DATA.WRITEOFF_REASON_CODE,
			DATA.WRITEOFF_REASON_DESCRIPTION
		FROM (
			SELECT *,
				DATEFROMPARTS(LEFT(PERIOD, 4), RIGHT(PERIOD, 2), 1) AS PERIOD_DATE,
				ROW_NUMBER() OVER(
					PARTITION BY SYSTEM_CODE, INVOICE_NUMBER, COALESCE(PERIOD_DATE, CAST(REPORT_DATE AS DATE)) 
					ORDER BY PAYMENT_DATE, REFERENCE_NUMBER -- Payment number is by Invoice Number and Period Date, followed by Payment datetime
				) AS PAYMENT_NUMBER
			FROM LUMP_SUM_ARPAYMENTS
			WHERE LUMP_SUM_ARPAYMENTS.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
		) AS DATA
		UNION ALL
		SELECT MD5(DATA.SYSTEM_CODE || ''-'' || DATA.CLIENT_NUMBER || ''-'' || DATA.CONTRACT_CODE || ''-'' || 
				DATA.INVOICE_NUMBER || ''-'' || NVL(DATA.PERIOD, '''') || ''-'' || DATA.REPORT_DATE || ''-'' ||
				DATA.PAYMENT_NUMBER || ''-'' || ''DATAFLEXSYNCDATA-LUMP SUM PAYMENTS'') AS CREDIT_KEY,
			DATA.REPORT_DATE,
			DATA.SOURCE_SYSTEM_ID,
			DATA.SYSTEM_CODE,
			DATA.REFERENCE_NUMBER,
			DATA.PERIOD,
			DATA.PERIOD_DATE,
			DATA.PAYMENT_DATE,
			DATA.CLIENT_NUMBER,
			DATA.CONTRACT_CODE,
			DATA.OFFICE_NUMBER,
			DATA.SERVICE_AREA,
			DATA.INVOICE_TYPE,
			DATA.NUMBER_OF_INVOICES,
			DATA.INVOICE_NUMBER,
			MD5(DATA.SYSTEM_CODE || ''-'' || DATA.INVOICE_NUMBER || ''-'' || 
				DATA.OFFICE_NUMBER || ''-'' || NVL(DATA.PERIOD, '''') || ''-'' || DATA.CONTRACT_CODE || ''-'' || ''DATAFLEXSYNCDATA-DFARINVOICES'') AS INVOICE_KEY,
			DATA.CREDIT_TYPE,
			DATA.CREDIT_AMOUNT,
			DATA.PAYMENT_NUMBER,
			DATA.PAYMENT_NOTES,
			DATA.CHECK_NUMBER,
			DATA.AUDIT_NUMBER,
			DATA.WRITEOFF_REASON_CODE,
			DATA.WRITEOFF_REASON_DESCRIPTION
		FROM (
			SELECT *,
				DATEFROMPARTS(LEFT(PERIOD, 4), RIGHT(PERIOD, 2), 1) AS PERIOD_DATE,
				ROW_NUMBER() OVER(
					PARTITION BY SYSTEM_CODE, INVOICE_NUMBER, COALESCE(PERIOD_DATE, CAST(REPORT_DATE AS DATE)) 
					ORDER BY PAYMENT_DATE, REFERENCE_NUMBER -- Payment number is by Invoice Number and Period Date, followed by Payment datetime
				) AS PAYMENT_NUMBER
			FROM LUMP_SUM_ARPAYMENTS_FROM_ARINVOICES
			WHERE LUMP_SUM_ARPAYMENTS_FROM_ARINVOICES.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
		) AS DATA
	) AS LIST
	LEFT JOIN HAH.DIM_BRANCH AS BRANCH ON BRANCH.SOURCE_SYSTEM_ID = LIST.SOURCE_SYSTEM_ID AND BRANCH.SYSTEM_CODE = LIST.SYSTEM_CODE AND BRANCH.OFFICE_CODE = LIST.OFFICE_NUMBER::STRING
)
	SELECT CREDIT_KEY, REPORT_DATE, BRANCH_KEY, CLIENT_KEY, CONTRACT_KEY, INVOICE_KEY,
		SOURCE_SYSTEM_ID, SYSTEM_CODE, PERIOD, PERIOD_DATE, PAYMENT_DATE, BRANCH_NAME, CLIENT_NUMBER, CONTRACT_CODE, SERVICE_AREA,
		INVOICE_TYPE, NUMBER_OF_INVOICES, INVOICE_NUMBER, CREDIT_TYPE, CREDIT_AMOUNT, 
		PAYMENT_NUMBER, PAYMENT_NOTES, CHECK_NUMBER, AUDIT_NUMBER, WRITEOFF_REASON_CODE, WRITEOFF_REASON_DESCRIPTION,
		-- ETL Fields
		
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
                        
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
		CURRENT_USER as ETL_INSERTED_BY ,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_UPDATED_DATE,
		CURRENT_USER as ETL_LAST_UPDATED_BY,
		0 as ETL_DELETED_FLAG
	FROM RESULTS;
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    ';