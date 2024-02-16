resource "snowflake_procedure" "DW_HAH_GET_STAGE_EDISON_FACT_INVOICE_TRANSACTIONS" {
	name ="GET_STAGE_EDISON_FACT_INVOICE_TRANSACTIONS"
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
-- NAME:  EDISON_FACT_INVOICE_TRANSACTIONS
--
-- DEVELOPMENT LOG:
-- DATE            AUTHOR                      NOTES:
-- --------     -------------------  -----------------------------------------------------------------------------------------------
-- 12/28/23     RUTVI VYAS        Initial development
-- 12/14/23     Muhammad Zorob    Added billedhours/billed units to join to assoicate previously associated invoices to transactions (reach out to HHAx about mismatch servicecodeids)
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.EDISON_FACT_INVOICE_TRANSACTIONS
SELECT DISTINCT MD5(''EDISON'' || ''-'' || TR.SEQ || ''-'' || ''EDISON'')                      AS TRANSACTION_KEY
              , TR.TRANSACTIONNUMBER::VARCHAR                                                  AS TRANSACTION_NUMBER
              , MD5(''EDISON'' || ''-'' || NVL(ID.INVOICEDETAILID, 0) || ''-'' || NVL(TR.VISITID, 0) || ''-'' ||
                    ''EDISON'')                                                                AS REVENUE_KEY
              , MD5(''EDISON'' || ''-'' || NVL(TR.VISITID::STRING, 0) || ''-'' || '' EDISON'') AS VISIT_KEY
              , MD5(''EDISON'' || ''-'' || NVL(TO_VARCHAR(TR.TRANSACTIONTYPE), ''Unknown'') || ''-'' ||
                    ''EDISON'')                                                                   TRANSACTION_TYPE_KEY
              , NVL(CREDITAMOUNT, 0) + NVL(-1.0 * DEBITAMOUNT, 0)                              AS AMOUNT
              , TR.CREATEDDATE                                                                 AS TRANSACTION_CREATED
              , TR.DEPOSITDATE                                                                 AS TRANSACTION_POSTED
              , TR.CHECKDATE                                                                   AS TRANSACTION_DATE
              , TR.TRANSACTIONDATE                                                             AS FINAL_TRANSACTION_DATE
              , BC.CHECKNUMBER                                                                 AS CHECK_NUMBER
              , BC.CHECKDATE                                                                   AS CHECK_DATE
              , BC.DEPOSITDATE                                                                 AS DEPOSIT_DATE
              , BC.POSTEDDATE                                                                  AS POSTED_DATE
              , ''EDISON''                                                                     AS SYSTEM_CODE
              , 17                                                                             AS SOURCE_SYSTEM_ID
              , :STR_ETL_TASK_KEY                                                              AS ETL_TASK_KEY
              , :STR_ETL_TASK_KEY                                                              AS ETL_INSERTED_TASK_KEY
              , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz                    as ETL_INSERTED_DATE
              , CURRENT_USER                                                                   as ETL_INSERTED_BY
              , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz                    as ETL_UPDATED_DATE
              , CURRENT_USER                                                                   as ETL_LAST_UPDATED_BY
              , 0                                                                              as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.TRANSACTIONS_REPL TR
         LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.INVOICEDETAILS ID
                   ON ID.VISITID = TR.VISITID AND (ID.INVSERVICECODEID = TR.SERVICECODEID OR TR.BILLEDUNITS = ROUND(ID.BILLEDUNITS,0) or TR.BILLEDHOURS = ID.BILLEDHOURS) AND ID.AGENCYID = TR.AGENCYID
         LEFT JOIN "DISC_${var.SF_ENVIRONMENT}"."HHAEXCHANGEEDISON".BILLING_CHECKDETAILS_REPL BC ON BC.CHECKID = TR.TRANSACTIONID
WHERE TRANSACTIONTYPE != ''Invoice''
QUALIFY ROW_NUMBER() OVER (PARTITION BY TRANSACTION_KEY ORDER BY ID.INVSERVICECODEID = TR.SERVICECODEID) = 1;

;
RETURN ''SUCCESS'';
END;

 EOT
}

