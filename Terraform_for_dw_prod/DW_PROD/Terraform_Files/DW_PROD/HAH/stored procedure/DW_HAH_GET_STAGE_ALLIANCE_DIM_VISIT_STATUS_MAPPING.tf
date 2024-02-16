resource "snowflake_procedure" "DW_HAH_GET_STAGE_ALLIANCE_DIM_VISIT_STATUS_MAPPING" {
	name ="GET_STAGE_ALLIANCE_DIM_VISIT_STATUS_MAPPING"
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
-- NAME:  ALLIANCE_DIM_VISIT_STATUS_MAPPING
--
-- PURPOSE: Creates one row per visit according to ALLIANCE Visit status
--
-- DEVELOPMENT LOG:
-- DATE        	  AUTHOR                	NOTES:
-- ----------     -------------------   	-----------------------------------------------------------------------------------------------
-- 11/02/2022     Mohit Vaghadiya         	Initial development
-- 01/19/24	   Shubham Khunare	     		schedule/visit Status name correction
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.ALLIANCE_DIM_VISIT_STATUS_MAPPING 
WITH ALLIANCE_STATUS_MAPPING AS
(
SELECT 19 AS SOURCE_SYSTEM_ID
        , ''ALLIANCE'' AS SYSTEM_CODE
        , CASE WHEN NOT(NVL(SC.ISCONFIRMED, 0)) AND NOT(S.DESCRIPTION ILIKE ''%NON%BILL%'') 
        			AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0)) AND SC.DATE::DATE > GETDATE()::DATE
                           THEN ''Scheduled''
               WHEN NOT(NVL(SC.ISCONFIRMED, 0)) AND S.DESCRIPTION ILIKE ''%NON%BILL%'' 
               		AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0)) AND SC.DATE::DATE > GETDATE()::DATE
                           THEN ''Scheduled-Not Billable-Not Payable''
	           WHEN NVL(TSD.BILLED, 0) AND NVL(SC.ISCONFIRMED, 0) AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0))
	           		AND NOT(S.DESCRIPTION ILIKE ''%NON%BILL%'') AND NVL(TSD.PAID, 0)
                        THEN ''Billed-Paid''
               WHEN NVL(TSD.BILLED, 0) AND NVL(SC.ISCONFIRMED, 0) AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0))
	           		AND NOT(S.DESCRIPTION ILIKE ''%NON%BILL%'') AND NOT(NVL(TSD.PAID, 0))
                        THEN ''Billed-Unpaid''
               WHEN NOT(NVL(TSD.BILLED, 0)) AND NOT(NVL(SC.ISCONFIRMED, 0))
                    AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0)) AND SC.DATE::DATE <= GETDATE()::DATE
                        THEN ''Missed''
               WHEN NOT(NVL(TSD.BILLED, 0)) AND NVL(SC.ISCANCELLEDSHIFT, 0) 
               		AND SC.DATE::DATE <= GETDATE()::DATE
                           THEN ''Cancelled-Did not happen''
               WHEN NOT(NVL(TSD.BILLED, 0)) AND NVL(SC.ISCANCELLEDSHIFT, 0) 
               		AND SC.DATE::DATE > GETDATE()::DATE
                           THEN ''Cancelled''
               WHEN NVL(SC.ISCONFIRMED, 0) AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0)) 
               		AND S.DESCRIPTION ILIKE ''%NON%BILL%'' 
                           THEN ''Completed-Not Billable-Not Payable''
               WHEN NVL(SC.ISCONFIRMED, 0) AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0)) 
               		AND NOT(NVL(TSD.BILLED, 0)) AND NOT(NVL(TSD.PAID, 0))
               		AND NOT(S.DESCRIPTION ILIKE ''%NON%BILL%'' )
                           THEN ''Completed-Unbilled-Unpaid''
			   WHEN NVL(SC.ISCONFIRMED, 0) AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0)) 
			   		AND NOT(NVL(TSD.BILLED, 0)) AND NVL(TSD.PAID, 0)
                           THEN ''Completed-Unbilled-Paid''
               WHEN NVL(SC.ISCONFIRMED, 0) AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0)) 
                           THEN ''Completed''
               ELSE NULL
          END AS DERIVED_DISC_STATUS
        , NULL AS DISC_SCHEDULE_STATUS
        , NULL AS DISC_VISIT_STATUS
        , NULL AS DISC_INVOICE_STATUS
        , NULL AS DISC_PAYROLL_STATUS
        , CASE WHEN SC.SOCIALSECNUM IS NOT NULL AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0))
                        THEN ''s01''
               WHEN SC.SOCIALSECNUM IS NULL
                           THEN ''s02''
               WHEN SC.SOCIALSECNUM IS NOT NULL AND NVL(SC.ISCANCELLEDSHIFT, 0)
                        THEN ''s03''
               ELSE NULL
          END SCHEDULE_STATUS_CODE
        , DECODE(SCHEDULE_STATUS_CODE
                    , ''s01'', ''Scheduled''
                    , ''s02'', ''Scheduled-Open''
                    , ''s03'', ''Rescheduled''
                    , NULL
                ) AS SCHEDULE_STATUS_NAME
        , SCHEDULE_STATUS_NAME AS SCHEDULE_STATUS_DESCRIPTION
        , CASE WHEN NVL(SC.ISCONFIRMED, 0) AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0)) AND SC.DATE::DATE <= GETDATE()::DATE
                        THEN ''v04'' -- ''Completed''
               WHEN (NOT(NVL(SC.ISCONFIRMED, 0)) OR NVL(SC.ISCANCELLEDSHIFT, 0)) AND SC.DATE::DATE <= GETDATE()::DATE
                        THEN ''v03'' -- ''Did not happen''    
               WHEN NOT(NVL(SC.ISCONFIRMED, 0)) AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0)) AND SC.DATE::DATE > GETDATE()::DATE
                        THEN ''v01'' -- ''Future''
          END VISIT_STATUS_CODE
        , DECODE(VISIT_STATUS_CODE
                    , ''v01'', ''Future''
                    , ''v03'', ''Did not happen''
                    , ''v04'', ''Completed''
                    , NULL
                ) AS VISIT_STATUS_NAME
        , VISIT_STATUS_NAME AS VISIT_STATUS_DESCRIPTION
        , CASE WHEN S.DESCRIPTION ILIKE ''%NON%BILL%'' 
        			AND ((NVL(SC.ISCONFIRMED, 0) AND SC."DATE"::DATE <= GETDATE()::DATE) 
        					OR SC."DATE"::DATE > GETDATE()::DATE)
        				THEN ''i01'' -- ''Not Billable''
               WHEN NVL(SC.ISCONFIRMED, 0) AND NOT(NVL(TSD.BILLED, 0)) AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0)) THEN ''i02'' -- ''Unbilled''
               WHEN NVL(TSD.BILLED, 0) THEN ''i03'' -- ''Billed''               
          END INVOICE_STATUS_CODE
        , DECODE(INVOICE_STATUS_CODE
                    , ''i01'', ''Not Billable''
                    , ''i02'', ''Unbilled''
                    , ''i03'', ''Billed''
                    , NULL
                ) AS INVOICE_STATUS_NAME
        , NULL AS INVOICE_STATUS_DESCRIPTION
        , CASE WHEN S.DESCRIPTION ILIKE ''%NON%BILL%'' 
        			AND ((NVL(SC.ISCONFIRMED, 0) AND SC."DATE"::DATE <= GETDATE()::DATE) 
        					OR SC."DATE"::DATE > GETDATE()::DATE)
        			THEN ''p01'' -- ''Not Payable''
               WHEN NVL(SC.ISCONFIRMED, 0) AND NOT(NVL(TSD.PAID, 0)) AND NOT(NVL(SC.ISCANCELLEDSHIFT, 0)) THEN ''p02'' -- ''Unpaid''
               WHEN NVL(TSD.PAID, 0) THEN ''p03'' -- ''Paid''               
          END PAYROLL_STATUS_CODE
        , DECODE(PAYROLL_STATUS_CODE
                    , ''p01'', ''Not Payable''
                    , ''p02'', ''Unpaid''
                    , ''p03'', ''Paid''
                    , NULL
                ) AS PAYROLL_STATUS_NAME
        , NULL AS PAYROLL_STATUS_DESCRIPTION
FROM DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.SCHEDULES SC
INNER JOIN DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.SERVICES S
    ON S.SERVICECODE = SC.SERVICECODE
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.GENERATIONSALLIANCE.TIMESHEETDETAIL TSD
    ON SC.SCHEDULEID = TSD.SCHEDULEID
)
SELECT DISTINCT MD5(''19'' || ''-'' || ''ALLIANCE'' || ''-'' || NVL(ASM.DERIVED_DISC_STATUS,''S'')) AS VISIT_STATUS_KEY
				, ASM.SOURCE_SYSTEM_ID
				, ASM.SYSTEM_CODE
				, ASM.DERIVED_DISC_STATUS
				, ASM.DISC_SCHEDULE_STATUS
				, ASM.DISC_VISIT_STATUS
				, ASM.DISC_INVOICE_STATUS
				, ASM.DISC_PAYROLL_STATUS
				, ASM.SCHEDULE_STATUS_CODE
				, ASM.SCHEDULE_STATUS_NAME
				, ASM.SCHEDULE_STATUS_DESCRIPTION
				, ASM.VISIT_STATUS_CODE
				, ASM.VISIT_STATUS_NAME
				, ASM.VISIT_STATUS_DESCRIPTION
				, ASM.INVOICE_STATUS_CODE
				, ASM.INVOICE_STATUS_NAME
				, ASM.INVOICE_STATUS_DESCRIPTION
				, ASM.PAYROLL_STATUS_CODE
				, ASM.PAYROLL_STATUS_NAME
				, ASM.PAYROLL_STATUS_DESCRIPTION
				, CASE WHEN ASM.VISIT_STATUS_NAME IN (''Completed'')
					 		THEN ''YES''
					   WHEN ASM.VISIT_sTATUS_NAME IN (''Future'', ''Did not happen'') OR DERIVED_DISC_STATUS IS NULL
					 		THEN ''NO''
					   ELSE ''UNKNOWN''
				  END AS CONFIRMED_FLAG
				, NULL AS CONSISTENT_FLAG 
FROM ALLIANCE_STATUS_MAPPING ASM;
RETURN ''Done'';
END
 EOT
}

