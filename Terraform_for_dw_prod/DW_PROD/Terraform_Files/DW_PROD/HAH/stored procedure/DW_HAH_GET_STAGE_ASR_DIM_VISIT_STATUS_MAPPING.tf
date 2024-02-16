resource "snowflake_procedure" "DW_HAH_GET_STAGE_ASR_DIM_VISIT_STATUS_MAPPING" {
	name ="GET_STAGE_ASR_DIM_VISIT_STATUS_MAPPING"
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

DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
    --*****************************************************************************************************************************
-- NAME:  ASR_DIM_VISIT_STATUS_MAPPING
--
-- PURPOSE: Creates one row per status
--
-- PRODELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 09/16/22    Jashvant Patel        Initial PRODelopment
-- 10/19/22    Abhishek Sunil		 Updated logic to bring missing status
-- 08/10/23    Ramesh Mokariya       Updated logic to add Scheduled-Future-Unbilled
-- 09/08/23    Sandesh Gosavi        Updated logic to add Scheduled-Future-Unbilled
-- 15/09/23    Pooja Bagane          Added logic to get Data from ASR_RECEIVABLES,ASR_PAYMENTSRECEIVED AND ASR_CLAIMSTATUSES
--***************************************************************************************************************************** 
INSERT OVERWRITE INTO  DW_${var.SF_ENVIRONMENT}.STAGE.ASR_DIM_VISIT_STATUS_MAPPING 
WITH  BILLING_STATUS AS (
	SELECT 
		BILLING_TRAN_ID_NUMBER AS BILLINGTRANSACTIONID, 
		IFF(PAYABLE_OR_BILLIABLE_HRS IS NULL,''Unbilled'',''Billed'') AS INVOICE_STATUS
	FROM DISC_${var.SF_ENVIRONMENT}.ASR.ASR_REVENUE
	WHERE TO_DATE(VISIT_DATE,''MM/DD/YYYY'') < ''2022-06-01''
	AND BILLING_TRAN_ID_NUMBER NOT IN (SELECT BILLINGTRANSACTIONID FROM DISC_${var.SF_ENVIRONMENT}.ASR.ASR_RECEIVABLES)-- Invoices FROM JUNE 1st, 2022 IS processed IN the 2nd logic
	UNION 
	SELECT -- Adjusted AND Clean Invoices FOR the visits ON or AFTER June 1st 2022
		BILLINGTRANSACTIONID, 
		INVOICE_STATUS 
	FROM (
		SELECT
			RB.BILLINGTRANSACTIONID,
			TRY_TO_DATE(TRIM(RB.VISITDATE),''MM/DD/YYYY HH:MI:SS'') AS SERVICE_DATE,
			TRY_TO_DATE(TRIM(PB.PAIDDATE),''MM/DD/YYYY HH:MI:SS'') AS PAID_DATE,
			NVL(RB.BILLEDAMOUNT,0) AS AMOUNT_BILLED,
            NVL(PB.REIMBAMOUNT,0) AS AMOUNT_RECEIVED,
			CS.REIMBURSEMENT_STATUS_NAME AS STATUS,
			CASE
				WHEN UPPER(TRIM(STATUS)) = ''PAID'' THEN 1
				WHEN UPPER(TRIM(STATUS)) = ''PARTIAL'' THEN 2
				WHEN UPPER(TRIM(STATUS)) = ''PAYABLE'' THEN 3
				WHEN UPPER(TRIM(STATUS)) = ''DENIAL'' THEN 4
				WHEN UPPER(TRIM(STATUS)) = ''WriteOff'' THEN 5 
				WHEN UPPER(TRIM(STATUS)) = ''Pending'' THEN 6
				WHEN UPPER(TRIM(STATUS)) = ''Appealed'' THEN 7
				WHEN UPPER(TRIM(STATUS)) = ''UNKNOWN'' THEN 8
				WHEN UPPER(TRIM(STATUS)) = ''REJECTED'' THEN 9
			END AS PRECEDENCE,
			--ROW_NUMBER() OVER (PARTITION BY AG.SERVICEVISITACTUALID ORDER BY PRECEDENCE ASC, SERVICE_DATE DESC, PAID_DATE DESC NULLS LAST) AS RN, -- TEMP fix TO FILTER OUT dupes
			CASE
		WHEN UPPER(TRIM(STATUS)) IN (''DENIAL'') THEN ''Cancelled''
		WHEN UPPER(TRIM(STATUS)) IN (''PAID'') THEN ''Fully Paid''
		WHEN UPPER(TRIM(STATUS)) IN (''PARTIAL'',''PAYABLE'') THEN  ''Partially Paid''
		WHEN UPPER(TRIM(STATUS)) IN (''PENDING'',''Appealed'') THEN  ''Billed''
		END AS  INVOICE_STATUS
		FROM DISC_${var.SF_ENVIRONMENT}.ASR.ASR_RECEIVABLES  RB 
        LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ASR.ASR_PAYMENTSRECEIVED PB 
        ON RB.BILLINGTRANSACTIONID =PB.BILLINGTRANSACTIONID  
        LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ASR.ASR_CLAIMSTATUSES CS 
        ON PB.CLAIMSTATUS =CS.REIMBURSEMENT_STATUS_ID
        LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ASR.ASR_VISITS V ON V.SERVICEVISITACTUALID = RB.SERVICEVISITACTUALID  
        WHERE RB.BILLINGTRANSACTIONID  IS NOT NULL
        QUALIFY ROW_NUMBER() OVER (PARTITION BY RB.BILLINGTRANSACTIONID ORDER BY COALESCE (SPLIT_PART(PB.PAIDDATE,'' '',0),''12/31/1900'')::DATE   DESC) = 1 )
	  )

,CTE AS(
    	SELECT DISTINCT 13 AS SOURCE_SYSTEM_ID,
         ''PRIME'' AS SYSTEM_CODE
		,  CASE WHEN V.ISCANCELLED = ''True'' AND BS.INVOICE_STATUS IN (''Fully Paid'',''Billed'',''Partially Paid'') THEN  ''Cancelled-Billed''
			WHEN V.ISCANCELLED = ''True'' AND BS.INVOICE_STATUS IN (''Cancelled'') AND TRY_TO_DATE(TRIM(VISITDATE),''MM/DD/YYYY HH12:MI:SS AM'') <= TO_DATE(GETDATE()) THEN  ''Cancelled-Did not happen-Not Billable''
				WHEN V.ISCANCELLED = ''True'' AND BS.INVOICE_STATUS IS NULL AND TRY_TO_DATE(TRIM(VISITDATE),''MM/DD/YYYY HH12:MI:SS AM'') > TO_DATE(GETDATE()) THEN  ''Cancelled-Future-Unbilled''
				WHEN V.ISCANCELLED = ''True'' AND BS.INVOICE_STATUS IS NULL AND TRY_TO_DATE(TRIM(VISITDATE),''MM/DD/YYYY HH12:MI:SS AM'') <= TO_DATE(GETDATE()) THEN  ''Cancelled-Did not happen-Unbilled''
			   WHEN V.RESCHEDULEDTO IS NOT NULL  AND TRY_TO_DATE(COALESCE(TRIM(TIMECHECKEDIN),TRIM(RESCHEDULEDTO)),''MM/DD/YYYY HH12:MI:SS AM'') > TO_DATE(GETDATE())  AND BS.INVOICE_STATUS IN (''Fully Paid'',''Billed'',''Partially Paid'') THEN ''Rescheduled-Future-Billed''
        	   WHEN V.RESCHEDULEDTO IS NOT NULL  AND V.ISCANCELLED = ''False'' AND BS.INVOICE_STATUS IN (''Fully Paid'',''Billed'',''Partially Paid'') THEN ''Rescheduled-Completed-Billed''
        	   WHEN V.RESCHEDULEDTO IS NOT NULL  AND V.ISCANCELLED = ''False'' AND BS.INVOICE_STATUS IN (''Cancelled'') THEN ''Rescheduled-Completed-Not Billable''
			   WHEN V.RESCHEDULEDTO IS NULL  AND V.ISCANCELLED = ''False'' AND BS.INVOICE_STATUS IS NULL AND TRY_TO_DATE(COALESCE(TRIM(TIMECHECKEDIN),TRIM(RESCHEDULEDTO)),''MM/DD/YYYY HH12:MI:SS AM'') > TO_DATE(GETDATE()) THEN ''Scheduled-Future-Unbilled''
        	   WHEN V.RESCHEDULEDTO IS NULL  AND V.ISCANCELLED = ''False'' AND BS.INVOICE_STATUS IN (''Cancelled'') THEN ''Scheduled-Completed-Not Billable''
			   WHEN TRY_TO_DATE(COALESCE(TRIM(TIMECHECKEDIN),TRIM(RESCHEDULEDTO)),''MM/DD/YYYY HH12:MI:SS AM'') > TO_DATE(GETDATE()) AND V.RESCHEDULEDTO IS NULL  AND V.ISCANCELLED = ''False'' AND BS.INVOICE_STATUS IN (''Unbilled'') THEN ''Scheduled-Future-Unbilled''
			   WHEN V.RESCHEDULEDTO IS NULL  AND V.ISCANCELLED = ''False'' AND BS.INVOICE_STATUS IN (''Unbilled'') AND TRY_TO_DATE(TRIM(VISITDATE),''MM/DD/YYYY HH12:MI:SS AM'') > TO_DATE(GETDATE()) THEN ''Scheduled-Future-Unbilled''
        	   WHEN V.RESCHEDULEDTO IS NULL  AND V.ISCANCELLED = ''False'' AND BS.INVOICE_STATUS IN (''Unbilled'') THEN ''Scheduled-Completed-Unbilled''
        	   WHEN V.RESCHEDULEDTO IS NULL  AND V.ISCANCELLED = ''False'' AND BS.INVOICE_STATUS IN (''Fully Paid'',''Billed'',''Partially Paid'') THEN ''Scheduled-Completed-Billed''
			   WHEN V.RESCHEDULEDTO IS NOT NULL AND TRY_TO_DATE(COALESCE(TRIM(TIMECHECKEDIN),TRIM(RESCHEDULEDTO)),''MM/DD/YYYY HH12:MI:SS AM'') > TO_DATE(GETDATE()) AND BS.INVOICE_STATUS IS NULL  THEN ''Rescheduled-Future-Unbilled''
			   WHEN V.RESCHEDULEDTO IS NOT NULL  AND V.ISCANCELLED = ''False'' AND BS.INVOICE_STATUS IS NULL  THEN ''Rescheduled-Completed-Unbilled''
			   WHEN V.RESCHEDULEDTO IS NULL  AND V.ISCANCELLED = ''False'' AND BS.INVOICE_STATUS IS NULL AND TRY_TO_DATE(TRIM(VISITDATE),''MM/DD/YYYY HH12:MI:SS AM'') > TO_DATE(GETDATE()) THEN ''Scheduled-Future-Unbilled''
			   WHEN V.RESCHEDULEDTO IS NULL  AND V.ISCANCELLED = ''False'' AND BS.INVOICE_STATUS IS NULL THEN ''Scheduled-Completed-Unbilled''	  
			END AS DERIVED_DISC_STATUS
         		, NULL AS DISC_SCHEDULE_STATUS
		, NULL AS DISC_VISIT_STATUS
		, NULL AS DISC_INVOICE_STATUS
		, NULL AS DISC_PAYROLL_STATUS
  ,      CASE WHEN V.ISCANCELLED = ''True'' THEN ''s05'' 
  			  WHEN V.RESCHEDULEDTO IS NULL THEN ''s01'' 
  			  WHEN V.RESCHEDULEDTO IS NOT NULL THEN ''s03'' 
  			  WHEN V.EMPLOYEEID IS NULL THEN ''s02'' 
  			  ELSE NULL END AS SCHEDULE_STATUS_CODE,
	     CASE WHEN V.ISCANCELLED = ''True'' THEN ''Cancelled'' 
	       	  WHEN V.RESCHEDULEDTO IS NULL THEN ''Scheduled'' 
	       	  WHEN V.RESCHEDULEDTO IS NOT NULL THEN ''Rescheduled'' 
	       	  WHEN V.EMPLOYEEID IS NULL THEN ''Scheduled - Open'' 
	       	  ELSE NULL END AS SCHEDULE_STATUS_NAME,
	     CASE WHEN V.ISCANCELLED = ''True'' THEN ''Cancelled'' 
	     	  WHEN V.RESCHEDULEDTO IS NULL THEN ''Scheduled'' 
	     	  WHEN V.RESCHEDULEDTO IS NOT NULL THEN ''Rescheduled'' 
	     	  WHEN V.EMPLOYEEID IS NULL THEN ''Scheduled - Open'' 
	     	  ELSE NULL END AS SCHEDULE_STATUS_DESCRIPTION
        , CASE WHEN TRY_TO_DATE(COALESCE(COALESCE(TRIM(TIMECHECKEDIN),TRIM(RESCHEDULEDTO)),TRIM(VISITDATE)),''MM/DD/YYYY HH12:MI:SS AM'') > TO_DATE(GETDATE()) AND V.ISCANCELLED =''False'' THEN  ''v01''
        	    WHEN V.ISCANCELLED = ''True'' THEN ''v03'' 
        	   WHEN V.ISCANCELLED = ''False'' THEN ''v04''
        	   ELSE NULL END AS VISIT_STATUS_CODE
       ,  CASE WHEN TRY_TO_DATE(COALESCE(COALESCE(TRIM(TIMECHECKEDIN),TRIM(RESCHEDULEDTO)),TRIM(VISITDATE)),''MM/DD/YYYY HH12:MI:SS AM'') > TO_DATE(GETDATE()) AND V.ISCANCELLED =''False'' THEN  ''Future''
			   WHEN V.ISCANCELLED = ''True'' THEN ''Did not happen'' 
        	   WHEN V.ISCANCELLED = ''False'' THEN ''Completed''
        	   ELSE NULL END AS VISIT_STATUS_NAME
      ,	  CASE WHEN TRY_TO_DATE(COALESCE(COALESCE(TRIM(TIMECHECKEDIN),TRIM(RESCHEDULEDTO)),TRIM(VISITDATE)),''MM/DD/YYYY HH12:MI:SS AM'') > TO_DATE(GETDATE()) AND V.ISCANCELLED =''False'' THEN  ''Future''
			   WHEN V.ISCANCELLED = ''True'' THEN ''Did not happen'' 
        	   WHEN V.ISCANCELLED = ''False'' THEN ''Completed''
        	   ELSE NULL END AS VISIT_STATUS_DESCRIPTION
        , CASE WHEN BS.INVOICE_STATUS IN (''Fully Paid'',''Billed'',''Partially Paid'') THEN ''i03'' 
        	   WHEN BS.INVOICE_STATUS IN (''Cancelled'') THEN ''i01''
        	   WHEN BS.INVOICE_STATUS IN (''Unbilled'') OR BS.INVOICE_STATUS IS NULL THEN ''i02''
        	   ELSE NULL END AS INVOICE_STATUS_CODE
        , CASE WHEN BS.INVOICE_STATUS IN (''Fully Paid'',''Billed'',''Partially Paid'') THEN ''Billed'' 
        	   WHEN BS.INVOICE_STATUS IN (''Cancelled'') THEN ''Not Billable''
        	   WHEN BS.INVOICE_STATUS IN (''Unbilled'') OR BS.INVOICE_STATUS IS NULL THEN ''Unbilled''
        	   ELSE NULL END AS INVOICE_STATUS_NAME
        ,CASE WHEN BS.INVOICE_STATUS IN (''Fully Paid'',''Billed'',''Partially Paid'') THEN ''Billed'' 
        	   WHEN BS.INVOICE_STATUS IN (''Cancelled'') THEN ''Not Billable''
        	   WHEN BS.INVOICE_STATUS IN (''Unbilled'') OR BS.INVOICE_STATUS IS NULL THEN ''Unbilled''
        	   ELSE NULL END AS INVOICE_STATUS_DESCRIPTION
        , NULL AS PAYROLL_STATUS_CODE
        , NULL AS PAYROLL_STATUS_NAME
        , NULL AS PAYROLL_STATUS_DESCRIPTION
FROM DISC_${var.SF_ENVIRONMENT}.ASR.ASR_VISITS V
LEFT JOIN BILLING_STATUS BS ON BS.BILLINGTRANSACTIONID = V.SERVICEVISITACTUALID )

SELECT DISTINCT MD5(''13'' || ''-'' || ''PRIME'' || ''-'' || NVL(DERIVED_DISC_STATUS,''S'')) AS VISIT_STATUS_KEY,
CTE.*,
CASE WHEN DERIVED_DISC_STATUS IN (''Cancelled-Future-Unbilled'',''Cancelled-Did not happen-Unbilled'',''Cancelled-Did not happen-Not Billable'',''Rescheduled-Future-Unbilled'',''Scheduled-Future-Unbilled'')  THEN ''NO''
	 WHEN DERIVED_DISC_STATUS IN (''Scheduled-Completed-Unbilled'',''Rescheduled-Completed-Billed'',''Scheduled-Completed-Not Billable'',''Scheduled-Completed-Billed'',''Rescheduled-Future-Billed'',''Rescheduled-Completed-Not Billable'',''Rescheduled-Completed-Unbilled'',''Cancelled-Billed'') OR DERIVED_DISC_STATUS IS NULL THEN ''YES'' 
	 ELSE ''UNKNOWN'' END AS CONFIRMED_FLAG,
NULL AS CONSISTENT_FLAG
FROM CTE;

SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

