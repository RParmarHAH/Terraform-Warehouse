resource "snowflake_procedure" "DW_HAH_GET_STAGE_PREFERRED_FACT_VISIT_MV" {
	name ="GET_STAGE_PREFERRED_FACT_VISIT_MV"
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
-- NAME:  PREFERRED_FACT_VISIT
--
-- PURPOSE: Creates one row per visit according to PREFERRED 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 04/25/22     Moin Saiyed          Initial development
-- 06/02/22	    Mohit Vaghadiya		 Updated the logic of Is EVV Flag - going with IVRCALLIN and OUT
-- 07/29/22		Mohit Vaghadiya		 Using DIM_EMPLOYEE and DIM_CLIENT to use the CLIENT and EMPLOYEE KEY 
--									 as client may have moved to other agency, due to which it was generating
--									 different client key which was not there in DIM_CLIENT
-- 09/10/2022	Mohit Vaghadiya		 Removed Join for include/exclude contract and directly used
--									 used AgencyMapping Join to pull the data based on AgencyID
--									 and OfficeID (No Change in functionality)
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.PREFERRED_FACT_VISIT
WITH EMPLOYEE AS 
(
	SELECT * FROM
	(
		SELECT CAREGIVERID, MASTER_ID, AGENCYID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.EMPLOYEE_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT CAREGIVERID, MASTER_ID, AGENCYID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.EMPLOYEE_MATCH_LIST
		WHERE CAREGIVERID NOT IN (SELECT CAREGIVERID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.EMPLOYEE_MASTER_LIST ) 
	) 
), CLIENT AS
(
	SELECT * FROM
	(
		SELECT PATIENTID, MASTER_ID, AGENCYID, LASTNAME, FIRSTNAME, OFFICEID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.CLIENT_MASTER_LIST 
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT PATIENTID, MASTER_ID, AGENCYID, LASTNAME, FIRSTNAME, OFFICEID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.CLIENT_MATCH_LIST
		WHERE PATIENTID NOT IN (SELECT PATIENTID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.CLIENT_MASTER_LIST ) 
	)
), AGENCY_CONTRACTS_INCLUDE AS
(
	SELECT CONFIG.AGENCYID, INCLUDE_ALL_CONTRACTS, GET(CONTRACT.VALUE, ''CONTRACTID'')::STRING AS CONTRACTID
	FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.AGENCY_MAPPING CONFIG
		, TABLE(FLATTEN(PARSE_JSON(CONFIG.CONTRACTS_TO_INCLUDE), OUTER => TRUE)) CONTRACT
	WHERE CONFIG.ISACTIVE = TRUE
), AGENCY_CONTRACTS_EXCLUDE AS
(
	SELECT CONFIG.AGENCYID, INCLUDE_ALL_CONTRACTS, GET(CONTRACT.VALUE, ''CONTRACTID'')::STRING AS CONTRACTID
	FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.AGENCY_MAPPING CONFIG
		, TABLE(FLATTEN(PARSE_JSON(CONFIG.CONTRACTS_TO_EXCLUDE), OUTER => TRUE)) CONTRACT
	WHERE CONFIG.ISACTIVE = TRUE
			AND CONFIG.CONTRACTS_TO_EXCLUDE IS NOT NULL
), AGENCY_OFFICES_INCLUDE AS
(
	SELECT CONFIG.AGENCYID, INCLUDE_ALL_OFFICES, GET(CONTRACT.VALUE, ''OFFICEID'')::STRING AS OFFICEID
	FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.AGENCY_MAPPING CONFIG
		, TABLE(FLATTEN(PARSE_JSON(CONFIG.OFFICES_TO_INCLUDE), OUTER => TRUE)) CONTRACT
	WHERE CONFIG.ISACTIVE = TRUE
), AGENCY_OFFICES_EXCLUDE AS
(
	SELECT CONFIG.AGENCYID, INCLUDE_ALL_OFFICES, GET(CONTRACT.VALUE, ''OFFICEID'')::STRING AS OFFICEID
	FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.AGENCY_MAPPING CONFIG
		, TABLE(FLATTEN(PARSE_JSON(CONFIG.OFFICES_TO_EXCLUDE), OUTER => TRUE)) CONTRACT
	WHERE CONFIG.ISACTIVE = TRUE
			AND CONFIG.OFFICES_TO_EXCLUDE IS NOT NULL
), COORDINATOR AS
(
	SELECT P.PATIENTID, LASTNAME, FIRSTNAME, PC1.COORDINATORID AS COORDINATORID1
			, PC1.COORDINATORNAME AS COORDINATORNAME1
	FROM CLIENT P
	JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.PROVIDERPATIENTCOORDINATORS PC1 
		ON P.PATIENTID = PC1.PATIENTID
			AND P.AGENCYID = PC1.AGENCYID
			AND PC1.COORDINATORSRNO = 1
), PREFERRED_REVENUE_SEG AS
(
	SELECT VISITID, REVENUE_CATEGORY, REVENUE_SUBCATEGORY_NAME, REVENUE_SUBCATEGORY_CODE 
	FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.REVENUE_MAPPING
	GROUP BY VISITID, REVENUE_CATEGORY, REVENUE_SUBCATEGORY_NAME, REVENUE_SUBCATEGORY_CODE
), VISIT_DATA AS
(
	SELECT DISTINCT
			MD5(''PREFERRED'' || ''-'' || VISITS.VISITID || ''-'' || '' PREFERRED'') AS VISIT_KEY
			, DATE_TRUNC (DAY, VR.VISITDATE) AS REPORT_DATE
			, MD5(''PREFERRED'' || ''-'' || ''PREFERRED CORPORATE OFFICE'' || ''-'' || ''PREFERRED'') AS BRANCH_KEY
			, DC.CLIENT_KEY AS CLIENT_KEY
			, MD5(VISITS.AGENCYID || ''-'' || NVL(SC.CONTRACTID,-1) || ''-'' || NVL(CR.CONTRACTRATEID, -1) || 
				''-'' || NVL(SC.SERVICECODEID, -1) || 
				''-'' || NVL(PS.REVENUE_SUBCATEGORY_CODE, ''UNKNOWN'') || ''PREFERRED'') AS CONTRACT_KEY
			, DE.EMPLOYEE_KEY AS EMPLOYEE_KEY
			, 17 AS SOURCE_SYSTEM_ID
			, MD5(''PREFERRED'' || ''-'' || VISITS.AGENCYID || ''-'' 
					|| NVL(COORDINATOR.COORDINATORID1,-1) 
					|| ''-'' || ''PREFERRED'') AS SUPERVISOR_KEY
			, DATE_TRUNC(DAY, VR.VISITDATE) AS SERVICE_DATE
			, DATE_TRUNC(DAY, PAYROLL.PAYROLLDATE) AS PAYROLL_DATE
			, ''PREFERRED CORPORATE OFFICE'' AS BRANCH_NAME 
			, DC.CLIENT_NUMBER AS CLIENT_NUMBER
			, NVL(TO_VARCHAR(SC.CONTRACTID), ''Unknown'') AS CONTRACT_CODE
			, TO_NUMBER(DE.EMPLOYEE_ID) AS EMPLOYEE_ID
			, ''PREFERRED'' AS SYSTEM_CODE
			, COORDINATOR.COORDINATORID1 AS SUPERVISOR_CODE 
			, FALSE AS CLEAN_SHIFT_FLAG
			, CASE WHEN VR.ISMISSEDVISIT = 1 
						THEN ''10''
					WHEN VR.BILLED = 1 AND INVOICE.visitpaymentstatus = ''0'' 
						THEN ''04''
					WHEN VR.BILLED = 0 AND INVOICE.visitpaymentstatus IS NULL
							AND VR.VISITSTARTTIME::DATE < GETDATE()
							AND VR.VISITENDTIME::DATE < GETDATE() 
						THEN ''02''
					WHEN INVOICE.visitpaymentstatus = ''1'' 
						THEN ''05''
					WHEN INVOICE.visitpaymentstatus = ''2'' 
						THEN ''03''
					ELSE ''01''
			  END STATUS_CODE
			 --Payment Status OF HHA Possible Values: 1 (Paid), 2(Partially Paid), 0 (Open)
			 --Payment Status OF HAH Possible Values:1	Pending,2 Confirmed,3 In Process,4 Billed,5 Paid,9 Hold,10 Canceled,10 Cancelled
			, CASE WHEN VR.ISMISSEDVISIT = 1 
						THEN ''Cancelled''
					WHEN VR.BILLED = 1 AND INVOICE.visitpaymentstatus = ''0'' 
						THEN ''Billed''
					WHEN VR.BILLED = 0 AND INVOICE.visitpaymentstatus IS NULL
						AND VR.VISITSTARTTIME::DATE < GETDATE()
						AND VR.VISITENDTIME::DATE < GETDATE() 
						THEN ''Confirmed''
					WHEN INVOICE.visitpaymentstatus = ''1'' 
						THEN ''Paid''
					WHEN INVOICE.visitpaymentstatus = ''2'' 
						THEN ''In Process''
					ELSE ''Pending''
			  END STATUS_DESCRIPTION
			, NULL AS CANCEL_REASON_CODE
			, NULL AS CANCEL_REASON_DESCRIPTION
			, NULL AS CANCEL_REASON_NOTES
			, FALSE AS EXCEPTION_REASON_FLAG
			, NULL AS RESOLUTION_CODE
			, NULL AS RESOLUTION_DESCRIPTION
			, NULL AS REJECTION_CODE
			, NULL AS REJECTION_DESCRIPTION
			, NVL(TO_VARCHAR(SC.SERVICECODE), ''Unknown'') AS BILL_CODE
			, COALESCE(INVOICE.BILLEDRATE,0)  AS BILL_RATE 
			, NULL AS OVERHEAD_RATE
			, CASE WHEN (VS.MISSEDVISIT = ''N'' AND VS.IVRCallIn IS NOT NULL AND VS.IVRCallOut IS NOT NULL) 
						OR (VS.MISSEDVISIT = ''N'' AND (VS.IVRCallIn IS NULL OR VS.IVRCallOut IS NULL) 
									AND (VS.VISITSTARTTIME IS NOT NULL AND VS.VISITENDTIME IS NOT NULL) 
									AND VS.TimesheetReceived = ''Y'' AND VS.TimesheetRequired = ''Y''
							)
						OR (VS.VISITSTARTTIME IS NOT NULL AND VS.VISITENDTIME IS NOT NULL 
							AND VS.MISSEDVISIT = ''N'' AND VS.TimesheetReceived =''N'' 
							AND VS.TimesheetRequired = ''N''
							)
						THEN
						  	CASE WHEN CHARINDEX(''T1020'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VR.VISITSTARTTIME, VR.VISITENDTIME)/60.0,0) > 13 THEN 13
				               WHEN CHARINDEX(''S5126'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VR.VISITSTARTTIME, VR.VISITENDTIME)/60.0,0) > 13 THEN 13
				               WHEN CHARINDEX(''S5151'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VR.VISITSTARTTIME, VR.VISITENDTIME)/60.0,0) > 13 THEN 13
				               WHEN CHARINDEX(''PCA LEVEL II LIVE IN 263200'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VR.VISITSTARTTIME, VR.VISITENDTIME)/60.0,0) > 13 THEN 13
				               WHEN CHARINDEX(''HHA LIVE IN'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VR.VISITSTARTTIME, VR.VISITENDTIME)/60.0,0) > 13 THEN 13
				               WHEN CHARINDEX(''C LIVE IN'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VR.VISITSTARTTIME, VR.VISITENDTIME)/60.0,0) > 13 THEN 13
				               WHEN CHARINDEX(''PCA LIVE-IN'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VR.VISITSTARTTIME, VR.VISITENDTIME)/60.0,0) > 13 THEN 13
				               WHEN CHARINDEX(''HHA LIVE-IN OVERTIME'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VR.VISITSTARTTIME, VR.VISITENDTIME)/60.0,0) > 13 THEN 13
				               WHEN CHARINDEX(''2405004 LIVE IN'', SC.SERVICECODE) > 0 AND IFNULL(DATEDIFF("MI",VR.VISITSTARTTIME, VR.VISITENDTIME)/60.0,0) > 13 THEN 13
				               ELSE IFNULL(DATEDIFF("MI",VR.VISITSTARTTIME, VR.VISITENDTIME)/60.0,0)
				          	END
				   ELSE 0
			  END AS HOURS_SERVED
			, NULL AS COMMENTS
			, IFF(VS.IVRCALLIN IS NOT NULL AND VS.IVRCALLOUT IS NOT NULL AND VR.ISMISSEDVISIT != 1, ''Y'', ''N'') AS IS_EVV_FLAG
			, NULL AS TIMESHEET_TYPE
			, NULL AS TRACKING_ID,
			-- ETL Fields
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
                        
       		, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
	   		, CURRENT_USER AS ETL_INSERTED_BY, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
	    	, CURRENT_USER AS ETL_LAST_UPDATED_BY
	    	, 0 AS ETL_DELETED_FLAG
	FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.VISITINFO_REPL VISITS
	JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.TBLVISITS_REPL VR
		ON VISITS.VISITID = VR.VISITID
			AND VISITS.AGENCYID = VR.AGENCYID
	INNER JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.VISITS VS
		ON VS.VISITID = VR.VISITID 
	JOIN CLIENT C
		ON VR.PATIENTID = C.PATIENTID
			AND VISITS.AGENCYID = C.AGENCYID
	INNER JOIN HAH.DIM_CLIENT DC
		ON DC.CLIENT_NUMBER = C.MASTER_ID
			AND DC.SYSTEM_CODE = ''PREFERRED''
	JOIN EMPLOYEE E
		ON VR.CAREGIVERID = E.CAREGIVERID
			AND VISITS.AGENCYID = E.AGENCYID
	INNER JOIN HAH.DIM_EMPLOYEE DE
		ON DE.EMPLOYEE_ID = E.MASTER_ID
			AND DE.SYSTEM_CODE = ''PREFERRED''
	INNER JOIN AGENCY_OFFICES_INCLUDE OFFICES_I
		ON OFFICES_I.AGENCYID = VISITS.AGENCYID
			AND VISITS.OFFICEID = OFFICES_I.OFFICEID
	LEFT JOIN PREFERRED_REVENUE_SEG PS
		ON PS.VISITID = VISITS.VISITID 
	LEFT JOIN COORDINATOR
		ON C.PATIENTID = COORDINATOR.PATIENTID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.SERVICECODES SC 
		ON VISITS.PRIMARYSERVICECODEID = SC.SERVICECODEID
			AND  VISITS.AGENCYID = SC.AGENCYID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.CONTRACTS 
		ON SC.CONTRACTID = CONTRACTS.CONTRACTID
			AND VISITS.AGENCYID = CONTRACTS.AGENCYID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.STAGE_PAYER_REPL SP
		ON SP.PAYERID = SC.CONTRACTID
			AND SP.AGENCYID = VISITS.AGENCYID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.CONTRACTRATES CR
		ON CONTRACTS.CONTRACTID = CR.CONTRACTID
			AND CONTRACTS.AGENCYID = CR.AGENCYID
			AND SC.SERVICECODEID = CR.SERVICECODEID
			AND CR.TODATE::DATE > GETDATE()
			AND CR.FROMDATE::DATE <= GETDATE()
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.PAYROLL_VISITS_REPL PAYROLL 
		ON VISITS.VISITID = PAYROLL.VISITID
			AND VISITS.AGENCYID = PAYROLL.AGENCYID
	LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.TBLINVOICEDETAILS_REPL INVOICE
		ON VISITS.VISITID = INVOICE.VISITID AND VISITS.PRIMARYSERVICECODEID = INVOICE.INVSERVICECODEID 
)
SELECT V.VISIT_KEY
		, V.REPORT_DATE
		, V.BRANCH_KEY
		, V.CLIENT_KEY
		, V.CONTRACT_KEY
		, V.EMPLOYEE_KEY
		, V.SOURCE_SYSTEM_ID
		, V.SUPERVISOR_KEY
		, V.SERVICE_DATE
		, V.PAYROLL_DATE
		, V.BRANCH_NAME
		, V.CLIENT_NUMBER
		, V.CONTRACT_CODE
		, V.EMPLOYEE_ID
		, V.SYSTEM_CODE
		, V.SUPERVISOR_CODE
		, V.CLEAN_SHIFT_FLAG
		, V.STATUS_CODE
		, V.STATUS_DESCRIPTION
		, V.CANCEL_REASON_CODE
		, V.CANCEL_REASON_DESCRIPTION
		, V.CANCEL_REASON_NOTES
		, V.EXCEPTION_REASON_FLAG
		, V.RESOLUTION_CODE
		, V.RESOLUTION_DESCRIPTION
		, V.REJECTION_CODE
		, V.REJECTION_DESCRIPTION
		, V.BILL_CODE
		, V.BILL_RATE
		, V.OVERHEAD_RATE
		, V.HOURS_SERVED
		, V.COMMENTS
		, V.IS_EVV_FLAG
		, V.TIMESHEET_TYPE
		, V.TRACKING_ID
		, V.ETL_TASK_KEY
		, V.ETL_INSERTED_TASK_KEY 
		, V.ETL_INSERTED_DATE 
		, V.ETL_INSERTED_BY 
		, V.ETL_LAST_UPDATED_DATE 
		, V.ETL_LAST_UPDATED_BY 
		, V.ETL_DELETED_FLAG
FROM VISIT_DATA V ;
;
    RETURN ''SUCCESS'';
    END;
    
 EOT
}

