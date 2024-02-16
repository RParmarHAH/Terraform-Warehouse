resource "snowflake_procedure" "DW_HAH_GET_STAGE_CLEARCARE_FACT_REVENUE" {
	name ="GET_STAGE_CLEARCARE_FACT_REVENUE"
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
    return_result VARCHAR;
BEGIN
--*****************************************************************************************************************************
-- NAME:  Clear care FACT REVENUE
--
-- PURPOSE: Populates Stage FACT REVENUE for Clear Care 
--			
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/05/22    SAM HUFF             Initial version
-- 28/04/23    PINKAL PANCHAL		AMOUNT_BILLED, AMOUNT_COLLECTED,AMOUNT_OUTSTANDING,INVOICE_NUMBER LOGIC CORRECTION FOR RCM
-- 24/11/2023	Preeti Sharma		Added Bill_Unit_Type Column for RCM(Requested By Natalie)
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CLEARCARE_FACT_REVENUE
WITH EMPLOYEE AS 
(
	SELECT
		*
	FROM
		(
		SELECT
			CAREGIVER_ID,
			MASTER_ID,
			AGENCY_ID
		FROM
			DISC_DEDUPE_${var.SF_ENVIRONMENT}.CLEARCARE.EMPLOYEE_MASTER_LIST
	)
	UNION
	SELECT
		*
	FROM
		(
		SELECT
			DISTINCT CAREGIVER_ID,
			MASTER_ID,
			AGENCY_ID
		FROM
			DISC_DEDUPE_${var.SF_ENVIRONMENT}.CLEARCARE.EMPLOYEE_MATCH_LIST
		WHERE
			CAREGIVER_ID NOT IN (
			SELECT
				CAREGIVER_ID
			FROM
				DISC_DEDUPE_${var.SF_ENVIRONMENT}.CLEARCARE.EMPLOYEE_MASTER_LIST ) 
	) 
)
,
	CLIENT AS
(
	SELECT
		*
	FROM
		(
		SELECT
			PATIENT_ID,
			MASTER_ID,
			AGENCY_ID,
			LAST_NAME,
			FIRST_NAME
		FROM
			DISC_DEDUPE_${var.SF_ENVIRONMENT}.CLEARCARE.CLIENT_MASTER_LIST 
	)
	UNION
	SELECT
		*
	FROM
		(
		SELECT
			DISTINCT PATIENT_ID,
			MASTER_ID,
			AGENCY_ID,
			LAST_NAME,
			FIRST_NAME
		FROM
			DISC_DEDUPE_${var.SF_ENVIRONMENT}.CLEARCARE.CLIENT_MATCH_LIST
		WHERE
			PATIENT_ID NOT IN (
			SELECT
				PATIENT_ID
			FROM
				DISC_DEDUPE_${var.SF_ENVIRONMENT}.CLEARCARE.CLIENT_MASTER_LIST ) 
	)
)
SELECT DISTINCT 
	MD5(
        ''CLEARCARE'' ||''-''|| IT.ID ||''-''|| IC.CARELOG_ID ||''-''|| ''CLEARCARE''
    ) AS REVENUE_KEY
    
	,CA.SHIFT_DATE AS REPORT_DATE
    
    ,MD5(
        AG.AGENCY_ID || ''-'' || AG.NAME || ''-'' || ''CLEARCARE''
    ) AS BRANCH_KEY
    
    ,MD5(
        ''CLEARCARE'' || ''-'' || COALESCE(EM.MASTER_ID::INT,CA.CAREGIVER_ID)  || ''-'' || ''CLEARCARE''
    ) AS EMPLOYEE_KEY
    
	,MD5(
        ''CLEARCARE'' ||''-''|| COALESCE(CL.MASTER_ID::INT,CA.PATIENT_ID) ||''-''|| ''CLEARCARE'' 
    ) as CLIENT_KEY
    
	,MD5(
        ''CLEARCARE'' || ''-'' || CA.BILL_RATE_NAME || ''-'' || CA.BILL_RATE_TYPE || ''-'' || NVL(SC.SERVICE_NAME,''-1'') || ''-'' || ''CLEARCARE''
    ) AS CONTRACT_KEY
    
	,MD5(
        IT.ID || ''-'' || IT.CLIENT_ID || ''-'' || IT.PAYER_ID || ''-'' || ''CLEARCARE''
    ) AS INVOICE_KEY
    
	,16 AS SOURCE_SYSTEM_ID
	,MD5(
        NVL(PM.AGENCY_ID,-1) || ''-'' || NVL(PM.ID,-1) || ''-'' || ''CLEARCARE''
    ) AS SUPERVISOR_KEY
    , IT.CREATED AS REVENUE_DATE
    , IT.UPDATED AS PAYMENT_DATE
    , UPPER(AG.NAME) AS BRANCH_NAME
    , EM.MASTER_ID::INT AS EMPLOYEE_ID
    , CL.PATIENT_ID AS CLIENT_NUMBER
    , CA.BILL_RATE_NAME AS CONTRACT_CODE
--    , IT.ID AS INVOICE_NUMBER
	, IT.INVOICE_ID AS INVOICE_NUMBER
    , ''Regular'' AS INVOICE_TYPE
	, ''HOURLY'' AS BILL_UNIT_TYPE
    , 1 AS NUMBER_OF_CLIENTS
    , ''CLEARCARE'' AS SYSTEM_CODE
    , PM.ID AS SUPERVISOR_CODE
    , CA.BILL_RATE_NAME AS BILL_CODE
    , CA.TOTAL_HOURS AS INVOICE_HOURS
    , CA.BILL_RATE_AMOUNT AS INVOICE_RATE
--    , INVOICE_HOURS * INVOICE_RATE AS AMOUNT_BILLED
--    , CASE
--        WHEN IT.OUTSTANDING_BALANCE = 0 THEN AMOUNT_BILLED
--        WHEN CAST(IT.OUTSTANDING_BALANCE AS DECIMAL(8,2)) - CAST(IT.CARELOGS_TOTAL AS DECIMAL(8,2))  = CAST(IT.ITEMS_TOTAL        AS DECIMAL(8,2)) THEN 0
--        ELSE (it.outstanding_balance / (count(*) over (partition by IT.ID order by 1)))::DECIMAL(10,2) --NUMBER OF INVOICES
--    END AS AMOUNT_COLLECTED
--    , AMOUNT_BILLED - AMOUNT_COLLECTED AS AMOUNT_OUTSTANDING,
	, IT.TOTAL/(count(*) over (partition by IT.ID order by 1)) AS AMOUNT_BILLED
	, IT.PAYMENTS_TOTAL/(count(*) over (partition by IT.ID order by 1)) AS AMOUNT_COLLECTED
	, IT.OUTSTANDING_BALANCE/(count(*) over (partition by IT.ID order by 1)) AS AMOUNT_OUTSTANDING,
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
                        
    , CONVERT_TIMEZONE(''UTC'',CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
    , CURRENT_USER as ETL_INSERTED_BY
    , CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_UPDATED_DATE
    , CURRENT_USER AS ETL_LAST_UPDATED_BY
    , 0 AS ETL_DELETED_FLAG
    
   FROM DISC_${var.SF_ENVIRONMENT}.CLEARCARE.invoice_transaction IT
   
   --250 INVOICES WITH NO CARELOG RECORD
   INNER JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.receivables_invoice_carelogs IC ON IC.INVOICE_ID = IT.ID
   LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.carelogs_carelog CA ON CA.ID = IC.CARELOG_ID
   LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.profile_patient_agencylocation PP ON CA.patient_id = PP.patient_id
   LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.BILLING_CLIENTAUTHORIZATION AU ON AU.ID = CA.AUTHORIZATION_ID
   LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.PROFILE_PARENTPAYERSERVICE SC ON SC.ID = AU.SERVICE_ID
   
   LEFT JOIN CLIENT CL ON CL.PATIENT_ID = CA.PATIENT_ID AND CL.AGENCY_ID = CA.AGENCY_ID
   LEFT JOIN EMPLOYEE EM ON EM.CAREGIVER_ID = CA.CAREGIVER_ID AND EM.AGENCY_ID = CA.AGENCY_ID
   LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.PATIENT_PATIENT PA ON PA.ID = CA.PATIENT_ID
   LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.AGENCY_AGENCYLOCATION AG ON AG.id = PA.LOCATION_ID
   LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.profile_patient_agencylocation AS PM ON PM.ID = PP.PRIMARY_MANAGER_ID
   WHERE AG.AGENCY_ID IN (2459);
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}

