resource "snowflake_procedure" "DW_HAH_GET_STAGE_CLEARCARE_FACT_VISIT" {
	name ="GET_STAGE_CLEARCARE_FACT_VISIT"
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
-- NAME:  Clear care FACT VISIT
--
-- PURPOSE: Populates Stage FACT VISIT for Clear Care 
--			
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/05/22    SAM HUFF             Initial version
-- 11/3/22	   Ayshwarya			Modify for new fact visit structure
-- 03/11/23    Sagar                Added client_service_key,partner_contract_key
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CLEARCARE_FACT_VISIT
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
),
UPDATED_RECORDS AS 
(SELECT DISTINCT  * FROM
DISC_${var.SF_ENVIRONMENT}.CLEARCARE.carelogs_carelog 
QUALIFY ROW_NUMBER() OVER(PARTITION BY ID,PATIENT_ID ,CAREGIVER_ID  
                            ORDER BY UPDATED DESC) = 1),
 DEDUPE AS   (SELECT   * FROM DISC_${var.SF_ENVIRONMENT}.CLEARCARE.BILLING_CLIENTAUTHORIZATION   
         QUALIFY ROW_NUMBER() OVER (PARTITION BY CLIENT_ID ,AUTHORIZATION_ID,PERIOD ,
         SERVICE_ID,BILL_RATE_NAME, START_DATE ,END_DATE ORDER BY UPDATED DESC)=1
         )
SELECT
		DISTINCT
	MD5(
        CA.AGENCY_ID || ''-'' || CA.ID || ''-'' || '' CLEARCARE''
    ) AS VISIT_KEY
    
	,CA.SHIFT_DATE AS REPORT_DATE
    
    ,MD5(
        AG.AGENCY_ID || ''-'' || AG.NAME || ''-'' || ''CLEARCARE''
    ) AS BRANCH_KEY
    
	,MD5(
        ''CLEARCARE'' ||''-''|| COALESCE(CL.MASTER_ID::INT,CA.PATIENT_ID) ||''-''|| ''CLEARCARE'' 
    ) as CLIENT_KEY
    
	,MD5(
        ''CLEARCARE'' || ''-'' || CA.BILL_RATE_NAME || ''-'' || CA.BILL_RATE_TYPE || ''-'' || NVL(SC.SERVICE_NAME,''-1'') || ''-'' || ''CLEARCARE''
    ) AS CONTRACT_KEY
	,MD5(
        ''CLEARCARE'' || ''-'' || SM.MASTER_ID::INT  || ''-'' || ''CLEARCARE''
    ) AS SCHEDULED_EMPLOYEE_KEY
    
	,MD5(
        ''CLEARCARE'' || ''-'' || COALESCE(EM.MASTER_ID::INT,CA.CAREGIVER_ID)  || ''-'' || ''CLEARCARE''
    ) AS EMPLOYEE_KEY
    
	,16 AS SOURCE_SYSTEM_ID
	,MD5(
        NVL(PM.AGENCY_ID, -1) || ''-'' || NVL(PM.ID, -1) || ''-'' || ''CLEARCARE''
    ) AS SUPERVISOR_KEY
	, MD5(INV.ID || ''-'' || INV.CLIENT_ID || ''-'' || INV.PAYER_ID || ''-'' || ''CLEARCARE'') AS INVOICE_KEY
	, NULL AS PAYROLL_KEY, 
  MD5(''CLEARCARE'' 
                    || ''-'' || CL.MASTER_ID 
                    || ''-'' || AU.AUTHORIZATION_ID 
                    || ''-'' || AU.PERIOD  
                    || ''-'' || COALESCE(SC.SERVICE_NAME,''UNKNOWN'')  
                    || ''-'' || AU.START_DATE 
                    || ''-'' || AU.END_DATE 
                    || ''-'' || AU.BILL_RATE_NAME  
                    || ''-'' || COALESCE(AU.BILL_RATE_ID,-1)   || ''-'' || ''CLEARCARE'') AS CLIENT_SERVICE_KEY,
 MD5(''CLEARCARE'' || ''-'' || NVL(PCM.PAYOR_ID,''-1'') || ''-'' || NVL(SC.SERVICE_NAME,''-1'')  || ''-'' ||  CA.BILL_RATE_NAME  || ''-'' || COALESCE(CA.BILL_RATE_TYPE,''-1'')  || ''-'' || ''CLEARCARE'') AS PARTNER_CONTRACT_SERVICE_KEY, 
  NULL AS BILLING_KEY
    , CA.SHIFT_DATE AS SERVICE_DATE
    , CASE WHEN DAYNAME(CA.SHIFT_DATE) = ''Fri'' THEN DATEADD(day, 7, CA.SHIFT_DATE) 
           WHEN DAYNAME(CA.SHIFT_DATE) = ''Sat'' THEN DATEADD(day, 6, CA.SHIFT_DATE) 
           ELSE NEXT_DAY(DATEADD(day, 7, CA.SHIFT_DATE), ''Fri'') 
           END AS PAYROLL_DATE
    , AG.NAME AS BRANCH_NAME
    , CL.PATIENT_ID AS CLIENT_NUMBER
    , CASE WHEN CA.BILL_RATE_NAME = '''' AND CA.BILL_RATE_TYPE = 4 THEN ''Non-Billable''
         WHEN CA.BILL_RATE_NAME = '''' AND CA.BILL_RATE_TYPE = 3 THEN ''Live-In''
         WHEN CA.BILL_RATE_NAME = '''' AND CA.BILL_RATE_TYPE = 2 THEN ''Per-Visit''
         WHEN CA.BILL_RATE_NAME = '''' AND CA.BILL_RATE_TYPE = 1 THEN ''Hourly''
	     ELSE CA.BILL_RATE_NAME 
	END AS contract_code
	, SM.MASTER_ID::INT AS SCHEDULE_EMPLOYEE_ID
    , EM.MASTER_ID::INT AS EMPLOYEE_ID
    , ''CLEARCARE'' AS SYSTEM_CODE
    , NVL(PM.ID,-1) AS SUPERVISOR_CODE
	, INV.INVOICE_ID AS INVOICE_ID
	, NULL AS CHEQUE_NUMBER
    , CASE WHEN CA.CLOCK_IN_METHOD IN (1, 7, 8, 9, 12) THEN ''TRUE'' ELSE ''FALSE'' END AS CLEAN_SHIFT_FLAG
    , CASE  WHEN S.STATUS = 10 AND  CA.STATUS NOT IN ( 40,50,60,70,120,90) THEN ''s01''
  	  		WHEN S.STATUS = 110 AND  CA.STATUS NOT IN ( 40,50,60,70,120,90) THEN ''s02''
   			WHEN S.STATUS  IN ( 40,50,60,70,120,90,80,20)  AND  CA.STATUS != 30 THEN ''s05''
			END AS SCHEDULE_STATUS_CODE
	 , CASE  WHEN S.STATUS = 10 AND  CA.STATUS NOT IN ( 40,50,60,70,120,90) THEN ''Scheduled''
  	  		WHEN S.STATUS = 110 AND  CA.STATUS NOT IN ( 40,50,60,70,120,90) THEN ''Scheduled-Open''
   			WHEN S.STATUS  IN ( 40,50,60,70,120,90,80,20)  AND  CA.STATUS != 30 THEN ''Cancelled''
			END AS SCHEDULE_STATUS_NAME
	 , CASE  WHEN S.STATUS = 10 AND  CA.STATUS NOT IN ( 40,50,60,70,120,90) THEN ''Scheduled''
  	  		WHEN S.STATUS = 110 AND  CA.STATUS NOT IN ( 40,50,60,70,120,90) THEN ''Scheduled-Open''
   			WHEN S.STATUS  IN ( 40,50,60,70,120,90,80,20)  AND  CA.STATUS != 30 THEN ''Cancelled''
			END AS SCHEDULE_STATUS_DESCRIPTION
	,CASE WHEN  CA.STATUS = 30 THEN  ''v04''
			WHEN  CA.STATUS IN ( 40,50,60,70,120,90) THEN ''v03''
			END AS VISIT_STATUS_CODE
	,CASE WHEN  CA.STATUS = 30 THEN  ''Completed''
			WHEN  CA.STATUS IN ( 40,50,60,70,120,90) THEN ''Did not happen''
			END AS VISIT_STATUS_NAME
	,CASE WHEN  CA.STATUS = 30 THEN  ''Completed''
			WHEN  CA.STATUS IN ( 40,50,60,70,120,90) THEN ''Did not happen''
			END AS VISIT_STATUS_DESCRIPTION
	,CASE WHEN  CA.STATUS = 30 AND BILL_INVOICED = TRUE THEN ''i03''
		  WHEN  CA.STATUS = 30 AND BILL_INVOICED = FALSE THEN ''i02'' 
		  END AS INVOICE_STATUS_CODE
	,CASE WHEN  CA.STATUS = 30 AND BILL_INVOICED = TRUE THEN ''Billed'' 
		  WHEN  CA.STATUS = 30 AND BILL_INVOICED = FALSE THEN ''Unbilled'' 
		  END AS INVOICE_STATUS_NAME
	,CASE WHEN  CA.STATUS = 30 AND BILL_INVOICED = TRUE THEN ''Billed'' 
		  WHEN  CA.STATUS = 30 AND BILL_INVOICED = FALSE THEN ''Unbilled'' 
		  END AS INVOICE_STATUS_DESCRIPTION
	,CASE WHEN  CA.STATUS = 30 AND PAY_FINALIZED = TRUE THEN  ''p03''
		  WHEN  CA.STATUS = 30 AND PAY_FINALIZED = FALSE THEN ''p02''
		  END AS PAYROLL_STATUS_CODE
	,CASE WHEN  CA.STATUS = 30 AND PAY_FINALIZED = TRUE THEN  ''Paid'' 
		  WHEN  CA.STATUS = 30 AND PAY_FINALIZED = FALSE THEN ''Unpaid''
		  END AS PAYROLL_STATUS_NAME
	,CASE WHEN  CA.STATUS = 30 AND PAY_FINALIZED = TRUE THEN  ''Paid'' 
		  WHEN  CA.STATUS = 30 AND PAY_FINALIZED = FALSE THEN ''Unpaid''
		  END AS PAYROLL_STATUS_DESCRIPTION
    /*,CASE 
     WHEN CA.PAY_FINALIZED = TRUE THEN ''05''
       WHEN CA.BILL_FINALIZED = TRUE AND CA.PAY_FINALIZED = FALSE THEN ''04''
        WHEN CA.BILL_INVOICED = TRUE AND CA.BILL_FINALIZED = FALSE THEN ''03''
       WHEN CA.STATUS IN (''50'', ''60'', ''40'') THEN ''10''
        WHEN CA.STATUS IN (''130'') THEN ''01''
        ELSE ''02''
    END AS STATUS_CODE
    , CASE 
        WHEN STATUS_CODE = ''01'' THEN ''Pending''
        WHEN STATUS_CODE = ''02'' THEN ''Confirmed''
        WHEN STATUS_CODE = ''03'' THEN ''In Process''
        WHEN STATUS_CODE = ''04'' THEN ''Billed''
        WHEN STATUS_CODE = ''05'' THEN ''Paid''
        WHEN STATUS_CODE = ''09'' THEN ''Hold''
        WHEN STATUS_CODE = ''10'' THEN ''Cancelled''
      END AS STATUS_DESCRIPTION */
    , CASE 
       WHEN CA.STATUS IN (''50'', ''60'', ''40'')  THEN CA.STATUS
        ELSE NULL
      END AS CANCEL_REASON_CODE
    , CASE 
        WHEN CANCEL_REASON_CODE = ''40'' THEN ''NOT COMPLETE''
        WHEN CANCEL_REASON_CODE = ''50'' THEN ''CANCELLED BY CLIENT''
        WHEN CANCEL_REASON_CODE = ''60'' THEN ''CANCELLED BY CAREGIVER''
        ELSE NULL
      END AS CANCEL_REASON_DESCRIPTION
    , NULL AS CANCEL_REASON_NOTES
    ,''NO'' AS EXCEPTION_REASON_INDICATOR
    , NULL AS RESOLUTION_CODE
    , NULL AS RESOLUTION_DESCRIPTION
    , NULL AS REJECTION_CODE
    , NULL AS REJECTION_DESCRIPTION
    , CONTRACT_CODE AS BILL_CODE
    , CA.BILL_RATE_AMOUNT AS BILL_RATE
	, NVL(CA.TOTAL_HOURS,0) AS BILL_UNITS_SERVED
	,  ''Hourly'' AS BILL_UNIT_TYPE
    , NULL AS OVERHEAD_RATE
	,CCI_SCHEDULED_CLOCK_IN AS SCHEDULE_TIMEIN
	,CCI_SCHEDULED_CLOCK_OUT AS SCHEDULE_TIMEOUT
	,ROUND(DATEDIFF(MINUTE,CCI_SCHEDULED_CLOCK_IN,CCI_SCHEDULED_CLOCK_OUT)/60,2) AS SCHEDULE_DURATION
	,CLOCK_IN AS ACTUAL_TIMEIN
	,CLOCK_OUT AS ACTUAL_TIMEOUT
	,ROUND(DATEDIFF(MINUTE,CLOCK_IN,CLOCK_OUT)/60,2) AS ACTUAL_DURATION
	,NULL AS ADJUSTED_TIMEIN
	,NULL AS ADJUSTED_TIMEOUT
	,NULL AS ADJUSTED_DURATION
    , CASE WHEN BILL_CODE IN (''Non-Billable'') THEN 0
    	ELSE NVL(CA.TOTAL_HOURS,0)
	END AS HOURS_SERVED
    , NULL AS COMMENTS
    
    , CASE WHEN PY.EVV_MANDATED = TRUE THEN ''Y'' ELSE ''N'' END AS IS_EVV_FLAG
    
    , NULL AS TIMESHEET_TYPE
    , NULL AS TRACKING_ID,
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
                        
    , convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	, CURRENT_USER AS ETL_INSERTED_BY
	, convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
	, CURRENT_USER AS ETL_LAST_UPDATED_BY
	, 0 AS ETL_DELETED_FLAG
    , CASE 
        WHEN VISIT_STATUS_NAME = ''Completed'' THEN ''YES''
		WHEN VISIT_STATUS_NAME =  ''Did not happen''  THEN ''NO'' ELSE ''UNKNOWN''
    END AS CONFIRMED_FLAG 
 
FROM UPDATED_RECORDS AS CA
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.profile_patient_agencylocation AS PP ON CA.patient_id = PP.patient_id
LEFT JOIN DEDUPE AU ON AU.ID = CA.AUTHORIZATION_ID --AND AU.CLIENT_ID=CA.PATIENT_ID AND AU.AGENCY_ID =CA.AGENCY_ID 
--AND AU.AUTHORIZATION_ID =CA.AUTHORIZATION_ID::VARCHAR 
--AND AU.BILL_RATE_ID =CA.BILL_RATE_OBJ_ID AND AU.START_DATE BETWEEN CA.CLOCK_IN AND CA.CLOCK_OUT 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.PROFILE_PARENTPAYER PY ON PY.ID = AU.PARENT_PAYER_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.PROFILE_PARENTPAYERSERVICE SC ON SC.ID = AU.SERVICE_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.SCHEDULES_SHIFT S ON S.ID = CA.SHIFT_ID
--KEY JOINS
LEFT JOIN CLIENT CL ON CL.PATIENT_ID = CA.PATIENT_ID AND CL.AGENCY_ID = CA.AGENCY_ID
LEFT JOIN EMPLOYEE EM ON EM.CAREGIVER_ID = CA.CAREGIVER_ID AND EM.AGENCY_ID = CA.AGENCY_ID
LEFT JOIN EMPLOYEE SM ON SM.CAREGIVER_ID = S.CAREGIVER_ID AND SM.AGENCY_ID = CA.AGENCY_ID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.profile_patient_agencylocation AS PM ON PM.ID = PP.PRIMARY_MANAGER_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.PATIENT_PATIENT PA ON PA.ID = CA.PATIENT_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.AGENCY_AGENCYLOCATION AG ON AG.ID = PA.LOCATION_ID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.RECEIVABLES_INVOICE_CARELOGS  R on R.CARELOG_ID  = CA.id
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.CLEARCARE.INVOICE_TRANSACTION INV on INV.id = R.INVOICE_ID 
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.PAYOR_contract_UI.PAYOR_contract_MAPPING PCM ON
    CASE
        WHEN CA.BILL_RATE_NAME = ''''
        AND CA.BILL_RATE_TYPE = 4 THEN ''Non-Billable''
        WHEN CA.BILL_RATE_NAME = ''''
        AND CA.BILL_RATE_TYPE = 3 THEN ''Live-In''
        WHEN CA.BILL_RATE_NAME = ''''
        AND CA.BILL_RATE_TYPE = 2 THEN ''Visit''
        WHEN CA.BILL_RATE_NAME = ''''
        AND CA.BILL_RATE_TYPE = 1 THEN ''Hourly''
        ELSE CA.BILL_RATE_NAME
    END = PCM.CONTRACT_CODE AND PCM.ORIGINAL_SOURCE_SYSTEM_ID=16
WHERE AG.AGENCY_ID IN (2459);
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}

