CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ALLIANCE_FACT_VISIT("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS 'BEGIN
--*****************************************************************************************************************************
-- NAME:  ALLIANCE_FACT_VISIT
--
-- PURPOSE: Creates one row per visit according to ALLIANCE 
--
-- DEVELOPMENT LOG:
-- DATE        	AUTHOR                	NOTES:
-- ----------	-------------------   	-----------------------------------------------------------------------------------------------
-- 2022-08-01   Mohit Vaghadiya         Initial development
-- 2022-08-13	Mohit Vaghadiya			Including data dated before 09/30/2022 since Alliance will be moved to Matrixcare in October 2022
-- 2022-11-08	Mohit Vaghadiya			Added Changes for Fact Visit Revised
-- 2023-01-17	Mohit Vaghadiya			Made minor changes to populate Private Pay Contract where there is no Client payor 
--										associated with Client
-- 2023-19-01	Mohit Vaghadiya			Leveraged Supervisor dedupe
-- 2023-11-09	Shraddha Sejpal			Added PARTNER_CONTRACT_SERVICE_KEY, CLIENT_SERVICE_KEY, BILLING_KEY
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.ALLIANCE_FACT_VISIT
WITH EMPLOYEE AS 
(
	SELECT * FROM
	(
		SELECT SOCIALSECURITYNUM, MASTER_ID
		FROM DISC_DEDUPE_PROD.GENERATIONSALLIANCE.EMPLOYEE_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT SOCIALSECURITYNUM, MASTER_ID
		FROM DISC_DEDUPE_PROD.GENERATIONSALLIANCE.EMPLOYEE_MATCH_LIST
		WHERE SOCIALSECURITYNUM NOT IN (SELECT SOCIALSECURITYNUM FROM DISC_DEDUPE_PROD.GENERATIONSALLIANCE.EMPLOYEE_MASTER_LIST) 
	) 
), CLIENT AS
(
	SELECT * FROM
	(
		SELECT CLIENTID, MASTER_ID
		FROM DISC_DEDUPE_PROD.GENERATIONSALLIANCE.CLIENT_MASTER_LIST 
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT CLIENTID, MASTER_ID
		FROM DISC_DEDUPE_PROD.GENERATIONSALLIANCE.CLIENT_MATCH_LIST
		WHERE CLIENTID NOT IN (SELECT CLIENTID FROM DISC_DEDUPE_PROD.GENERATIONSALLIANCE.CLIENT_MASTER_LIST) 
	)
), SUPERVISOR AS 
(
	SELECT * FROM
	(
		SELECT CASEMANAGERID, MASTER_ID
		FROM DISC_DEDUPE_PROD.GENERATIONSALLIANCE.SUPERVISOR_MASTER_LIST 
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT ID AS CASEMANAGERID, MASTER_ID
		FROM DISC_DEDUPE_PROD.GENERATIONSALLIANCE.SUPERVISOR_MATCH_LIST
		WHERE ID NOT IN (SELECT CASEMANAGERID FROM DISC_DEDUPE_PROD.GENERATIONSALLIANCE.SUPERVISOR_MASTER_LIST) 
	) 
)
, EVV_SUMMARY AS
(
	SELECT * FROM
	(
	SELECT INT_SCHEDULEID::INT AS SCHEDULEID
			, MAX(IFF(UPPER(PURPOSE) = ''LOGIN'', PT.DTM_SAVEDT, NULL)) AS VISIT_STARTDATETIME
			, MAX(IFF(UPPER(PURPOSE) = ''LOGOUT'', PT.DTM_SAVEDT, NULL)) AS VISIT_ENDDATETIME
			, NVL(PT.CALLTYPE, '''') IN (''Call'', ''GPS'') AS IS_EVV
	FROM DISC_PROD.GENERATIONSALLIANCE.TBL_PATTIRAWDATA PT
	WHERE PT.INT_SCHEDULEID IS NOT NULL
	GROUP BY SCHEDULEID, CALLTYPE
	UNION
	SELECT PT.INT_SCHEDULEID::INT AS SCHEDULEID
			, MAX(IFF(UPPER(PT.PURPOSE) = ''LOGIN'', PT.DTM_SAVEDT, NULL)) AS VISIT_STARTDATETIME
			, MAX(IFF(UPPER(PT.PURPOSE) = ''LOGOUT'', PT.DTM_SAVEDT, NULL)) AS VISIT_ENDDATETIME
			, NVL(PT.CALLTYPE, '''') IN (''Call'', ''GPS'') AS IS_EVV
	FROM DISC_PROD.GENERATIONSALLIANCE.TBL_PATTI PT
	LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.TBL_PATTIRAWDATA PTRW
		ON PTRW.INT_SCHEDULEID = PT.INT_SCHEDULEID 
	WHERE PT.INT_SCHEDULEID IS NOT NULL
			AND PTRW.INT_SCHEDULEID IS NULL
	GROUP BY SCHEDULEID, PT.CALLTYPE
	UNION
	SELECT PT.INT_SCHEDULEID::INT AS SCHEDULEID
			, MAX(IFF(UPPER(PT.PURPOSE) = ''LOGIN'', PT.DTM_SAVEDT, NULL)) AS VISIT_STARTDATETIME
			, MAX(IFF(UPPER(PT.PURPOSE) = ''LOGOUT'', PT.DTM_SAVEDT, NULL)) AS VISIT_ENDDATETIME
			, FALSE AS IS_EVV
	FROM DISC_PROD.GENERATIONSALLIANCE.TBL_PATTIARCHIVE PT
	LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.TBL_PATTIRAWDATA PTRW
		ON PTRW.INT_SCHEDULEID = PT.INT_SCHEDULEID 
	LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.TBL_PATTI TBPT
		ON TBPT.INT_SCHEDULEID = PT.INT_SCHEDULEID
	WHERE PT.INT_SCHEDULEID IS NOT NULL
			AND PTRW.INT_SCHEDULEID IS NULL
			AND TBPT.INT_SCHEDULEID IS NULL
	GROUP BY SCHEDULEID
	) AS EVV_DATA
	ORDER BY SCHEDULEID
), EVV_DERIVED AS
(
SELECT EVV.SCHEDULEID
		, IFF(NOT_EVV.SCHEDULEID IS NOT NULL, FALSE, EVV.IS_EVV) AS IS_EVV
		, MAX(EVV.VISIT_STARTDATETIME) AS VISIT_STARTDATETIME
		, MAX(EVV.VISIT_ENDDATETIME) AS VISIT_ENDDATETIME
FROM EVV_SUMMARY EVV
LEFT JOIN EVV_SUMMARY NOT_EVV
	ON NOT_EVV.SCHEDULEID = EVV.SCHEDULEID
		AND NVL(NOT_EVV.IS_EVV, FALSE) = FALSE
GROUP BY EVV.SCHEDULEID, IFF(NOT_EVV.SCHEDULEID IS NOT NULL, FALSE, EVV.IS_EVV)
), DERIVED_STATUS AS 
(
SELECT SC.SCHEDULEID
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
       , MD5(''19'' || ''-'' || ''ALLIANCE'' || ''-'' || NVL(DERIVED_DISC_STATUS,''S'')) AS VISIT_STATUS_KEY
FROM DISC_PROD.GENERATIONSALLIANCE.SCHEDULES SC
INNER JOIN DISC_PROD.GENERATIONSALLIANCE.SERVICES S
    ON S.SERVICECODE = SC.SERVICECODE
LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.TIMESHEETDETAIL TSD
    ON SC.SCHEDULEID = TSD.SCHEDULEID
QUALIFY DENSE_RANK() OVER(PARTITION BY TSD.SCHEDULEID ORDER BY TSD.CREATED DESC) = 1
), CONTRACT_MAPPING AS
(
	SELECT DISTINCT CASE WHEN (CONTAINS(UPPER(P.BADDRESS1), C.FIRSTNAME) AND CONTAINS(UPPER(P.BADDRESS1), C.LASTNAME)) 
							OR (
									CONTAINS(UPPER(C.LASTNAME), REGEXP_SUBSTR(UPPER(P.BADDRESS1), ''\\\\\\\\S+$''))
									OR CONTAINS(REGEXP_SUBSTR(UPPER(P.BADDRESS1), ''\\\\\\\\S+$''), UPPER(C.LASTNAME)
									)
							) OR CT.NAME = ''Private Pay''
							  OR P.PAYORID IS NULL
							THEN TRUE
					 ELSE FALSE 
				END IS_PRIAVATE_PAY
				, MD5(''ALLIANCE'' 
							||  ''-'' || NVL(P.PAYORID, ''-1'') 
							|| ''-'' || SR.SERVICECODE 
							|| ''-'' || IFF(IS_PRIAVATE_PAY, ''PRIVATEPAY'', '''')
							-- || ''-'' || IFF( C.CLIENTTYPEID=1 , ''PRIVATEPAY'',TRIM(SR.DESCRIPTION))
							|| ''-'' || ''GENERATIONS''
						) AS CONTRACT_KEY
				,MD5(''ALLIANCE''
							||  ''-'' || NVL(P.PAYORID, ''-1'') 
							|| ''-'' || SR.SERVICECODE 
							|| ''-'' || IFF(IS_PRIAVATE_PAY, ''PRIVATEPAY'', '''')
							|| ''-'' || ''GENERATIONS''
						) AS PARTNER_CONTRACT_SERVICE_KEY
				, NVL(P.PAYORID, ''-1'') AS PAYORID
				, CASE WHEN SR.FLATRATE=''TRUE''  THEN ''Visit''
					   WHEN SR.FLATRATE=''FALSE'' THEN ''Hourly''
					   ELSE NULL 
				  END AS BILL_UNIT_TYPE
				, SCH.SCHEDULEID
	FROM DISC_PROD.GENERATIONSALLIANCE.SCHEDULES SCH
	INNER JOIN DISC_PROD.GENERATIONSALLIANCE.SERVICES SR
	    ON SR.SERVICECODE  = SCH.SERVICECODE
	LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.CLIENTPAYORS CPY
	    ON SCH.CLIENTID = CPY.CLIENTID
	LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.PAYOR P
	    ON P.PAYORID = CPY.PAYORID
	LEFT JOIN  DISC_PROD.GENERATIONSALLIANCE.CLIENT C 
	    ON C.CLIENTID = CPY.CLIENTID 
	LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.CLIENTTYPE CT 
	    ON CT.CLIENTTYPEID = C.CLIENTTYPEID
	WHERE SCH."DATE"::DATE <= ''2022-09-30''::DATE
	QUALIFY DENSE_RANK() OVER(PARTITION BY SCH.SCHEDULEID, CPY.CLIENTID 
					  	 ORDER BY IFF(NVL(SCH.PAYORID, 0) = CPY.PAYORID, 2, NVL(CPY.ISPRIMARY, 0)::INT) DESC
						  		, IFF(NVL(SCH.PAYORID, 0) = CPY.PAYORID, 2, NVL(CPY.CURRENTPAYOR, 0)::INT) DESC) = 1
)
SELECT DISTINCT MD5(''ALLIANCE'' || ''-'' || SCH.SCHEDULEID || ''-'' || ''GENERATIONS'') AS VISIT_KEY
				, DATE_TRUNC (DAY, SCH."DATE") AS REPORT_DATE 
				, MD5(''ALLIANCE'' || ''-'' || TRIM(CL.LOCATIONID) || ''-'' || ''GENERATIONS'') AS BRANCH_KEY
				, DC.CLIENT_KEY AS CLIENT_KEY
				, CMAP.CONTRACT_KEY  AS CONTRACT_KEY
				, MD5(''ALLIANCE'' || ''-'' || E.MASTER_ID  || ''-'' || ''GENERATIONS'') AS SCHEDULED_EMPLOYEE_KEY
				, MD5(''ALLIANCE'' || ''-'' || E.MASTER_ID  || ''-'' || ''GENERATIONS'') AS EMPLOYEE_KEY
				, 19 AS SOURCE_SYSTEM_ID
				, MD5(''ALLIANCE'' || ''-'' || NVL(SUP.MASTER_ID, ''-1'') || ''-'' || ''GENERATIONS'') AS SUPERVISOR_KEY
				, NULL AS INVOICE_KEY
				, NULL AS PAYROLL_KEY
				, MD5( ''ALLIANCE'' || ''-'' || SCH.SERVICEREQUESTID || ''-'' || ''GENERATIONS'') AS CLIENT_SERVICE_KEY
				, CMAP.PARTNER_CONTRACT_SERVICE_KEY
				, NULL AS BILLING_KEY
				, DATE_TRUNC (DAY, SCH."DATE") AS SERVICE_DATE
				, NULL AS PAYROLL_DATE
				, BM.NAME AS BRANCH_NAME
				, DC.CLIENT_NUMBER AS CLIENT_NUMBER
				, CONCAT(CMAP.PAYORID,''-'',SC.SERVICECODE) AS CONTRACT_CODE
				, E.MASTER_ID AS SCHEDULED_EMPLOYEE_ID
				, E.MASTER_ID AS EMPLOYEE_ID
				, ''ALLIANCE'' AS SYSTEM_CODE
				, NVL(SUP.MASTER_ID, ''-1'') AS SUPERVISOR_CODE 
				, NULL AS INVOICE_ID
				, NULL AS CHEQUE_NUMBER
				, FALSE AS CLEAN_SHIFT_FLAG
				, MP.SCHEDULE_STATUS_CODE AS SCHEDULE_STATUS_CODE
				, MP.SCHEDULE_STATUS_NAME AS SCHEDULE_STATUS_NAME
				, MP.SCHEDULE_STATUS_DESCRIPTION AS SCHEDULE_STATUS_DESCRIPTION
				, MP.VISIT_STATUS_CODE AS VISIT_STATUS_CODE
				, MP.VISIT_STATUS_NAME AS VISIT_STATUS_NAME
				, MP.VISIT_STATUS_DESCRIPTION AS VISIT_STATUS_DESCRIPTION
				, MP.INVOICE_STATUS_CODE AS INVOICE_STATUS_CODE
				, MP.INVOICE_STATUS_NAME AS INVOICE_STATUS_NAME
				, MP.INVOICE_STATUS_DESCRIPTION AS INVOICE_STATUS_DESCRIPTION
				, MP.PAYROLL_STATUS_CODE AS PAYROLL_STATUS_CODE
				, MP.PAYROLL_STATUS_NAME AS PAYROLL_STATUS_NAME
				, MP.PAYROLL_STATUS_DESCRIPTION AS PAYROLL_STATUS_DESCRIPTION
				, NULL AS CANCEL_REASON_CODE
				, NULL AS CANCEL_REASON_DESCRIPTION
				, IFF(SCH.ISCANCELLEDSHIFT =''TRUE'', SCH.NOTES, NULL) AS CANCEL_REASON_NOTES
				, FALSE AS EXCEPTION_REASON_INDICATOR
				, NULL AS RESOLUTION_CODE
				, NULL AS RESOLUTION_DESCRIPTION
				, NULL AS REJECTION_CODE
				, NULL AS REJECTION_DESCRIPTION
				, SCH.SERVICECODE AS BILL_CODE
				, SC.COST AS BILL_RATE
				, NULL AS BILL_UNITS_SERVED
				, CMAP.BILL_UNIT_TYPE AS BILL_UNIT_TYPE
				, NULL AS OVERHEAD_RATE
				, SCH.STARTTIME::TIME AS SCHEDULE_TIMEIN
				, SCH.ENDTIME::TIME AS SCHEDULE_TIMEOUT
				, DATEDIFF(MINUTE, SCH.STARTTIME, SCH.ENDTIME)/ 60.00 AS SCHEDULE_DURATION
				, IFF(PT.SCHEDULEID IS NOT NULL, EVV.VISIT_STARTDATETIME, SCH.ORIGINALSTARTTIME)::TIME AS ACTUAL_TIMEIN
				, IFF(PT.SCHEDULEID IS NOT NULL, EVV.VISIT_ENDDATETIME, SCH.ORIGINALENDTIME)::TIME AS ACTUAL_TIMEOUT
				, IFF(PT.SCHEDULEID IS NOT NULL
						, DATEDIFF(MINUTE, EVV.VISIT_STARTDATETIME, EVV.VISIT_ENDDATETIME)
						, DATEDIFF(MINUTE, SCH.STARTTIME, SCH.ENDTIME)
					  )/ 60.00  AS ACTUAL_DURATION
				, NULL AS ADJUSTED_TIMEIN
				, NULL AS ADJUSTED_TIMEOUT
				, NULL AS ADJUSTED_DURATION
				/*
				, CASE WHEN (
								(SCH.ISCANCELLEDSHIFT) 
								OR (NOT(SCH.ISCONFIRMED) AND SCH."DATE"::DATE <= GETDATE()::DATE)
						 	) 
							OR SCH."DATE"::DATE > GETDATE()::DATE
						THEN 0 
					   WHEN (PT.SCHEDULEID IS NOT NULL)
					   		THEN DATEDIFF(MINUTE, PT.VISITSTARTTIME, PT.VISITENDTIME)/ 60.00
		   			   WHEN (EVV.SCHEDULEID IS NOT NULL) 
		   			   			AND EVV.VISIT_STARTDATETIME IS NOT NULL 
		   			   			AND EVV.VISIT_ENDDATETIME IS NOT NULL
					   		THEN DATEDIFF(MINUTE, EVV.VISIT_STARTDATETIME, EVV.VISIT_ENDDATETIME)/ 60.00
					   ELSE DATEDIFF(MINUTE, SCH.STARTTIME, SCH.ENDTIME)/ 60.00
				  END HOURS_SERVED
				*/
				, TO_NUMBER(NVL(NVL(ACTUAL_DURATION, SCHEDULE_DURATION), 0), 10, 2) AS HOURS_SERVED
				, NULL AS COMMENTS
				, DECODE(NVL(EVV.IS_EVV, FALSE), TRUE, ''Y'', ''N'') AS IS_EVV_FLAG
				, NULL AS TIMESHEET_TYPE
				, NULL AS TRACKING_ID,
				-- ETL Fields
		        :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
--		        -1 AS ETL_TASK_KEY,
--		        -1 AS ETL_INSERTED_TASK_KEY
		   		, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		   		, CURRENT_USER AS ETL_INSERTED_BY, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		    	, CURRENT_USER AS ETL_LAST_UPDATED_BY
		    	, 0 AS ETL_DELETED_FLAG
		    	, MP.CONFIRMED_FLAG AS CONFIRMED_FLAG
FROM DISC_PROD.GENERATIONSALLIANCE.SCHEDULES SCH
INNER JOIN DISC_PROD.GENERATIONSALLIANCE.CLIENT CL
	ON CL.CLIENTID = SCH.CLIENTID 
INNER JOIN CLIENT C
	ON C.CLIENTID = SCH.CLIENTID 
INNER JOIN EMPLOYEE E
	ON E.SOCIALSECURITYNUM = SCH.SOCIALSECNUM
INNER JOIN DISC_PROD.GENERATIONSALLIANCE.SERVICES SC
	ON SC.SERVICECODE = SCH.SERVICECODE
LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.CASEMANAGER CM
	ON CM.CASEMANAGERID = CL.CASEMANAGERID 
LEFT JOIN SUPERVISOR SUP
	ON SUP.CASEMANAGERID = CM.CASEMANAGERID
LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.CLIENTPAYORS CPY
	ON CPY.CLIENTID = CL.CLIENTID 
LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.PAYOR P
    ON P.PAYORID = NVL(CPY.PAYORID, SCH.PAYORID)
INNER JOIN DERIVED_STATUS DS 
	ON DS.SCHEDULEID = SCH.SCHEDULEID
LEFT JOIN HAH.DIM_CLIENT DC
	ON DC.CLIENT_NUMBER = C.MASTER_ID
		AND DC.SOURCE_SYSTEM_ID = 19
LEFT JOIN CONTRACT_MAPPING CMAP
	ON CMAP.SCHEDULEID = SCH.SCHEDULEID 
LEFT JOIN HAH.DIM_VISIT_STATUS_MAPPING MP
	ON DS.VISIT_STATUS_KEY = MP.VISIT_STATUS_KEY
LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.PATTI PT
	ON PT.SCHEDULEID = SCH.SCHEDULEID 
LEFT JOIN DISC_PROD.GENERATIONSALLIANCE.VW_BRANCH_MAPPING BM
	ON BM.LOCATION_ID = CL.LOCATIONID 
LEFT JOIN EVV_DERIVED EVV
	ON EVV.SCHEDULEID = SCH.SCHEDULEID
WHERE SCH."DATE"::DATE <= ''2022-09-30''
		AND DC.CLIENT_NUMBER  NOT IN (SELECT CLIENT_NUMBER FROM DATA_MANAGEMENT.DATA_QUALITY.INVALID_CLIENT_NUMBER WHERE SOURCE_SYSTEM_ID = 19 AND SYSTEM_CODE = ''GENERATIONS'');
RETURN ''SUCCESS'';
END';