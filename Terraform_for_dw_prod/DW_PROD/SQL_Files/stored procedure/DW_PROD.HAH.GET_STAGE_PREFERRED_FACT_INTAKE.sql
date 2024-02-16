CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_PREFERRED_FACT_INTAKE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
                BEGIN
--*****************************************************************************************************************************
-- 	DATE			NAME  				CHANGES
--	04/25/22     	Poonit Mistry       Initial development
-- 	07/29/22		Mohit Vaghadiya		Using DIM_EMPLOYEE and DIM_CLIENT to use the CLIENT and EMPLOYEE KEY 
--									 	as client may have moved to other agency, due to which it was generating
--									 	different client key which was not there in DIM_CLIENT
-- 	08/10/2022		Mohit Vaghadiya		Refactored the code to pull Auth Hours from Authorization instead of Invoice
-- 	02/09/2023		Mohit Vaghadiya		Added Contract Rates CTE to avoid multiple rates w/ same as of date - going with latest modified date
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.PREFERRED_FACT_INTAKE
WITH CLIENT AS
(
SELECT * FROM
	(
		SELECT MD5((AGENCYID||''-''||MASTER_ID||''-''||''PREFERRED'' )) as CLIENT_KEY,
		PATIENTID AS CLIENT_NUMBER, MASTER_ID, AGENCYID, LASTNAME, FIRSTNAME, OFFICEID
		FROM DISC_DEDUPE_PROD.HHAEXCHANGEPREFERRED.CLIENT_MASTER_LIST 
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT MD5((M.AGENCYID||''-''||M.MASTER_ID||''-''||''PREFERRED'' )) as CLIENT_KEY,
        MA.PATIENTID AS CLIENT_NUMBER, MA.MASTER_ID, MA.AGENCYID, MA.LASTNAME, MA.FIRSTNAME, MA.OFFICEID
		FROM DISC_DEDUPE_PROD.HHAEXCHANGEPREFERRED.CLIENT_MATCH_LIST MA
		LEFT JOIN DISC_DEDUPE_PROD.HHAEXCHANGEPREFERRED.CLIENT_MASTER_LIST M ON M.MASTER_ID =MA.MASTER_ID 
		WHERE MA.PATIENTID NOT IN (SELECT PATIENTID FROM DISC_DEDUPE_PROD.HHAEXCHANGEPREFERRED.CLIENT_MASTER_LIST)
	)
), AUTH_BY_DAY AS
(
SELECT AUTHORIZATIONID 
		, PA.PATIENTID 
		, PA.SERVICECODEID 
		, DD.CALENDAR_DATE
		, DECODE(DAYNAME(DD.CALENDAR_DATE)
					, ''Sat'', PA.SATHOURS
			   		, ''Sun'', PA.SUNHOURS
			   		, ''Mon'', PA.MONHOURS
			   		, ''Tue'', PA.TUEHOURS
			   		, ''Wed'', PA.WEDHOURS
			   		, ''Thu'', PA.THUHOURS
			   		, ''Fri'', PA.FRIHOURS
			   	, 0) AS AUTH_HOURS_PER_DAY
		, IFF(SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND AUTH_HOURS_PER_DAY > 13
				, 13, AUTH_HOURS_PER_DAY) AS HOURS_AUTHORIZED
FROM DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PATIENTAUTHORIZATION  PA
INNER JOIN HAH.DIM_DATE DD
	ON DD.CALENDAR_DATE BETWEEN PA.FROMDATE AND PA.TODATE 
INNER JOIN DISC_PROD.HHAEXCHANGEPREFERRED.SERVICECODES SC
	ON SC.SERVICECODEID = PA.SERVICECODEID 
WHERE PERIOD = ''Day''
), AUTH_BY_WEEK AS
(
SELECT PA.AUTHORIZATIONID 
		, PA.PATIENTID 
		, PA.SERVICECODEID 
		, DD.CALENDAR_DATE 
		, PA.MAXUNITSFORPERIOD/7.00 AS AUTH_HOURS_PER_DAY
		, IFF(SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND AUTH_HOURS_PER_DAY > 13
				, 13, AUTH_HOURS_PER_DAY) AS HOURS_AUTHORIZED
FROM DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PATIENTAUTHORIZATION PA
INNER JOIN HAH.DIM_DATE DD
	ON DD.CALENDAR_DATE::DATE BETWEEN PA.FROMDATE::DATE AND PA.TODATE::DATE 
INNER JOIN DISC_PROD.HHAEXCHANGEPREFERRED.SERVICECODES SC
	ON SC.SERVICECODEID = PA.SERVICECODEID 
WHERE PA.PERIOD = ''Week''
), AUTH_BY_MONTH AS
(
SELECT PA.AUTHORIZATIONID 
		, PA.PATIENTID 
		, PA.SERVICECODEID 
		, DD.CALENDAR_DATE 
		, PA.MAXUNITSFORPERIOD/(DAY(LAST_DAY(DD.CALENDAR_DATE))*1.00) AS AUTH_HOURS_PER_DAY
		, IFF(SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND AUTH_HOURS_PER_DAY > 13
				, 13, AUTH_HOURS_PER_DAY) AS HOURS_AUTHORIZED
FROM DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PATIENTAUTHORIZATION PA
INNER JOIN HAH.DIM_DATE DD
	ON DD.CALENDAR_DATE::DATE BETWEEN PA.FROMDATE::DATE AND PA.TODATE::DATE 
INNER JOIN DISC_PROD.HHAEXCHANGEPREFERRED.SERVICECODES SC
	ON SC.SERVICECODEID = PA.SERVICECODEID 
WHERE PA.PERIOD = ''Monthly''
		--AND PA.MAXUNITSFORPERIOD NOT IN (9999, 9999.99, 99999.99, 99999, 999999, 9999999, 999999.99)
), AUTH_BY_PERIOD AS
(
SELECT PA.AUTHORIZATIONID 
		, PA.PATIENTID 
		, PA.SERVICECODEID 
		, DD.CALENDAR_DATE 
		, IFF(FROMDATE != TODATE, DATEDIFF(DAY, FROMDATE, TODATE), 1) * 1.00 AS DAYS_IN_PERIOD
		--18121 | If Contract is Visiting Nurse Service of New York - CHOICE (PHN) then divide by 4
		, CASE WHEN SC.SERVICECODE ILIKE ''%T1019%'' AND SC.CONTRACTID = 18121 AND DAYS_IN_PERIOD > 1
					THEN (PA.MAXUNITSFORPERIOD/DAYS_IN_PERIOD)/4.00
		   	   WHEN DAYS_IN_PERIOD = 1
		   			THEN PA.MAXUNITSFORPERIOD
		   	   ELSE PA.MAXUNITSFORPERIOD/DAYS_IN_PERIOD
		  END AUTH_HOURS_PER_DAY
		, IFF(SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND AUTH_HOURS_PER_DAY > 13
				, 13, AUTH_HOURS_PER_DAY) AS HOURS_AUTHORIZED
FROM DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PATIENTAUTHORIZATION PA
INNER JOIN HAH.DIM_DATE DD
	ON DD.CALENDAR_DATE::DATE BETWEEN PA.FROMDATE::DATE AND PA.TODATE::DATE 
INNER JOIN DISC_PROD.HHAEXCHANGEPREFERRED.SERVICECODES SC
	ON SC.SERVICECODEID = PA.SERVICECODEID 
WHERE PERIOD = ''Entire Period''
		--AND MAXUNITSFORPERIOD NOT IN (9999, 9999.99, 99999.99, 99999, 999999, 9999999, 999999.99, 4740.00)
		--AND AUTHORIZATIONID NOT IN (13820103, 15135847, 18522662, 316544, 7500277)
), AUTH_OVERALL AS
(
	SELECT AUTHORIZATIONID, PATIENTID, SERVICECODEID, CALENDAR_DATE, HOURS_AUTHORIZED FROM AUTH_BY_DAY
	UNION
	SELECT AUTHORIZATIONID, PATIENTID, SERVICECODEID, CALENDAR_DATE, HOURS_AUTHORIZED FROM AUTH_BY_WEEK
	UNION
	SELECT AUTHORIZATIONID, PATIENTID, SERVICECODEID, CALENDAR_DATE, HOURS_AUTHORIZED FROM AUTH_BY_MONTH
	UNION
	SELECT AUTHORIZATIONID, PATIENTID, SERVICECODEID, CALENDAR_DATE, HOURS_AUTHORIZED FROM AUTH_BY_PERIOD
), AUTH_PER_MONTH AS
(
	SELECT AO.PATIENTID
			, AO.SERVICECODEID
			, DATE_TRUNC(''MONTH'', CALENDAR_DATE) AS AUTH_MONTH
			, MAX(PA.FROMDATE::DATE) AS REAUTHORIZED_DATE
			, SUM(HOURS_AUTHORIZED) AS HOURS_AUTHORIZED
	FROM AUTH_OVERALL AO
	INNER JOIN DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PATIENTAUTHORIZATION PA
		ON PA.AUTHORIZATIONID = AO.AUTHORIZATIONID
	GROUP BY AO.PATIENTID, AO.SERVICECODEID, AUTH_MONTH
), AUTH_DATES AS
(
	SELECT DISTINCT
		PA.PATIENTID 
		, PA.SERVICECODEID 
		, FIRST_VALUE(AUTHORIZATIONNUMBER) 
			OVER(PARTITION BY PA.PATIENTID, PA.SERVICECODEID ORDER BY PA.FROMDATE DESC) AS AUTHNUMBER
	   , MAX(PA.FROMDATE)
	   		OVER(PARTITION BY PA.PATIENTID, PA.SERVICECODEID) AS LATEST_AUTH_BEGIN_DATE
	   , MAX(PA.TODATE) 
	   		OVER(PARTITION BY PA.PATIENTID, PA.SERVICECODEID) AS LATEST_AUTH_END_DATE
	FROM DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PATIENTAUTHORIZATION PA
)
, SUPERVISOR AS
(
	SELECT CORD.PATIENTID, CORD.COORDINATORID, CORD.COORDINATORNAME
			, ROW_NUMBER() OVER(PARTITION BY CORD.AGENCYID, CORD.PATIENTID, CORD.COORDINATORSRNO ORDER BY CREATEDDATE DESC) RN
	FROM DISC_PROD.HHAEXCHANGEPREFERRED.PROVIDERPATIENTCOORDINATORS CORD
	INNER JOIN DISC_PROD.HHAEXCHANGEPREFERRED.AGENCY_MAPPING AGENCY_CONFIG
		ON AGENCY_CONFIG.AGENCYID = CORD.AGENCYID
			AND AGENCY_CONFIG.ISACTIVE = TRUE
	WHERE CORD.COORDINATORSRNO  = 1
), PREFERRED_REVENUE_SEG AS 
(
	SELECT CONTRACTID, REVENUE_CATEGORY, REVENUE_SUBCATEGORY_NAME, REVENUE_SUBCATEGORY_CODE 
	FROM DISC_PROD.HHAEXCHANGEPREFERRED.REVENUE_MAPPING
	GROUP BY CONTRACTID, REVENUE_CATEGORY, REVENUE_SUBCATEGORY_NAME, REVENUE_SUBCATEGORY_CODE
), SERVICE_DATA AS
(
	SELECT DISTINCT VR.PATIENTID AS PATIENTID
			, VISITS.PRIMARYSERVICECODEID AS SERVICECODEID 
			, MIN(VR.VISITDATE) AS BEGIN_SERVICE_DATE
			, MAX(VR.VISITDATE) AS END_SERVICE_DATE
			, NVL(DATEDIFF(DAY, MAX(VR.VISITDATE)::DATE, GETDATE()::DATE), 0) AS LAST_SERVICE_DAY_DIFF
	FROM DISC_PROD.HHAEXCHANGEPREFERRED.VISITINFO_REPL VISITS
	JOIN DISC_PROD.HHAEXCHANGEPREFERRED.TBLVISITS_REPL VR
		ON VISITS.VISITID = VR.VISITID
			AND VISITS.AGENCYID = VR.AGENCYID
	INNER JOIN DISC_PROD.HHAEXCHANGEPREFERRED.VISITS VS
		ON VS.VISITID = VR.VISITID 
	INNER JOIN DISC_PROD.HHAEXCHANGEPREFERRED.AGENCY_MAPPING AGENCY_CONFIG 
		ON AGENCY_CONFIG.AGENCYID = VS.AGENCYID 
			AND AGENCY_CONFIG.ISACTIVE = TRUE
	GROUP BY VR.PATIENTID, VISITS.PRIMARYSERVICECODEID 
), CONTRACT_RATES AS -- Added this CTE to avoid multiple rates w/ same as of date - going with latest modified date
(
	SELECT CR.*
	FROM DISC_PROD.HHAEXCHANGEPREFERRED.CONTRACTRATES CR
	WHERE CR.TODATE::DATE > GETDATE()
			AND CR.FROMDATE::DATE <= GETDATE()
	QUALIFY ROW_NUMBER() OVER (PARTITION BY CR.AGENCYID, CR.CONTRACTID, CR.SERVICECODEID ORDER BY CR.MODIFIEDDATE DESC) = 1 
)
, INTAKE_DATA AS 
(
SELECT DISTINCT MD5( ''PREFERRED''
					|| ''-'' || PA.PATIENTID  
					|| ''-'' || APM.AUTH_MONTH
					|| ''-'' || NVL(SC.SERVICECODEID, -1) 
					|| ''-'' || NVL(PS.REVENUE_SUBCATEGORY_CODE, ''UNKNOWN'') 
					|| ''-'' || ''PREFERRED'') AS INTAKE_KEY
				, APM.AUTH_MONTH AS REPORT_DATE
				, MD5(''PREFERRED'' || ''-'' || ''PREFERRED CORPORATE OFFICE'' || ''-'' || ''PREFERRED'') AS BRANCH_KEY
				, DC.CLIENT_KEY AS CLIENT_KEY
				, MD5(NVL(SC.AGENCYID,-1) 
						|| ''-'' || NVL(SC.CONTRACTID,-1) 
						|| ''-'' || NVL(CR.CONTRACTRATEID, -1) 
						|| ''-'' || NVL(SC.SERVICECODEID, -1) 
						|| ''-'' || NVL(PS.REVENUE_SUBCATEGORY_CODE, ''UNKNOWN'') 
						|| ''PREFERRED'') AS CONTRACT_KEY
				, 17 AS SOURCE_SYSTEM_ID
				, APM.REAUTHORIZED_DATE AS REAUTHORIZED_DATE
				, AD.AUTHNUMBER AS PRE_AUTH_NUMBER
				, P.SERVICESTARTDATE AS BEGIN_SERVICE_DATE
				, IFF(SD.LAST_SERVICE_DAY_DIFF > 30, SD.END_SERVICE_DATE, NULL) AS END_SERVICE_DATE
				, AD.LATEST_AUTH_BEGIN_DATE::DATE AS LATEST_AUTH_BEGIN_DATE
				, AD.LATEST_AUTH_END_DATE::DATE AS LATEST_AUTH_END_DATE
				, ''PREFERRED CORPORATE OFFICE'' AS BRANCH_NAME
		      	, CR.RATE AS BILL_RATE
		      	, DC.CLIENT_NUMBER
		      	, NVL(SC.CONTRACTID,-1) AS CONTRACT_CODE
		      	, ''PREFERRED'' AS SYSTEM_CODE
		      	, SUP.COORDINATORNAME AS CASE_MANAGER
		      	, APM.HOURS_AUTHORIZED AS HOURS_AUTHORIZED
		      	, APM.HOURS_AUTHORIZED AS HOURS_AUTHORIZED_NON_ADJUSTED,
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
                        
       	, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		      	, CURRENT_USER AS ETL_INSERTED_BY
		      	, CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		      	, CURRENT_USER AS ETL_LAST_UPDATED_BY
		      	, 0 AS ETL_DELETED_FLAG
FROM DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PATIENTAUTHORIZATION PA
INNER JOIN DISC_PROD.HHAEXCHANGEPREFERRED.SERVICECODES SC 
	ON SC.CONTRACTID = PA.CONTRACTID 
		AND SC.AGENCYID = PA.AGENCYID
		AND SC.SERVICECODEID = PA.SERVICECODEID
INNER JOIN AUTH_PER_MONTH APM
	ON APM.PATIENTID = PA.PATIENTID
		AND APM.SERVICECODEID = SC.SERVICECODEID
INNER JOIN CLIENT 
	ON CLIENT.CLIENT_NUMBER = PA.PATIENTID
INNER JOIN DISC_PROD.HHAEXCHANGEPREFERRED.STAGE_PATIENTS P
	ON P.PATIENTID = CLIENT.CLIENT_NUMBER
INNER JOIN HAH.DIM_CLIENT DC 
	ON DC.CLIENT_KEY = CLIENT.CLIENT_KEY
		AND DC.SYSTEM_CODE = ''PREFERRED''
INNER JOIN DISC_PROD.HHAEXCHANGEPREFERRED.AGENCY_MAPPING AGENCY_CONFIG 
	ON AGENCY_CONFIG.AGENCYID = PA.AGENCYID 
		AND AGENCY_CONFIG.ISACTIVE = TRUE
LEFT JOIN SERVICE_DATA SD
	ON SD.PATIENTID = PA.PATIENTID 
		AND SD.SERVICECODEID = PA.SERVICECODEID
LEFT JOIN AUTH_DATES AD
	ON AD.PATIENTID = PA.PATIENTID 
		AND AD.SERVICECODEID = PA.SERVICECODEID 
LEFT JOIN SUPERVISOR SUP
	ON SUP.PATIENTID = PA.PATIENTID 
		AND SUP.RN = 1
LEFT JOIN PREFERRED_REVENUE_SEG PS 
	ON PS.CONTRACTID = SC.CONTRACTID 
LEFT JOIN CONTRACT_RATES CR 
	ON CR.CONTRACTID = SC.CONTRACTID 
		AND CR.AGENCYID = PA.AGENCYID
		AND CR.SERVICECODEID = PA.SERVICECODEID
		AND CR.TODATE::DATE > GETDATE()::DATE 
		AND CR.FROMDATE::DATE <= GETDATE()::DATE
LEFT JOIN DISC_PROD.HHAEXCHANGEPREFERRED.CONTRACTS C 
	ON PA.CONTRACTID = C.CONTRACTID 
		AND C.AGENCYID = PA.AGENCYID
)
SELECT INTAKE_KEY
		, REPORT_DATE
		, BRANCH_KEY
		, CLIENT_KEY
		, CONTRACT_KEY
		, SOURCE_SYSTEM_ID
		, REAUTHORIZED_DATE
		, PRE_AUTH_NUMBER
		, BEGIN_SERVICE_DATE
		, END_SERVICE_DATE
		, LATEST_AUTH_BEGIN_DATE
		, LATEST_AUTH_END_DATE
		, BRANCH_NAME
		, CLIENT_NUMBER 
		, CONTRACT_CODE
		, BILL_RATE
		, SYSTEM_CODE
		, CASE_MANAGER
		, HOURS_AUTHORIZED
		, HOURS_AUTHORIZED_NON_ADJUSTED
		, ETL_TASK_KEY
		, ETL_INSERTED_TASK_KEY
		, ETL_INSERTED_DATE
		, ETL_INSERTED_BY
		, ETL_LAST_UPDATED_DATE
		, ETL_LAST_UPDATED_BY
		, ETL_DELETED_FLAG
FROM INTAKE_DATA
;
    RETURN ''SUCCESS'';
    END;
    ';