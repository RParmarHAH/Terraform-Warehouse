resource "snowflake_view" "DW_REPORT_VW_IDOA_CONTRACTS_UTILIZATION" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "VW_IDOA_CONTRACTS_UTILIZATION"
	statement = <<-SQL
	 -------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
-- PURPOSE: CREATED TEMPORARY VIEW FOR IDOA REPORTING
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 02/09/23    DEEPEN GAJJAR         INITIAL DEVELOPMENT
WITH MAXREAUTH AS (
    SELECT MAX(CA.STARTDATE :: date) AS MAX_REAUTH
         , CA.CONTRACTCODE
         , CA.CLIENTNUMBER
         , CA.DBNAME
 FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTAUTHORIZATIONS CA
 WHERE CA.CONTRACTCODE ='2'
 AND CA.DBNAME ='IL'
    GROUP BY CA.CONTRACTCODE
           , CA.CLIENTNUMBER
           , CA.DBNAME
 ),
 MINREAUTH AS (
     SELECT MIN(CA.STARTDATE :: date) AS MIN_REAUTH
          , CA.CONTRACTCODE
          , CA.CLIENTNUMBER
          , CA.DBNAME
     FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTAUTHORIZATIONS CA
      WHERE CA.CONTRACTCODE ='2'
 AND CA.DBNAME ='IL'
     GROUP BY CA.CONTRACTCODE
            , CA.CLIENTNUMBER
            , CA.DBNAME
 ),CLIENT_DATA AS
(
	SELECT * FROM
	(
		SELECT TRIM(DBNAME) AS MASTER_DBNAME, "NUMBER" AS MASTER_CLIENT_NUMBER, TRIM(DBNAME) AS DBNAME, "NUMBER" AS CLIENT_NUMBER, trim(FIRSTNAME) AS FIRSTNAME, trim(LASTNAME) AS LASTNAME
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.CLIENT_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT TRIM(MASTER.DBNAME) AS MASTER_DBNAME, MASTER."NUMBER" AS MASTER_CLIENT_NUMBER, TRIM(MATCH.DBNAME) AS DBNAME, MATCH."NUMBER" AS CLIENT_NUMBER, trim(MATCH.FIRSTNAME) AS FIRSTNAME, trim(MATCH.LASTNAME) AS LASTNAME
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.CLIENT_MATCH_LIST AS MATCH
        JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.CLIENT_MASTER_LIST AS MASTER 
            ON MASTER.MASTER_ID = MATCH.MASTER_ID
        WHERE MATCH.ID <> MATCH.MASTER_ID
	)
)
 ,
AUTHDATES -- Added by PJShah on 19042022
AS (
select DISTINCT CTA1.DBNAME, CTA1.CLIENTNUMBER, CTA1.CONTRACTCODE, CTA1.STARTDATE, CTA1.ENDDATE , UPPER(CTA1.PREAUTHNUMBER)PREAUTHNUMBER
from
(
select CTA.DBNAME, CTA.CLIENTNUMBER, CTA.CONTRACTCODE, CTA.STARTDATE , MAX(CTA.ENDDATE) ENDDATE --, CTA.PREAUTHNUMBER 
,MAX(CTA.SEQNO) AS SEQNO -- Added by PJShah on 04052022 (To overcome 836 records with same auth dates and diff preauth no. )
from DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTAUTHORIZATIONS CTA
inner join MAXREAUTH on CTA.CLIENTNUMBER = MAXREAUTH.CLIENTNUMBER
					AND CTA.CONTRACTCODE = MAXREAUTH.CONTRACTCODE
					AND CTA.STARTDATE = MAXREAUTH.MAX_REAUTH
					AND CTA.DBNAME= MAXREAUTH.DBNAME
GROUP BY CTA.DBNAME, CTA.CLIENTNUMBER, CTA.CONTRACTCODE, CTA.STARTDATE 
)T
JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTAUTHORIZATIONS CTA1 on 
					CTA1.CLIENTNUMBER = T.CLIENTNUMBER
					AND CTA1.CONTRACTCODE = T.CONTRACTCODE
					AND CTA1.STARTDATE = T.STARTDATE
					AND CTA1.DBNAME= T.DBNAME
					AND CTA1.ENDDATE=T.ENDDATE
					AND CTA1.SEQNO=T.SEQNO -- Added by PJShah on 04052022
)
--SELECT * FROM authdates ;
,
 TIMESHEETS AS
 (
     SELECT MIN(PAYROLLDATE) AS TIMESHEET_DATE
          , CONTRACTCODE
          , DBNAME
          , CLIENTNUMBER
     FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.ALL_DFTIMESHEETS
     GROUP BY CONTRACTCODE
            , DBNAME
            , CLIENTNUMBER
 ),
 CHANGED_CLIENTS AS (
 	SELECT C.DBNAME , C."NUMBER" AS CLIENTNUMBER
 	FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTS C
 ),
CHANGED_CONTRACTS AS (
 	SELECT A.DBNAME , A.CLIENTNUMBER , A.CONTRACTCODE 
 	FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTAUTHORIZATIONS A
 	UNION 
 	SELECT A.DBNAME , A.CLIENTNUMBER , A.CONTRACTCODE 
 	FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTS A
 ),
  REAUTH AS(
     SELECT CASE
                WHEN ((C.BEGINSERVICEDATE IS NULL) AND (F.BEGINSERVICEDATE IS NULL)) THEN T.TIMESHEET_DATE
--				ELSE IFF(C.BEGINSERVICEDATE < F.BEGINSERVICEDATE, C.BEGINSERVICEDATE, F.BEGINSERVICEDATE)
                ELSE IFF(COALESCE(C.BEGINSERVICEDATE, F.BEGINSERVICEDATE) <= F.BEGINSERVICEDATE, F.BEGINSERVICEDATE, C.BEGINSERVICEDATE)
         END                                                                                            AS DERIVED_BEGIN_SERVICE_DATE
          , IFF(DATE_PART('year', DERIVED_BEGIN_SERVICE_DATE) < 1990, null,
                DERIVED_BEGIN_SERVICE_DATE)                                                             AS CLEAN_BEGIN_SERVICE_DATE
--          , MARA.MAX_REAUTH                                                                             AS REAUTHORIZED_DATE
          , MARA.MAX_REAUTH																				AS REAUTHORIZED_DATE
--          , MIRA.MIN_REAUTH                                                                             AS MIN_REAUTH
          , CASE
                WHEN (C.ENDSERVICEDATE IS NULL) AND (F.ENDSERVICEDATE IS NULL) THEN LAST_DAY(DATEADD('year', 1, CURRENT_DATE()), MONTH)
                ELSE IFF(COALESCE(C.ENDSERVICEDATE, F.ENDSERVICEDATE) >= F.ENDSERVICEDATE, F.ENDSERVICEDATE, C.ENDSERVICEDATE)
         END                                                                                               DERIVED_END_SERVICE_DATE
          , C.ONHOLDSTARTDATE 																			AS ONHOLDSTARTDATE
          , C.ONHOLDENDDATE 																			AS ONHOLDENDDATE
		  , NVL(C.OFFICENUMBER, -1) 																	AS INTAKE_OFFICE_CODE
          , O.OFFICENAME                                                                                AS INTAKE_OFFICE_NAME
          , F.CASEWORKERMANAGER                                                                         AS SUPERVISOR_NAME
          , f.CLIENTNUMBER                                                                              AS CLIENT_NUMBER
          , F.CONTRACTCODE                                                                              AS CONTRACT_CODE
          , F.DBNAME                                                                                    AS DBNAME
          , IFF(EC.AUTHTYPE = 'WEEKLY_CAREPLAN', 'Weekly', 'Monthly')                                   AS AUTH_TYPE
          , NVL(MAX(F.OLDAUTHORIZEDHOURS), 0) / 5	OLD_HOURS_WEEKLY
          , F.OLDAUTHORIZEDHOURS					OLD_HOURS_MONTHLY
          , NVL(MAX(F.MONTHLYMAXHOURS), 0)  MONTHLY_HOURS
          , NVL(MAX(F.WEEKLYMAXHOURS), 0)   WEEKLY_HOURS
		  , F.BEGINSERVICEDATE AS CLIENT_BEGIN_SERVICE_DATE    	-- Added by PJShah on 19042022
          , F.ENDSERVICEDATE AS CLIENT_END_SERVICE_DATE 			--   Added by PJShah on 19042022  
		  , AUTHDT.STARTDATE AS LATEST_AUTH_BEGIN_DATE 	-- Added by PJShah on 19042022
		  , AUTHDT.ENDDATE AS LATEST_AUTH_END_DATE 	-- Added by PJShah on 19042022
		  , AUTHDT.PREAUTHNUMBER    AS PRE_AUTH_NUMBER  -- Added by PJShah on 19042022                                        
     FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTS F
              LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTS C ON C.DBNAME = F.DBNAME AND C.NUMBER = F.CLIENTNUMBER
              LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFOFFICES O
                        ON O.DBNAME = C.DBNAME AND O.OFFICENUMBER = C.OFFICENUMBER
              LEFT JOIN MAXREAUTH MARA ON F.DBNAME = MARA.DBNAME AND F.CLIENTNUMBER = MARA.CLIENTNUMBER AND
                                          MARA.CONTRACTCODE = F.CONTRACTCODE
                                          AND F.AUTHTYPE IN ('I', 'D')
--              LEFT JOIN MINREAUTH MIRA ON F.DBNAME = MIRA.DBNAME AND F.CLIENTNUMBER = MIRA.CLIENTNUMBER AND
--                                          MIRA.CONTRACTCODE = F.CONTRACTCODE
			LEFT JOIN AUTHDATES AUTHDT ON 	F.DBNAME = AUTHDT.DBNAME -- Added by PJShah on 19042022
										AND F.CLIENTNUMBER = AUTHDT.CLIENTNUMBER 
										AND AUTHDT.CONTRACTCODE = F.CONTRACTCODE           
   			LEFT JOIN TIMESHEETS T
                        ON F.DBNAME = T.DBNAME AND F.CLIENTNUMBER = T.CLIENTNUMBER AND T.CONTRACTCODE = F.CONTRACTCODE
              LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTSUPERVISORS CS
                        ON CS.DBNAME = C.DBNAME AND CS.CLIENTNUMBER = F.CLIENTNUMBER
              LEFT JOIN DISC_${var.SF_ENVIRONMENT}.BI_REPOSITORY.EXTERNALCONTRACTS EC
                        ON EC.DBNAME = F.DBNAME AND EC.INTCOD = F.CONTRACTCODE
			  LEFT JOIN CHANGED_CLIENTS AS CHANGED_CLIENTS
			  			ON CHANGED_CLIENTS.DBNAME = F.DBNAME
						  	AND CHANGED_CLIENTS.CLIENTNUMBER = F.CLIENTNUMBER
			  LEFT JOIN CHANGED_CONTRACTS AS CHANGED_CONTRACTS
			  			ON CHANGED_CONTRACTS.DBNAME = F.DBNAME 
			  				AND CHANGED_CONTRACTS.CLIENTNUMBER = F.CLIENTNUMBER 
			  				AND CHANGED_CONTRACTS.CONTRACTCODE = F.CONTRACTCODE
	WHERE  (CHANGED_CLIENTS.DBNAME IS NOT NULL
			OR CHANGED_CONTRACTS.DBNAME IS NOT NULL	) AND f.CONTRACTCODE ='2' AND F.DBNAME ='IL'
     GROUP BY F.BEGINSERVICEDATE
            , C.BEGINSERVICEDATE
            , F.ENDSERVICEDATE
            , f.CLIENTNUMBER
            , F.CONTRACTCODE
            , F.DBNAME
            , C.ENDSERVICEDATE
            , MARA.MAX_REAUTH
--            , MIRA.MIN_REAUTH
            , T.TIMESHEET_DATE
            , C.ONHOLDSTARTDATE 
            , C.ONHOLDENDDATE 
			, C.OFFICENUMBER
            , O.OFFICENAME
            , F.CASEWORKERMANAGER
            , AUTH_TYPE
            , F.OLDAUTHORIZEDHOURS
			, AUTHDT.STARTDATE 	-- Added by PJShah on 19042022
		  , AUTHDT.ENDDATE 	-- Added by PJShah on 19042022
		  , AUTHDT.PREAUTHNUMBER   -- Added by PJShah on 19042022
   ) 
,  	VISITS AS (
SELECT 
MD5(TSH.DBNAME || '-' || TSH.REFERENCENO || '-' || TSH.WEEKENDDATE || '-' || TSH.SERVICEDATE::date || '-' || 'DATAFLEXSYNCDATA') AS VISIT_KEY,
md5(COALESCE(cd.dbname,c.dbname , '')||'-'||COALESCE(cd.MASTER_CLIENT_NUMBER,c."NUMBER" , -1)||'-'||'DATAFLEXSYNCDATA') AS client_key,
COALESCE(cd.MASTER_CLIENT_NUMBER,c."NUMBER" , -1) AS client_id,
md5(TSH.DBNAME || '-' || nvl(ts.CONTRACTCODE,'Unknown') || '-'  ||  'DATAFLEXSYNCDATA') AS CONTRACT_KEY,
md5(TSH.DBNAME || '-'  || nvl(ts.SUPERVISORCODE,'Unknown-' || TS.DBNAME) || '-'  || 'DATAFLEXSYNCDATA') AS SUPERVISOR_KEY,
COALESCE(cd.FIRSTNAME,C.FIRSTNAME , '') AS FIRSTNAME,
COALESCE(cd.LASTNAME,c.LASTNAME , '') AS LASTNAME,
DATE_TRUNC('MONTH',TSH.SERVICEDATE) AS SERVICE_MONTH,
TSH.SERVICEDATE AS REPORT_DATE, 
O.OFFICENAME,
tsh.SERVICEHOURS,
VV.CONFIRMED_FLAG 
FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTS C 
LEFT JOIN CLIENT_DATA cd ON cd.CLIENT_NUMBER = c."NUMBER" AND cd.DBNAME = c.DBNAME
JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFTIMESHEETS TS ON TS.CLIENTNUMBER = C.NUMBER AND TS.DBNAME = C.DBNAME 
JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFTIMESHEETHOURS TSH ON TS.REFERENCENO = TSH.REFERENCENO AND TS.DBNAME = TSH.DBNAME
JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFOFFICES O ON TS.OFFCENO = O.OFFICENUMBER AND TS.DBNAME = O.DBNAME
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.FACT_VISIT  VV ON VV.VISIT_KEY = MD5(TSH.DBNAME || '-' || TSH.REFERENCENO || '-' || TSH.WEEKENDDATE || '-' || TSH.SERVICEDATE::date || '-' || 'DATAFLEXSYNCDATA')
WHERE 
TS.CONTRACTCODE = '2'
AND TSH.DBNAME = 'IL'
AND TSH.SERVICEDATE >= '2022-10-01'
), VISIT_DATA AS (
SELECT DISTINCT 
client_key,
client_id,
FIRSTNAME,
LASTNAME,
SERVICE_MONTH,
OFFICENAME,
FIRST_VALUE(SUPERVISOR_KEY) OVER(PARTITION BY SERVICE_MONTH, CLIENT_KEY, CONTRACT_KEY ORDER BY IFF(MAX(CONFIRMED_FLAG) = 'YES', 0, 1), MAX(REPORT_DATE) DESC,  NVL(SUM(SERVICEHOURS), 0) DESC) SUPERVISOR_KEY,
SUM(NVL(SUM(IFF(CONFIRMED_FLAG = 'YES', SERVICEHOURS,SERVICEHOURS)), 0)) OVER(PARTITION BY SERVICE_MONTH, CLIENT_KEY, CONTRACT_KEY) AS HOURS_SERVED
FROM VISITS
GROUP BY client_key,
client_id,
FIRSTNAME,
LASTNAME,
SERVICE_MONTH,
OFFICENAME,
SUPERVISOR_KEY,
CONTRACT_KEY
)
, IDOA_CONTRACTS_AUTH AS (
SELECT TO_DATE(CA.STARTDATE) AS AUTH_DATE, 
COALESCE(cd.MASTER_CLIENT_NUMBER,c."NUMBER" , -1) AS client_id,
CON.CONTRACTNAME,
AUTH.MONTHLYMAXHOURS,
AUTH.WEEKLYMAXHOURS,
AUTH.OLDAUTHORIZEDHOURS
FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTS AUTH
JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTS C ON C.DBNAME = AUTH.DBNAME AND C.NUMBER = AUTH.CLIENTNUMBER
LEFT JOIN CLIENT_DATA cd ON cd.CLIENT_NUMBER = c."NUMBER" AND cd.DBNAME = c.DBNAME
JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCONTRACTS CON ON CON.DBNAME = AUTH.DBNAME AND CON.CONTRACTCODE = AUTH.CONTRACTCODE
JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTAUTHORIZATIONS CA ON CA.DBNAME = AUTH.DBNAME AND CA.CLIENTNUMBER = AUTH.CLIENTNUMBER 
WHERE CON.CONTRACTCODE = '2'
AND CON.CONTRACTNAME = 'IDOA'
), FIN AS (
SELECT DISTINCT V.*,I.CONTRACTNAME, SS.SUPERVISOR_CODE 
, first_value(/*iff(service_month>auth_date,auth_date,NULL)*/ auth_date) OVER (PARTITION BY V.client_id, service_month ORDER BY iff(service_month>auth_date,1,0) DESC , auth_date DESC )  AS auth_date_revised 
, first_value(/*iff(service_month>auth_date,MONTHLYMAXHOURS,NULL)*/ MONTHLYMAXHOURS) OVER (PARTITION BY V.client_id, service_month ORDER BY iff(service_month>auth_date,1,0) DESC , auth_date DESC )  AS MONTHLYMAXHOURS_revised 
, first_value(/*iff(service_month>auth_date,OLDAUTHORIZEDHOURS,NULL)*/ OLDAUTHORIZEDHOURS) OVER (PARTITION BY V.client_id, service_month ORDER BY iff(service_month>auth_date,1,0) DESC , auth_date DESC )  AS OLDAUTHORIZEDHOURS_REVISED
FROM VISIT_DATA V 
JOIN IDOA_CONTRACTS_AUTH I ON V.CLIENT_ID  =I.CLIENT_ID 
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_SUPERVISOR SS ON v.SUPERVISOR_KEY = SS.SUPERVISOR_KEY 
)
--SELECT *
--FROM fin  
--WHERE client_id='745896';
,
auth_final AS (
SELECT 
COALESCE(c.MASTER_CLIENT_NUMBER,r.CLIENT_NUMBER, -1) AS CLIENT_NUMBER
,nvl(b.BRANCH_KEY, md5(r.DBNAME || '-' || r.INTAKE_OFFICE_CODE || '-' ||  'DATAFLEXSYNCDATA')) AS BRANCH_KEY
,nvl(n.CONTRACT_KEY, md5(r.DBNAME || '-' || nvl(r.CONTRACT_CODE,'Unknown') || '-'  ||  'DATAFLEXSYNCDATA')) AS CONTRACT_KEY
,3 AS SOURCE_SYSTEM_ID
,r.DBNAME AS SYSTEM_CODE
,IFF(r.DERIVED_BEGIN_SERVICE_DATE <= CAL.FIRST_DAY_OF_MONTH, CAL.FIRST_DAY_OF_MONTH, r.DERIVED_BEGIN_SERVICE_DATE) AS PERIOD_BEGIN_SERVICE_DATE
,IFF(r.DERIVED_END_SERVICE_DATE >= CAL.LAST_DAY_OF_MONTH, CAL.LAST_DAY_OF_MONTH, r.DERIVED_END_SERVICE_DATE) AS PERIOD_END_SERVICE_DATE
,CASE WHEN r.ONHOLDSTARTDATE IS NULL OR r.ONHOLDENDDATE < PERIOD_BEGIN_SERVICE_DATE OR r.ONHOLDSTARTDATE > PERIOD_END_SERVICE_DATE THEN NULL
			WHEN r.ONHOLDSTARTDATE <= PERIOD_BEGIN_SERVICE_DATE THEN PERIOD_BEGIN_SERVICE_DATE
			ELSE r.ONHOLDSTARTDATE END AS PERIOD_ONHOLD_BEGIN_DATE
,CASE WHEN PERIOD_ONHOLD_BEGIN_DATE IS NULL THEN NULL ELSE IFF(COALESCE(r.ONHOLDENDDATE, PERIOD_END_SERVICE_DATE) >= PERIOD_END_SERVICE_DATE, PERIOD_END_SERVICE_DATE, COALESCE(r.ONHOLDENDDATE, PERIOD_END_SERVICE_DATE)) END AS PERIOD_ONHOLD_END_DATE
,CASE WHEN COALESCE(r.REAUTHORIZED_DATE, PERIOD_ONHOLD_BEGIN_DATE) <= PERIOD_ONHOLD_BEGIN_DATE THEN PERIOD_ONHOLD_BEGIN_DATE
			WHEN r.REAUTHORIZED_DATE > PERIOD_ONHOLD_END_DATE THEN NULL 
        	ELSE r.REAUTHORIZED_DATE END AS PERIOD_REAUTHORIZED_ONHOLD_DATE
,CASE WHEN COALESCE(r.REAUTHORIZED_DATE, PERIOD_BEGIN_SERVICE_DATE) <= PERIOD_BEGIN_SERVICE_DATE THEN PERIOD_BEGIN_SERVICE_DATE
			WHEN r.REAUTHORIZED_DATE > PERIOD_END_SERVICE_DATE THEN NULL 
        	ELSE r.REAUTHORIZED_DATE END AS PERIOD_REAUTHORIZED_DATE
,COALESCE(NULLIF(r.OLD_HOURS_WEEKLY, 0), r.WEEKLY_HOURS) HOURS_WEEKLY_OLDAUTH
,IFF(PERIOD_ONHOLD_BEGIN_DATE IS NULL, 0, DATEDIFF('DAY', PERIOD_ONHOLD_BEGIN_DATE, COALESCE(PERIOD_REAUTHORIZED_ONHOLD_DATE, PERIOD_ONHOLD_END_DATE))) AS NUMBER_DAYS_ONHOLD_OLDAUTH
, COALESCE(r.WEEKLY_HOURS, r.OLD_HOURS_WEEKLY, 0) HOURS_WEEKLY_NEWAUTH
,NVL(DATEDIFF('DAY', PERIOD_BEGIN_SERVICE_DATE, COALESCE(PERIOD_REAUTHORIZED_DATE, DATEADD(DAY, 1, PERIOD_END_SERVICE_DATE))), 0) AS NUMBER_DAYS_ACTIVE_OLDAUTH
		,NVL(DATEDIFF('DAY', PERIOD_REAUTHORIZED_DATE, PERIOD_END_SERVICE_DATE) + 1, 0) AS NUMBER_DAYS_ACTIVE_NEWAUTH
,NVL(IFF(PERIOD_ONHOLD_BEGIN_DATE IS NULL, 0, DATEDIFF('DAY', PERIOD_REAUTHORIZED_ONHOLD_DATE, PERIOD_ONHOLD_END_DATE) + 1), 0) AS NUMBER_DAYS_ONHOLD_NEWAUTH
,NVL(HOURS_WEEKLY_OLDAUTH / 7 * (NUMBER_DAYS_ACTIVE_OLDAUTH - NUMBER_DAYS_ONHOLD_OLDAUTH), 0) +
  NVL(HOURS_WEEKLY_NEWAUTH / 7 * (NUMBER_DAYS_ACTIVE_NEWAUTH - NUMBER_DAYS_ONHOLD_NEWAUTH), 0) WEEKLY_HOURS_AUTHORIZED,
CAL.CALENDAR_DATE AS REPORT_DATE
FROM reauth r
LEFT JOIN HAH.DIM_DATE CAL
    ON DERIVED_BEGIN_SERVICE_DATE <= IFF(DATE_PART('day',DERIVED_BEGIN_SERVICE_DATE) <> 1,(DATEADD('month',1,CAL.CALENDAR_DATE)),CAL.CALENDAR_DATE)
        AND DERIVED_END_SERVICE_DATE >= CAL.CALENDAR_DATE
LEFT JOIN HAH.DIM_BRANCH b
	    ON b.BRANCH_NAME = r.INTAKE_OFFICE_NAME
        AND b.SYSTEM_CODE = r.DBNAME
--    LEFT JOIN HAH.DIM_CLIENT c
    LEFT JOIN CLIENT_DATA c
        ON c.CLIENT_NUMBER = r.CLIENT_NUMBER
        AND c.DBNAME = r.DBNAME
    LEFT JOIN HAH.DIM_CONTRACT n
        ON n.CONTRACT_CODE = r.CONTRACT_CODE
        AND n.SYSTEM_CODE = r.DBNAME
 WHERE CAL.DAY_OF_MONTH = 1
), auth_final_data AS (
SELECT 
L.REPORT_DATE, L.BRANCH_KEY, L.CLIENT_NUMBER, L.CONTRACT_KEY, L.SOURCE_SYSTEM_ID
	,L.WEEKLY_HOURS_AUTHORIZED * CAST(
			(DATEDIFF(DAY, L.START_DATE_WITH_CUTOVER, L.END_DATE_WITH_CUTOVER) + 1)
			/ DAY(LAST_DAY(L.REPORT_DATE)) AS DECIMAL(12, 5)) AS WEEKLY_HOURS_AUTHORIZED
FROM 
(
SELECT F.*
 , NVL(CUTOVER.START_DATE, F.REPORT_DATE) AS START_DATE_ONLY_CUTOVER
		 , NVL(CUTOVER.END_DATE, LAST_DAY(F.REPORT_DATE)) AS END_DATE_ONLY_CUTOVER
		 , IFF(START_DATE_ONLY_CUTOVER > F.REPORT_DATE, START_DATE_ONLY_CUTOVER, F.REPORT_DATE) AS START_DATE_WITH_CUTOVER
		 , IFF(END_DATE_ONLY_CUTOVER < LAST_DAY(F.REPORT_DATE), END_DATE_ONLY_CUTOVER, LAST_DAY(F.REPORT_DATE)) AS END_DATE_WITH_CUTOVER
FROM auth_final F
LEFT JOIN HAH.FACT_SYSTEM_CUTOVER_DATE AS CUTOVER
		ON CUTOVER.SOURCE_SYSTEM_ID = F.SOURCE_SYSTEM_ID 
			AND CUTOVER.SYSTEM_CODE = F.SYSTEM_CODE
			AND NVL(CUTOVER.BRANCH_KEY, F.BRANCH_KEY) = F.BRANCH_KEY
			AND NVL(CUTOVER.CONTRACT_KEY, F.CONTRACT_KEY) = F.CONTRACT_KEY
) L
WHERE L.REPORT_DATE BETWEEN DATE_TRUNC(MONTH, L.START_DATE_WITH_CUTOVER) AND LAST_DAY(L.END_DATE_WITH_CUTOVER)
)
SELECT DISTINCT CLIENT_KEY,CLIENT_ID,FIRSTNAME,LASTNAME,HOURS_SERVED,SERVICE_MONTH,CONTRACTNAME,OFFICENAME,SUPERVISOR_CODE,AUTH_DATE_REVISED,MONTHLYMAXHOURS_REVISED--,
,A.OLDAUTHORIZEDHOURS_REVISED AS OLDAUTHORIZEDHOURS,SUM(b.WEEKLY_HOURS_AUTHORIZED) WEEKLY_HOURS_AUTHORIZED
FROM fin a
LEFT JOIN auth_final_data b ON a.client_id = b.client_number AND a.service_month = b.report_date
GROUP BY CLIENT_KEY,CLIENT_ID,FIRSTNAME,LASTNAME,HOURS_SERVED,SERVICE_MONTH,CONTRACTNAME,OFFICENAME,SUPERVISOR_CODE,AUTH_DATE_REVISED,MONTHLYMAXHOURS_REVISED,OLDAUTHORIZEDHOURS,OLDAUTHORIZEDHOURS_REVISED
ORDER BY 1 , service_month;
SQL
	or_replace = true 
	is_secure = false 
}

