resource "snowflake_procedure" "DW_HAH_GET_STAGE_MATRIXCARE_DIM_VISIT_STATUS_MAPPING" {
	name ="GET_STAGE_MATRIXCARE_DIM_VISIT_STATUS_MAPPING"
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
    return_result varchar(1000);
BEGIN

--*****************************************************************************************************************************
-- NAME:  GET_STAGE_MATRIXCARE_DIM_VISIT_STATUS_MAPPING
--
-- PURPOSE: Creates one row per status
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/09/22     Vijay Sharma      Initial Development
-- 01/19/24		Rajat Sapkal 	  Removed s06 SCHEDULE_STATUS_CODE 
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.MATRIXCARE_DIM_VISIT_STATUS_MAPPING
WITH INVOICE_PAYERS AS
	(	
		SELECT DISTINCT INVD_SCHEDULEID --,INH.INVH_ID AS INVH_ID
		,FIRST_VALUE(INH.INVH_ID) OVER(PARTITION BY INVD_SCHEDULEID ORDER BY INVH_INVOICEDATE DESC) INVH_ID
		,FIRST_VALUE(INVD_SCHEDULEPAYERID) OVER(PARTITION BY INVD_SCHEDULEID ORDER BY INVH_INVOICEDATE DESC) INV_PAYERID
		,FIRST_VALUE(INH.ETL_LAST_UPDATED_DATE) OVER(PARTITION BY INVD_SCHEDULEID ORDER BY INVH_INVOICEDATE DESC) ETL_LAST_UPDATED_DATE
		FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEHEADER INH 
	 	JOIN  DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEDETAILS IND ON INH.INVH_ID = IND.INVD_INVHID 
	)
, INVOICE_DETAILS AS 
	(
		SELECT INVOICE_DETAILS.INVD_INVHID AS INVH_ID, 
		SUM(NVL(INVOICE_DETAILS.INVD_TOTALCHARGES, 0) + NVL(INVOICE_DETAILS.INVD_TOTALREVADJUSTMENTS, 0)) AS AMOUNT_BILLED,
		SUM(INVOICE_DETAILS.INVD_TOTALPAYMENTS * -1) AS AMOUNT_COLLECTED, -- Payments are in negative amounts 
		SUM(INVOICE_DETAILS.INVD_BALANCE) AS AMOUNT_OUTSTANDING,
		MAX(PAYMENT_POSTING.POST_POSTEDDATE) AS FINAL_PAYMENT_DATE,
		MAX(GREATEST(NVL(INVOICE_DETAILS.ETL_LAST_UPDATED_DATE, ''1/1/1900''),
				NVL(PAYMENT_POSTING.ETL_LAST_UPDATED_DATE, ''1/1/1900''))) AS ETL_LAST_UPDATED_DATE
		FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEDETAILS AS INVOICE_DETAILS
		LEFT JOIN (
			SELECT POST_INVOICEDETAILID, MAX(POST_POSTEDDATE) AS POST_POSTEDDATE, MAX(ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
			FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_PAYMENTPOSTING
			GROUP BY POST_INVOICEDETAILID
		) AS PAYMENT_POSTING
		ON PAYMENT_POSTING.POST_INVOICEDETAILID = INVOICE_DETAILS.INVD_ID 
		GROUP BY INVOICE_DETAILS.INVD_INVHID
	)
	, INVOICE_STATUS AS
	(
		SELECT SCH.SCH_ID,CASE WHEN INVOICE_HEADER.INVH_CANCELDATE IS NOT NULL THEN ''Cancelled''
			WHEN INVOICE_DETAILS.AMOUNT_COLLECTED >= INVOICE_DETAILS.AMOUNT_BILLED THEN ''Paid''
			WHEN INVOICE_DETAILS.AMOUNT_COLLECTED > 0 THEN ''Partially Paid''
			WHEN INVOICE_DETAILS.AMOUNT_BILLED > 0 THEN ''Billed''
			WHEN NVL(INVOICE_DETAILS.AMOUNT_BILLED, 0) = 0 THEN ''Unbilled''
			ELSE NULL END AS INVOICE_STATUS_NAME			
			FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULES AS SCH
			LEFT JOIN INVOICE_PAYERS INV ON INV.INVD_SCHEDULEID = SCH.SCH_ID
			LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_INVOICEHEADER AS INVOICE_HEADER ON INVOICE_HEADER.INVH_ID = INV.INVH_ID
			LEFT JOIN INVOICE_DETAILS AS INVOICE_DETAILS ON INVOICE_DETAILS.INVH_ID = INVOICE_HEADER.INVH_ID			
	)
	, DISC_STATUS_DATA AS 
	(
		SELECT DISTINCT SCH.SCH_ID,7 AS SOURCE_SYSTEM_ID
		,CASE WHEN SCHSTATUS.SCHST_NAME IN (''NTS'',''NTS_'') THEN ''NTS'' 
		ELSE SCHSTATUS.SCHST_NAME END AS DISC_VISIT_CODE
		,CASE WHEN SCHSTATUS.SCHST_NAME = ''C'' THEN ''Completed''
		WHEN SCHSTATUS.SCHST_NAME = ''COR'' THEN ''Needs Correction''
		WHEN SCHSTATUS.SCHST_NAME = ''CV-19'' THEN ''Covid-19 Hold or Cancel''
		WHEN SCHSTATUS.SCHST_NAME = ''DD-AV'' THEN ''DD Annual Visit''
		WHEN SCHSTATUS.SCHST_NAME = ''DD-QV'' THEN ''DD Quarterly Visit''
		WHEN SCHSTATUS.SCHST_NAME = ''H'' THEN ''Hospitalization'' 
		WHEN SCHSTATUS.SCHST_NAME = ''R'' THEN ''Refused''
		WHEN SCHSTATUS.SCHST_NAME = ''S'' THEN ''Scheduled''
		WHEN SCHSTATUS.SCHST_NAME = ''NS'' THEN ''Caregiver No Show'' 
		WHEN SCHSTATUS.SCHST_NAME = ''T'' THEN ''Telephony Completed'' 
		WHEN SCHSTATUS.SCHST_NAME = ''AVAIL'' THEN ''Available Hours'' 	
	   	WHEN SCHSTATUS.SCHST_NAME = ''HOLD'' THEN ''On Hold- Misc Reason'' 
	   WHEN SCHSTATUS.SCHST_NAME = ''OPEN'' THEN ''Open Shift''
	   WHEN SCHSTATUS.SCHST_NAME = ''XCG'' THEN ''Cancelled by caregiver''
	   WHEN SCHSTATUS.SCHST_NAME = ''XC'' THEN ''Cancelled by client''
	   WHEN SCHSTATUS.SCHST_NAME = ''XO'' THEN ''Cancelled no staff''
   	   WHEN SCHSTATUS.SCHST_NAME = ''XX'' THEN ''Delete Shift''
   	   WHEN SCHSTATUS.SCHST_NAME IN (''NTS'',''NTS_'') THEN ''No Time Sheet''
   	   WHEN SCHSTATUS.SCHST_NAME = ''TCOR'' THEN ''Telephony Needs Correction''
   	   WHEN SCHSTATUS.SCHST_NAME = ''TH'' THEN ''Telehealth''
		ELSE NULL END AS DISC_VISIT_STATUS
		,INVOICE_STATUS_NAME AS DISC_INVOICE_STATUS
		FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULES AS SCH
		LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULESTATUS AS SCHSTATUS 
		ON SCH.SCH_SCHEDULESTATUSID = SCHSTATUS.SCHST_ID
		LEFT JOIN INVOICE_STATUS INVS ON INVS.SCH_ID = SCH.SCH_ID
	)
	, BUSINESS_STATUS_MAPPING_DATA AS
	(
	SELECT SOURCE_SYSTEM_ID
	,''MATRIXCARE'' AS SYSTEM_CODE
	,CASE 
		WHEN DISC_VISIT_STATUS =''Scheduled'' AND SCH.SCH_CAREGIVERID IS NULL AND SCH.SCH_STARTTIME > CURRENT_DATE() THEN ''01OPENFUTURE'' 
		WHEN DISC_VISIT_STATUS =''Scheduled'' AND SCH.SCH_CAREGIVERID IS NOT NULL AND SCH.SCH_STARTTIME > CURRENT_DATE() THEN ''01FUTURE''
		WHEN DISC_VISIT_STATUS =''Scheduled'' AND SCH.SCH_CAREGIVERID IS NULL AND SCH.SCH_STARTTIME <= CURRENT_DATE() THEN ''01OPEN'' 
		WHEN DISC_VISIT_STATUS =''Scheduled'' AND SCH.SCH_CAREGIVERID IS NOT NULL AND SCH.SCH_STARTTIME <= CURRENT_DATE() THEN ''Scheduled'' 
		ELSE DISC_VISIT_STATUS END
		AS DERIVED_DISC_STATUS
	--,NULL AS DERIVED_DISC_STATUS
	,NULL AS DISC_SCHEDULE_STATUS
	,DISC_VISIT_STATUS
	,DISC_INVOICE_STATUS
	, NULL AS DISC_PAYROLL_STATUS
	,CASE  WHEN DISC_VISIT_CODE = ''S'' AND SCH.SCH_CAREGIVERID IS NULL THEN ''s02'' 
		WHEN DISC_VISIT_CODE = ''S'' AND SCH.SCH_CAREGIVERID IS NOT NULL THEN ''s01''
		WHEN DISC_VISIT_CODE = ''NS'' THEN ''s01'' 
		WHEN DISC_VISIT_CODE = ''T'' THEN ''s01'' 
		WHEN DISC_VISIT_CODE = ''AVAIL'' THEN ''s02'' 	
	   WHEN DISC_VISIT_CODE = ''CV-19'' THEN ''s04'' 	
	   WHEN DISC_VISIT_CODE = ''H'' THEN ''s04''
	   WHEN DISC_VISIT_CODE = ''HOLD'' THEN ''s04'' 
	   WHEN DISC_VISIT_CODE = ''OPEN'' THEN ''s02''
	   WHEN DISC_VISIT_CODE = ''XCG'' THEN ''s05''
	   WHEN DISC_VISIT_CODE = ''XC'' THEN ''s05''
	   WHEN DISC_VISIT_CODE = ''XO'' THEN ''s05''
   	   WHEN DISC_VISIT_CODE = ''XX'' THEN ''s05''
	ELSE NULL END AS SCHEDULE_STATUS_CODE
,CASE  WHEN DISC_VISIT_CODE = ''S'' AND SCH.SCH_CAREGIVERID IS NULL THEN ''Scheduled-Open'' 
		WHEN DISC_VISIT_CODE = ''S'' AND SCH.SCH_CAREGIVERID IS NOT NULL THEN ''Scheduled''
		WHEN DISC_VISIT_CODE = ''NS'' THEN ''Scheduled'' 
		WHEN DISC_VISIT_CODE = ''T'' THEN ''Scheduled'' 
		WHEN DISC_VISIT_CODE = ''AVAIL'' THEN ''Scheduled-Open''
		WHEN DISC_VISIT_CODE = ''CV-19'' THEN ''Hold'' 
		WHEN DISC_VISIT_CODE = ''H'' THEN ''Hold'' 
		WHEN DISC_VISIT_CODE = ''HOLD'' THEN ''Hold'' 
		WHEN DISC_VISIT_CODE = ''OPEN'' THEN ''Scheduled-Open''
		 WHEN DISC_VISIT_CODE = ''XCG'' THEN ''Cancelled''
	   WHEN DISC_VISIT_CODE = ''XC'' THEN ''Cancelled''
	   WHEN DISC_VISIT_CODE = ''XO'' THEN ''Cancelled''
   	   WHEN DISC_VISIT_CODE = ''XX'' THEN ''Cancelled''
	ELSE NULL END AS SCHEDULE_STATUS_NAME
	--
	,CASE  WHEN DISC_VISIT_CODE = ''S'' THEN ''A visit is in the future and has not been performed yet or no calls have hit the visit yet (can go to hold or confirmed)'' 
		WHEN DISC_VISIT_CODE = ''NS'' THEN ''Caregiver unable to provide service to client; caregiver didn’t show up and we were unable to staff or client didn’t want a fill in'' 
		WHEN DISC_VISIT_CODE = ''T'' THEN ''Caregiver clocked in and our correctly and shift was marked as completed'' 
		WHEN DISC_VISIT_CODE = ''AVAIL'' THEN ''We don’t use this much but it extra hours that the client has available based on hours authorized but not staffed because it isn’t part of their normally requested schedule . We may put them in as available for supervisors to be aware and work in staffing'' 	
	   WHEN DISC_VISIT_CODE = ''CV-19'' THEN ''Client and/or CG is in quarantine due to covid. Shifted canceled or on hold due to client having covid or refusing staff for covid related concerns.'' 	
	   WHEN DISC_VISIT_CODE = ''H'' THEN ''Client is in hospital''
	   WHEN DISC_VISIT_CODE = ''HOLD'' THEN ''Hold due to multiple reasons some of them are listed below - Client on hold till we get authorization. - Bed bugs in the home. - client moved to another city/state'' 
	   WHEN DISC_VISIT_CODE = ''OPEN'' THEN ''shift client wants staff but we don’t have staff''
	   WHEN DISC_VISIT_CODE = ''XCG'' THEN ''Visit or Schedule is canceled by CG due to he/she take day off or any health issue or any emergency.''
	   WHEN DISC_VISIT_CODE = ''XC'' THEN ''Visit or Schedule is canceled by client due to client is not available at home or he/she does not need a service.''
	   WHEN DISC_VISIT_CODE = ''XO'' THEN ''Visit or Schedule is canceled due to no staff or CG is unable to provide service to client.''
   	   WHEN DISC_VISIT_CODE = ''XX'' THEN ''Cancel due to multiple reasons some of them are listed below - Client on hold. No  authorization. - Caregiver did not work.''
	ELSE NULL END AS SCHEDULE_STATUS_DESCRIPTION 
	--
	,CASE WHEN DISC_VISIT_CODE = ''S'' AND SCH.SCH_STARTTIME > CURRENT_DATE() THEN ''v01''
		WHEN DISC_VISIT_CODE  = ''C'' THEN ''v04'' 
		WHEN DISC_VISIT_CODE  = ''T'' THEN ''v04'' 
		WHEN DISC_VISIT_CODE  = ''AVAIL'' THEN ''v03''
		WHEN DISC_VISIT_CODE  = ''NS'' THEN ''v03''
   		 WHEN DISC_VISIT_CODE  = ''XCG'' THEN ''v03''
   		 WHEN DISC_VISIT_CODE  = ''XC'' THEN ''v03''
   		 WHEN DISC_VISIT_CODE  = ''COR'' THEN ''v02''
   		 WHEN DISC_VISIT_CODE  = ''TCOR'' THEN ''v02''   	
		 WHEN DISC_VISIT_CODE  = ''NTS'' THEN ''v02'' 
		 WHEN DISC_VISIT_CODE  = ''NTS_'' THEN ''v02''
   		 WHEN DISC_VISIT_CODE  = ''XO'' THEN ''v03''
   		 WHEN DISC_VISIT_CODE  = ''XX'' THEN ''v03''
		 WHEN DISC_INVOICE_STATUS = ''Paid'' THEN ''v04'' 
		 WHEN DISC_INVOICE_STATUS = ''Partially Paid'' THEN ''v04'' 
		 WHEN DISC_INVOICE_STATUS = ''Billed'' THEN ''v04'' 
   		 ELSE NULL END AS VISIT_STATUS_CODE		
,CASE WHEN DISC_VISIT_CODE = ''S'' AND SCH.SCH_STARTTIME > CURRENT_DATE() THEN ''Future''
		WHEN DISC_VISIT_CODE  = ''C'' THEN ''Completed''
		WHEN DISC_VISIT_CODE  = ''T'' THEN ''Completed'' 
		WHEN DISC_VISIT_CODE  = ''AVAIL'' THEN ''Did not happen''
		WHEN DISC_VISIT_CODE  = ''NS'' THEN ''Did not happen''
   		 WHEN DISC_VISIT_CODE  = ''XCG'' THEN ''Did not happen''
   		 WHEN DISC_VISIT_CODE  = ''XC'' THEN ''Did not happen''
   		 WHEN DISC_VISIT_CODE  = ''COR'' THEN ''In Review''
   		 WHEN DISC_VISIT_CODE  = ''TCOR'' THEN ''In Review''
		 WHEN DISC_VISIT_CODE  = ''NTS'' THEN ''In Review''
		 WHEN DISC_VISIT_CODE  = ''NTS_'' THEN ''In Review''
   		 WHEN DISC_VISIT_CODE  = ''XO'' THEN ''Did not happen''
   		 WHEN DISC_VISIT_CODE  = ''XX'' THEN ''Did not happen''
		 WHEN DISC_INVOICE_STATUS = ''Paid'' THEN ''Completed'' 
		 WHEN DISC_INVOICE_STATUS = ''Partially Paid'' THEN ''Completed''
		 WHEN DISC_INVOICE_STATUS = ''Billed'' THEN ''Completed''
   		 ELSE NULL END  AS VISIT_STATUS_NAME
   		 --
   		 ,CASE WHEN DISC_VISIT_CODE = ''S'' AND SCH.SCH_STARTTIME > CURRENT_DATE() THEN  ''A visit is in the future and has not been performed yet or no calls have hit the visit yet (can go to hold or confirmed)''
		 WHEN DISC_VISIT_CODE  = ''C'' THEN ''Visit was completed'' 
		WHEN DISC_VISIT_CODE  = ''T'' THEN ''Caregiver clocked in and our correctly and shift was marked as completed'' 
		WHEN DISC_VISIT_CODE  = ''AVAIL'' THEN ''We don’t use this much but it extra hours that the client has available based on hours authorized but not staffed because it isn’t part of their normally requested schedule . We may put them in as available for supervisors to be aware and work in staffing''
		WHEN DISC_VISIT_CODE  = ''NS'' THEN ''Caregiver unable to provide service to client; caregiver didn’t show up and we were unable to staff or client didn’t want a fill in''
   		 WHEN DISC_VISIT_CODE  = ''XCG'' THEN ''Visit or Schedule is canceled by CG due to he/she take day off or any health issue or any emergency.''
   		 WHEN DISC_VISIT_CODE  = ''XC'' THEN ''Visit or Schedule is canceled by client due to client is not available at home or he/she does not need a service.''
   		 WHEN DISC_VISIT_CODE  = ''COR'' THEN ''we should be able to deleted this since we have telephony needs correction but it is a Shift that was completed but something was wrong with the way the caregiver clocked in or out so supervisors need to go back and verify.''
   		 WHEN DISC_VISIT_CODE  = ''TCOR'' THEN ''Shift that was completed but something was wrong with the way the caregiver clocked in or out so supervisors need to go back and verify.''   	
		 WHEN DISC_VISIT_CODE  = ''NTS'' THEN ''visit was scheduled and completed but we didn’t receive the timesheet in time for payroll so we were unable to complete the shift. We could go back and complete once the caregiver turned in the timesheet. 
this should be deleted, we don’t have timesheets anymore'' 
		 WHEN DISC_VISIT_CODE  = ''NTS_'' THEN ''visit was scheduled and completed but we didn’t receive the timesheet in time for payroll so we were unable to complete the shift. We could go back and complete once the caregiver turned in the timesheet. 
this should be deleted, we don’t have timesheets anymore''
   		 WHEN DISC_VISIT_CODE  = ''XO'' THEN ''Visit or Schedule is canceled due to no staff or CG is unable to provide service to client.''
   		 WHEN DISC_VISIT_CODE = ''XX'' THEN ''Cancel due to multiple reasons some of them are listed below - Client on hold. No  authorization. - Caregiver did not work.''
		  WHEN DISC_INVOICE_STATUS = ''Paid'' THEN ''Visit was completed''  
		 WHEN DISC_INVOICE_STATUS = ''Partially Paid'' THEN ''Visit was completed'' 
		 WHEN DISC_INVOICE_STATUS = ''Billed'' THEN ''Visit was completed'' 
   		 ELSE NULL END  AS VISIT_STATUS_DESCRIPTION 
   		 --
   		 ,CASE WHEN DISC_VISIT_CODE = ''AVAIL'' THEN ''i01''
		WHEN DISC_VISIT_CODE = ''NS'' THEN ''i01''
		ELSE CASE WHEN DISC_INVOICE_STATUS = ''Cancelled'' THEN NULL
			WHEN DISC_INVOICE_STATUS = ''Paid'' THEN ''i03''
			WHEN DISC_INVOICE_STATUS = ''Partially Paid'' THEN ''i03''
			WHEN DISC_INVOICE_STATUS = ''Billed'' THEN ''i03''
			WHEN DISC_INVOICE_STATUS = ''Unbilled'' THEN ''i02''
			ELSE NULL END 
		END AS INVOICE_STATUS_CODE
 ,CASE WHEN DISC_VISIT_CODE = ''AVAIL'' THEN ''Not Billable''
		WHEN DISC_VISIT_CODE = ''NS'' THEN ''Not Billable''
		ELSE CASE WHEN  DISC_INVOICE_STATUS = ''Cancelled'' THEN NULL -- ''Cancelled''
			WHEN DISC_INVOICE_STATUS = ''Paid'' THEN ''Billed'' --''Paid''
			WHEN DISC_INVOICE_STATUS = ''Partially Paid'' THEN ''Billed'' --''Partially Paid''
			WHEN DISC_INVOICE_STATUS = ''Billed'' THEN ''Billed''
			WHEN DISC_INVOICE_STATUS = ''Unbilled'' THEN ''Unbilled''
			ELSE NULL END 
		END AS INVOICE_STATUS_NAME 
		--
		,CASE WHEN DISC_VISIT_CODE = ''AVAIL'' THEN ''We don’t use this much but it extra hours that the client has available based on hours authorized but not staffed because it isn’t part of their normally requested schedule . We may put them in as available for supervisors to be aware and work in staffing''
		WHEN DISC_VISIT_CODE = ''NS'' THEN ''Caregiver unable to provide service to client; caregiver didn’t show up and we were unable to staff or client didn’t want a fill in''
		ELSE CASE WHEN DISC_INVOICE_STATUS = ''Cancelled'' THEN NULL
			WHEN DISC_INVOICE_STATUS = ''Paid'' THEN ''visit was confirmed that it happened and billed''
			WHEN DISC_INVOICE_STATUS = ''Partially Paid'' THEN ''visit was confirmed that it happened and billed''
			WHEN DISC_INVOICE_STATUS = ''Billed'' THEN ''visit was confirmed that it happened and billed''
			WHEN DISC_INVOICE_STATUS = ''Unbilled'' THEN ''The visit is complete and has either confirmed on its own or manually confirmed and is ready to bill or pay (can go in process)''
			ELSE NULL END 
		END AS INVOICE_STATUS_DESCRIPTION
		--
		,CASE WHEN DISC_VISIT_CODE = ''AVAIL'' THEN ''p01''
			  WHEN DISC_VISIT_CODE = ''NS'' THEN ''p01''
			  ELSE NULL END AS PAYROLL_STATUS_CODE		
		,CASE WHEN DISC_VISIT_CODE = ''AVAIL'' THEN ''Not Payable''
			  WHEN DISC_VISIT_CODE = ''NS'' THEN ''Not Payable''
			  ELSE NULL END AS PAYROLL_STATUS_NAME
			--  
		,CASE WHEN DISC_VISIT_CODE = ''AVAIL'' THEN ''We don’t use this much but it extra hours that the client has available based on hours authorized but not staffed because it isn’t part of their normally requested schedule . We may put them in as available for supervisors to be aware and work in staffing''
			  WHEN DISC_VISIT_CODE = ''NS'' THEN ''Caregiver unable to provide service to client; caregiver didn’t show up and we were unable to staff or client didn’t want a fill in''
			  ELSE NULL END AS PAYROLL_STATUS_DESCRIPTION	
		--
		,NULL AS CONFIRMED_FLAG
		,NULL AS CONSISTENT_FLAG
		FROM DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULES AS SCH
		LEFT JOIN DISC_${var.SF_ENVIRONMENT}.MATRIXCARE.STVHC_T_SCHEDULESTATUS AS SCHSTATUS ON SCH.SCH_SCHEDULESTATUSID = SCHSTATUS.SCHST_ID
		LEFT JOIN DISC_STATUS_DATA 	ON DISC_STATUS_DATA.SCH_ID = SCH.SCH_ID 
--		AND DISC_STATUS_DATA.DISC_VISIT_CODE = SCHSTATUS.SCHST_NAME 		
	),
	CTE1 AS (
	SELECT DISTINCT	MD5(7  || ''-'' ||''MATRIXCARE'' || ''-'' || NVL(DERIVED_DISC_STATUS,''S'') || ''-'' || NVL(DISC_INVOICE_STATUS,''S'')) AS VISIT_STATUS_KEY,
	SOURCE_SYSTEM_ID,SYSTEM_CODE, DERIVED_DISC_STATUS
	,DISC_SCHEDULE_STATUS,DISC_VISIT_STATUS,DISC_INVOICE_STATUS,DISC_PAYROLL_STATUS
	,SCHEDULE_STATUS_CODE,SCHEDULE_STATUS_NAME,SCHEDULE_STATUS_DESCRIPTION
	,VISIT_STATUS_CODE,VISIT_STATUS_NAME,VISIT_STATUS_DESCRIPTION
	,INVOICE_STATUS_CODE,INVOICE_STATUS_NAME,INVOICE_STATUS_DESCRIPTION
	,PAYROLL_STATUS_CODE,PAYROLL_STATUS_NAME,PAYROLL_STATUS_DESCRIPTION	
	FROM BUSINESS_STATUS_MAPPING_DATA
	ORDER BY DISC_VISIT_STATUS, DISC_INVOICE_STATUS
	)
	SELECT VISIT_STATUS_KEY,SOURCE_SYSTEM_ID,SYSTEM_CODE,DERIVED_DISC_STATUS
	,DISC_SCHEDULE_STATUS,DISC_VISIT_STATUS,DISC_INVOICE_STATUS,DISC_PAYROLL_STATUS
	,SCHEDULE_STATUS_CODE,SCHEDULE_STATUS_NAME,SCHEDULE_STATUS_DESCRIPTION
	,VISIT_STATUS_CODE,VISIT_STATUS_NAME,VISIT_STATUS_DESCRIPTION
	,INVOICE_STATUS_CODE,INVOICE_STATUS_NAME,INVOICE_STATUS_DESCRIPTION
	,PAYROLL_STATUS_CODE,PAYROLL_STATUS_NAME,PAYROLL_STATUS_DESCRIPTION	
	,CASE WHEN DERIVED_DISC_STATUS IN (''Completed'',''Telephony Completed'',''Billed'',''Paid'',''Partially Paid'') THEN ''YES''
		  WHEN DERIVED_DISC_STATUS IN (''Available Hours'',''Needs Correction'',''Covid-19 Hold or Cancel'',''DD Annual Visit'',''DD Quarterly''
										,''DD Quarterly Visit'',''DD-Quarterly Visit'',''Hospitalization'',''On Hold- Misc Reason'',''Caregiver No Show''
										,''No Time Sheet'',''Open Shift'',''Refused'',''Scheduled'',''Telephony Needs Correction'',''Cancelled by client''
										,''Cancelled by caregiver'',''Cancelled no staff'',''Delete Shift''
										,''01OPEN'',''01OPENFUTURE'',''01FUTURE''
										,''Unbilled'') THEN ''NO'' 		 
		 ELSE ''UNKNOWN'' END AS CONFIRMED_FLAG
	,NULL AS CONSISTENT_FLAG	
	FROM CTE1;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

