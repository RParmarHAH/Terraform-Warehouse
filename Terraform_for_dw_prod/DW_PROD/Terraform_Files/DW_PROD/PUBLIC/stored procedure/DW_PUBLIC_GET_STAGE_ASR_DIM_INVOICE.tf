resource "snowflake_procedure" "DW_PUBLIC_GET_STAGE_ASR_DIM_INVOICE" {
	name ="GET_STAGE_ASR_DIM_INVOICE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "JAVASCRIPT"

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

	var sql = `
--****************************************************************************************************************************
-- NAME:  ASR_DIM_INVOICE
--
-- PURPOSE: Creates one row per invoice according to ASRs Historical 2022 excel sheet from MATT SHERFIELD 
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------		-------------------		---------------------------------------------------------------------------------------
-- 07/04/2022	Jashvant Patel			Initial Development
-- 07/04/2022	Abhishek Sunil			Revised logic, resolved errors
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.ASR_DIM_INVOICE
WITH CLIENT AS
(
    SELECT * FROM
    (
        SELECT MASTER_ID, CUSTOMERID,SUPERVISORID
        FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ASR.CLIENT_MASTER_LIST
    )
    UNION
    SELECT * FROM
    (
        SELECT DISTINCT MASTER_ID, CUSTOMERID, NULL AS SUPERVISORID
        FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ASR.CLIENT_MATCH_LIST
        WHERE CUSTOMERID NOT IN (SELECT CUSTOMERID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ASR.CLIENT_MASTER_LIST)
    )
)
SELECT
    MD5(''PRIME'' || ''-'' || TRIM(BSVR.BILLING_TRAN_ID_NUMBER) || ''-'' || ''ASR'') AS INVOICE_KEY,
    MD5(''PRIME'' || ''-'' || COALESCE(TRIM(CLI.MASTER_ID),TRIM(BSVR.CUSTOMER_ID)) || ''-'' || ''ASR'') AS CLIENT_KEY,
    BSVR.BILLING_TRAN_ID_NUMBER AS INVOICE_NUMBER,
    BSVR.BILLING_TRAN_ID_NUMBER AS ALTERNATE_INVOICE_NUMBER,
    TO_VARCHAR(TRY_TO_DATE(BSVR.VISIT_DATE,''MM/DD/YYYY''),''YYYYMM'') AS PERIOD,
    ''Regular'' AS INVOICE_TYPE,
    1 AS NUMBER_OF_CLIENTS,
    ''PRIME'' AS SYSTEM_CODE,
    13 AS SOURCE_SYSTEM_ID,
    MD5(''PRIME'' || ''-'' || TRIM(NULLIF(BM.NEW_LOCATION_ID,''UNKNOWN'')) || ''-'' || ''ASR'') AS BRANCH_KEY,
    P.PAYERSOURCEID AS PAYOR_CODE,
    P.PAYERSOURCENAME AS PAYOR_NAME,
    TRUE AS INVOICE_OPEN_FLAG,
    TRY_TO_DATE(BSVR.VISIT_DATE,''MM/DD/YYYY'') AS FIRST_INVOICE_DATE,
    NULL AS FINAL_PAYMENT_DATE,
    BSVR.BILLING_TRAN_ID_NUMBER AS FIRST_INVOICE_NUMBER,
    1 AS BILL_ITERATION,
    NULL AS BILL_REPRESENTATIVE,
    S.SUPERVISORNAME AS BILL_SUPERVISOR,
    NULL AS BILL_MANAGER,
    IFF(TRIM(BSVR.PAYABLE_OR_BILLIABLE_HRS) = ''[NULL]'',''Unbilled'',''Billed'') AS INVOICE_STATUS,
    FALSE AS WRITEOFF_FLAG,
    NULL AS WRITEOFF_REASON,
    --CASE WHEN BSVR.BILLING_AMOUNT = ''NULL'' THEN 0 ELSE BSVR.BILLING_AMOUNT END  AS AMOUNT_BILLED,
    NULLIF(TRIM(BSVR.BILLING_AMOUNT),''[NULL]'') AS AMOUNT_BILLED,
    NULL AS AMOUNT_COLLECTED,
    NULL AS AMOUNT_OUTSTANDING,
    ''1900-01-01''::DATE AS EFFECTIVE_FROM_DATE,
    ''9999-12-31''::DATE AS EFFECTIVE_TO_DATE,

	`;    
		sql += STR_ETL_TASK_KEY;
		sql +=  
		` AS ETL_TASK_KEY,

	`;    
		sql += STR_ETL_TASK_KEY;
		sql +=  
		` AS ETL_INSERTED_TASK_KEY,

	CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
    CURRENT_USER AS ETL_INSERTED_BY ,
    CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
    CURRENT_USER AS ETL_LAST_UPDATED_BY,
    0 AS ETL_DELETED_FLAG,
    0 AS ETL_INFERRED_MEMBER_FLAG
FROM
     DISC_${var.SF_ENVIRONMENT}.ASR.ASR_REVENUE BSVR
LEFT JOIN
    CLIENT CLI ON BSVR.CUSTOMER_ID = CLI.CUSTOMERID
LEFT JOIN
    DISC_${var.SF_ENVIRONMENT}.ASR.ASR_PAYERSOURCES P ON UPPER(P.PAYERSOURCENAME) = UPPER(BSVR.PAYER_SOURCE)
LEFT JOIN
    DISC_${var.SF_ENVIRONMENT}.ASR.BRANCH_MAPPING BM ON TRIM(UPPER(BM.OLD_LOCATION_NAME)) = TRIM(UPPER(BSVR.LOCATION))
LEFT JOIN
     DISC_${var.SF_ENVIRONMENT}.ASR.ASR_SUPERVISORS S ON CLI.SUPERVISORID =S.SUPERVISORID
WHERE NULLIF(BSVR.EMPLOYEE_ID,''[NULL]'') IS NOT NULL
`;
          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          
 EOT
}

