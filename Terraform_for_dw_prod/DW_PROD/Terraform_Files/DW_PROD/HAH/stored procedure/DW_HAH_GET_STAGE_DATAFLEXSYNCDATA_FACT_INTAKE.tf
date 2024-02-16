resource "snowflake_procedure" "DW_HAH_GET_STAGE_DATAFLEXSYNCDATA_FACT_INTAKE" {
	name ="GET_STAGE_DATAFLEXSYNCDATA_FACT_INTAKE"
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
-- NAME:  DataFlexSyncData_FACT_INTAKE
--
-- PURPOSE: Creates one row per INTAKE according to Dataflexsync
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 01/29/20     Rachel Stewart      Initial development
-- 02/12/20     Greg Marsh          Updated to sync with current DDL
-- 03/04/20    Rachel Stewart       Updated to use weekly auths
-- 03/13/20    Rachel Stewaret      Updated to remove weekly auth adjustment to match Dataflex report per 3/12 request
-- 04/01/20		Mohd Kamaludin		 Added CDC
-- 04/23/20		Mir Ali				Added OLD_HOURS_MONTHLY field for calculating weekly contracts
-- 05/11/20		Mir Ali				Added coalesce(old_monthly_hours, monthly_hours) to avoid null authorized hours
-- 05/12/20 	Arif Ansari			Add logic to Populate Contract Bill Rate
-- 05/13/20		Mir Ali				Add adjusted auth calculation
-- 06/18/20		Mir Ali				Added CDC date check for DfClients table also (to check for change in Begin/End Service dates and/or OnHold dates)
--									Changed derived_end_service_date to be last_day of month after 1 year is added
-- 07/22/21		Mir Ali				Revised logic for better incremental loading
-- 02/28/22     Deven Kapasi         Leveraged dataflex dedupe tables
-- 04/04/22		Mir Ali				Added cutover logic for Alayacare
-- 04/19/22		Pooja Shah			Enhancement to include Auth Dates & PreAuthNo.
-- 04/08/23     DEEPEN GAJJAR		FIXED ISSUE HAVING MULTIPLE INTAKE RECORDS HAVING SAME CONTRACT IN A MONTH FOR A CLIENT
-- 09/08/23     Mirisha             Dedupe change for Client_key(MASTER_CLIENT_NUMBER)
--*****************************************************************************************************************************
-- select * from STAGE.DATAFLEXSYNCDATA_FACT_INTAKE
INSERT OVERWRITE INTO STAGE.DATAFLEXSYNCDATA_FACT_INTAKE
WITH MAXREAUTH AS (
    SELECT MAX(CA.STARTDATE :: date) AS MAX_REAUTH
         , CA.CONTRACTCODE
         , CA.CLIENTNUMBER
         , CA.DBNAME
 FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTAUTHORIZATIONS CA
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
     GROUP BY CA.CONTRACTCODE
            , CA.CLIENTNUMBER
            , CA.DBNAME
 ),
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
),
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
 	WHERE C.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
  	--UNION 
 	--SELECT R.DBNAME , R.CLIENTNUMBER 
 	--FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTRATES R
 	--WHERE R.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
 	-- UNION 
 	-- SELECT A.DBNAME , A.CLIENTNUMBER 
 	-- FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTAUTHORIZATIONS A
 	-- WHERE A.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
 ),
CHANGED_CONTRACTS AS (
 	SELECT A.DBNAME , A.CLIENTNUMBER , A.CONTRACTCODE 
 	FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTAUTHORIZATIONS A
 	WHERE A.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
 	UNION 
 	SELECT A.DBNAME , A.CLIENTNUMBER , A.CONTRACTCODE 
 	FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTS A
 	WHERE A.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
 ),
  REAUTH AS(
     SELECT CASE
                WHEN ((C.BEGINSERVICEDATE IS NULL) AND (F.BEGINSERVICEDATE IS NULL)) THEN T.TIMESHEET_DATE
--				ELSE IFF(C.BEGINSERVICEDATE < F.BEGINSERVICEDATE, C.BEGINSERVICEDATE, F.BEGINSERVICEDATE)
                ELSE IFF(COALESCE(C.BEGINSERVICEDATE, F.BEGINSERVICEDATE) <= F.BEGINSERVICEDATE, F.BEGINSERVICEDATE, C.BEGINSERVICEDATE)
         END                                                                                            AS DERIVED_BEGIN_SERVICE_DATE
          , IFF(DATE_PART(''year'', DERIVED_BEGIN_SERVICE_DATE) < 1990, null,
                DERIVED_BEGIN_SERVICE_DATE)                                                             AS CLEAN_BEGIN_SERVICE_DATE
--          , MARA.MAX_REAUTH                                                                             AS REAUTHORIZED_DATE
          , MARA.MAX_REAUTH																				AS REAUTHORIZED_DATE
--          , MIRA.MIN_REAUTH                                                                             AS MIN_REAUTH
          , CASE
                WHEN (C.ENDSERVICEDATE IS NULL) AND (F.ENDSERVICEDATE IS NULL) THEN LAST_DAY(DATEADD(''year'', 1, CURRENT_DATE()), MONTH)
                ELSE IFF(COALESCE(C.ENDSERVICEDATE, F.ENDSERVICEDATE) >= F.ENDSERVICEDATE, F.ENDSERVICEDATE, C.ENDSERVICEDATE)
         END                                                                                               DERIVED_END_SERVICE_DATE
          , C.ONHOLDSTARTDATE 																			AS ONHOLDSTARTDATE
          , C.ONHOLDENDDATE 																			AS ONHOLDENDDATE
		  , NVL(C.OFFICENUMBER, -1) 																	AS INTAKE_OFFICE_CODE
          , O.OFFICENAME                                                                                AS INTAKE_OFFICE_NAME
          , F.CASEWORKERMANAGER                                                                         AS SUPERVISOR_NAME
          , F.CLIENTNUMBER                                                                              AS CLIENT_NUMBER
          , F.CONTRACTCODE                                                                              AS CONTRACT_CODE
          , F.DBNAME                                                                                    AS DBNAME
          , IFF(EC.AUTHTYPE = ''WEEKLY_CAREPLAN'', ''Weekly'', ''Monthly'')                                   AS AUTH_TYPE
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
                                          AND F.AUTHTYPE IN (''I'', ''D'')
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
	WHERE F.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
	OR C.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
			OR CHANGED_CLIENTS.DBNAME IS NOT NULL
			OR CHANGED_CONTRACTS.DBNAME IS NOT NULL			
     GROUP BY F.BEGINSERVICEDATE
            , C.BEGINSERVICEDATE
            , F.ENDSERVICEDATE
            , F.CLIENTNUMBER
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
   ,ServiceMonths
	AS
	(
		SELECT 
			CALENDAR_DATE ServiceMonthBeginDate
			,MONTH ServiceMonth 
			,YEAR SERVICEYEAR 
			,LAST_DAY_OF_MONTH  SERVICEMONTHENDDATE
			,DATEDIFF(''day'', CAL.CALENDAR_DATE, LAST_DAY(CAL.CALENDAR_DATE))+1 AS TotalDays_InServiceMonth 
		FROM HAH.DIM_DATE  cal
		WHERE CALENDAR_DATE >= (SELECT MIN(DERIVED_BEGIN_SERVICE_DATE) FROM REAUTH)  AND CALENDAR_DATE <= (SELECT MAX(DERIVED_END_SERVICE_DATE) FROM REAUTH)
		AND DAY_OF_MONTH = 1
	)
   ,ContractRates(DbName, ServiceMonth, ServiceYear, ServiceMonthBeginDate, ServiceMonthEndDate, ContractCode,
                    BillableContract, UseBillCode, RateEffectiveDate, UnitBillRate, BillByQuarterHours, BillByHalfHours
                   )
	AS 
	(
	SELECT 
		Contracts.DbName,
		ServiceMonths.ServiceMonth,
		ServiceMonths.ServiceYear,
		ServiceMonths.ServiceMonthBeginDate,
		ServiceMonths.ServiceMonthEndDate,
		Contracts.ContractCode,
		Contracts.BillableContract,
		Contracts.UseBillCode,
		-- Select the current rate for the service month
		IFF(Contracts.RateEffectiveDate2 <= ServiceMonths.ServiceMonthEndDate,
		Contracts.RateEffectiveDate2,
		Contracts.RateEffectiveDate1) RateEffectiveDate,
		IFF(Contracts.RateEffectiveDate2 <= ServiceMonths.ServiceMonthEndDate, Contracts.Rate2, Contracts.Rate1) UnitBillRate,
		Contracts.BilledByQuarterHours,
		Contracts.BillByHalfHours
		FROM
		(
			SELECT 
			Contracts.DbName,
			Contracts.ContractCode,
			Contracts.UseBillCode,
			Contracts.Billable BillableContract,
			Contracts.BilledByQuarterHours,
			Contracts.BillByHalfHours,
			Contracts.IsMileage,
			-- Normalize date/rate columns by chronological order
			IFF(NVL(Contracts.RateEffectiveDate1, ''1/1/1900'') > NVL(Contracts.RateEffectiveDate2, ''1/1/1900''),
			Contracts.RateEffectiveDate2,
			Contracts.RateEffectiveDate1) RateEffectiveDate1,
			IFF(NVL(Contracts.RateEffectiveDate1, ''1/1/1900'') > NVL(Contracts.RateEffectiveDate2, ''1/1/1900''),
			Contracts.RateEffectiveDate1,
			Contracts.RateEffectiveDate2) RateEffectiveDate2,
			IFF(NVL(Contracts.RateEffectiveDate1, ''1/1/1900'') > NVL(Contracts.RateEffectiveDate2, ''1/1/1900''),
			Contracts.Rate2,
			Contracts.Rate1) Rate1,
			IFF(NVL(Contracts.RateEffectiveDate1, ''1/1/1900'') > NVL(Contracts.RateEffectiveDate2, ''1/1/1900''),
			Contracts.Rate1,
			Contracts.Rate2) Rate2
			FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCONTRACTS Contracts 
		) Contracts, ServiceMonths
	)
	,ClientRates_AL (DbName, ServiceMonth, ServiceYear, ContractCode, AvgBillRate) 
	AS 
	(
		SELECT 
			BillRates.DbName,
			ServiceMonths.ServiceMonth,
			ServiceMonths.ServiceYear,
			BillRates.Contract,
			-- Select average rate for all bill codes for a contract, for the service month
			AVG(IFF(BillRates.Effect_Date2 <= ServiceMonths.ServiceMonthEndDate,BillRates.Bill_Rate2,BillRates.Bill_Rate1)) BillRate
		FROM
		(
		SELECT 
			DbName,
			Contract,
			Billcode,
			-- "Normalize" columns (first effect_date in column 1, second effect_date in column 2)
			IFF(NVL(Effect_Date1, ''1/1/1900'') > NVL(Effect_Date2, ''1/1/1900''), Effect_Date2, Effect_Date1) Effect_Date1,
			IFF(NVL(Effect_Date1, ''1/1/1900'') > NVL(Effect_Date2, ''1/1/1900''), Billrate2, Billrate) Bill_Rate1,
			IFF(NVL(Effect_Date1, ''1/1/1900'') > NVL(Effect_Date2, ''1/1/1900''), Effect_Date1, Effect_Date2) Effect_Date2,
			IFF(NVL(Effect_Date1, ''1/1/1900'') > NVL(Effect_Date2, ''1/1/1900''), Billrate, Billrate2) Bill_Rate2,
			CreatedDate,
			UpdateBatch,
			UpdatedTime
		FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFBILLRATES 
		) BillRates, ServiceMonths
		WHERE NOT (NVL(BillRates.Bill_Rate1,0)=0 AND NVL(BillRates.Bill_Rate2,0))
		GROUP BY BillRates.DbName,
				 ServiceMonths.ServiceMonth,
				 ServiceMonths.ServiceYear,
				 BillRates.Contract
	)
	, CTEClientContract AS
	(
		SELECT 
			ClientContractRates.DbName,
			ClientContractRates.ClientNumber,
			ClientContractRates.ContractCode
			,ClientContractRates.ServiceYear
			,ClientContractRates.ServiceMonth
			,AVG(ClientContractRates.BillRate) AvgBillRate
		FROM
		(
			SELECT 
				ClientContractRates.DbName,
				ClientContractRates.ClientNumber,
				ClientContractRates.BillCode,
				ClientContractRates.BillRate,
				ClientContractRates.ContractCode
				,ServiceMonths.ServiceYear
				,ServiceMonths.ServiceMonth
				,DENSE_RANK() OVER (PARTITION BY ClientContractRates.DbName,
				ClientContractRates.ClientNumber,
				ClientContractRates.BillCode,
				ClientContractRates.ContractCode
				,ServiceMonths.ServiceYear
				,ServiceMonths.ServiceMonth
				ORDER BY CASE	
							WHEN NVL(ClientContractRates.EffectiveDate, ''1/1/1900'') <= ServiceMonths.ServiceMonthEndDate THEN 1
							ELSE
							0
							END 
						DESC,
						NVL(ClientContractRates.EffectiveDate, ''1/1/1900'') DESC
				) RowNumber
			FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTRATES ClientContractRates , ServiceMonths
			WHERE NVL(ClientContractRates.BillRate,0)<>0	
		) ClientContractRates
		WHERE ClientContractRates.RowNumber = 1
		GROUP BY ClientContractRates.DbName,
				 ClientContractRates.ClientNumber,
				 ClientContractRates.ContractCode
				 ,ClientContractRates.ServiceYear
				,ClientContractRates.ServiceMonth
	)
	, ClientContractRates
	AS
	(
		SELECT 
			ContractRates.DbName,
			ContractRates.ServiceMonth,
			ContractRates.ServiceYear,
			ContractRates.ServiceMonthBeginDate,
			ContractRates.ContractCode,
			ct.ClientNumber,
			(IFF(NVL(ContractRates.UnitBillRate, 0) > 0,
			ContractRates.UnitBillRate,
			COALESCE(ClientRates_AL.AvgBillRate, ct.AvgBillRate))
			) -- UnitBillRate
			* IFF(ContractRates.DbName NOT IN ( ''AL'' ),
				CASE
					WHEN NVL(ContractRates.BillByQuarterHours, 0) = 1 THEN
						4
					WHEN NVL(ContractRates.BillByHalfHours, 0) = 1 THEN
						2
					ELSE
						1
				END,
				1) BillRate
		FROM ContractRates ContractRates 
		LEFT JOIN ClientRates_AL ClientRates_AL 
		ON ContractRates.DbName = ''AL''
		AND ContractRates.BillableContract = 1
		AND NVL(ContractRates.UnitBillRate, 0) <= 0
		AND ClientRates_AL.DbName = ContractRates.DbName
		AND ClientRates_AL.ContractCode = ContractRates.ContractCode
		AND ClientRates_AL.ServiceYear = ContractRates.ServiceYear
		AND ClientRates_AL.ServiceMonth = ContractRates.ServiceMonth
		LEFT JOIN CTEClientContract  ct
		ON ct.DbName = ContractRates.DbName
		AND ct.ContractCode = ContractRates.ContractCode
		AND ContractRates.BillableContract = 1
		AND NVL(ContractRates.UnitBillRate, 0) <= 0
		AND ClientRates_AL.DbName IS NULL
		AND ContractRates.ServiceYear = ct.ServiceYear
		and ContractRates.ServiceMonth = ct.ServiceMonth	
	)
,CLIENT_DATA AS
(
	SELECT * FROM
	(
		SELECT TRIM(DBNAME) AS MASTER_DBNAME,
         TRIM(REGEXP_REPLACE(MASTER_ID,DBNAME))::NUMBER AS MASTER_CLIENT_NUMBER,
         TRIM(DBNAME) AS DBNAME,
        "NUMBER" AS CLIENT_NUMBER
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.CLIENT_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT TRIM(MASTER.DBNAME) AS MASTER_DBNAME,
        TRIM(REGEXP_REPLACE(MASTER.MASTER_ID,MASTER.DBNAME))::NUMBER AS MASTER_CLIENT_NUMBER, 
        TRIM(MATCH.DBNAME) AS DBNAME, 
        MATCH."NUMBER" AS CLIENT_NUMBER
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.CLIENT_MATCH_LIST AS MATCH
        JOIN DISC_DEDUPE_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.CLIENT_MASTER_LIST AS MASTER 
            ON MASTER.MASTER_ID = MATCH.MASTER_ID
        WHERE MATCH.ID <> MATCH.MASTER_ID
	)
), DUP_INTAKE AS (
SELECT DISTINCT  CAL.CALENDAR_DATE ,  
COALESCE(CLI.MASTER_CLIENT_NUMBER, F.CLIENTNUMBER) AS MASTER_CLIENT,
F.CLIENTNUMBER ,
 CASE
                WHEN ((C.BEGINSERVICEDATE IS NULL) AND (F.BEGINSERVICEDATE IS NULL)) THEN T.TIMESHEET_DATE
--				ELSE IFF(C.BEGINSERVICEDATE < F.BEGINSERVICEDATE, C.BEGINSERVICEDATE, F.BEGINSERVICEDATE)
                ELSE IFF(COALESCE(C.BEGINSERVICEDATE, F.BEGINSERVICEDATE) <= F.BEGINSERVICEDATE, F.BEGINSERVICEDATE, C.BEGINSERVICEDATE)
         END AS DERIVED_BEGIN_SERVICE_DATE
, CASE
                WHEN (C.ENDSERVICEDATE IS NULL) AND (F.ENDSERVICEDATE IS NULL) THEN LAST_DAY(DATEADD(''year'', 1, CURRENT_DATE()), MONTH)
                ELSE IFF(COALESCE(C.ENDSERVICEDATE, F.ENDSERVICEDATE) >= F.ENDSERVICEDATE, F.ENDSERVICEDATE, C.ENDSERVICEDATE)
         END DERIVED_END_SERVICE_DATE, f.CONTRACTCODE , f.DBNAME 
,COUNT(1) OVER (PARTITION BY CAL.CALENDAR_DATE, MASTER_CLIENT, F.CONTRACTCODE, F.DBNAME) AS CNT
,md5(COALESCE(F.DBNAME, '''') || ''-'' || NVL(CAL.CALENDAR_DATE::string,'''') || ''-'' || COALESCE(F.CLIENTNUMBER ,-1) || ''-'' || NVL(F.CONTRACTCODE ,'''')) AS INTAKE_KEY
FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTCONTRACTS f
JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCLIENTS c ON f.CLIENTNUMBER = c."NUMBER" AND f.DBNAME =c.DBNAME 
LEFT JOIN TIMESHEETS T ON F.DBNAME = T.DBNAME AND F.CLIENTNUMBER = T.CLIENTNUMBER AND T.CONTRACTCODE = F.CONTRACTCODE
LEFT JOIN HAH.DIM_DATE CAL
    ON DERIVED_BEGIN_SERVICE_DATE <= IFF(DATE_PART(''day'',DERIVED_BEGIN_SERVICE_DATE) <> 1,(DATEADD(''month'',1,CAL.CALENDAR_DATE)),CAL.CALENDAR_DATE)
        AND DERIVED_END_SERVICE_DATE >= CAL.CALENDAR_DATE
LEFT JOIN CLIENT_DATA CLI
        ON CLI.CLIENT_NUMBER = F.CLIENTNUMBER 
        AND CLI.DBNAME = F.DBNAME
WHERE iff(date(:STR_CDC_START::TIMESTAMP_NTZ)=''1900-01-01'', f.ETL_LAST_UPDATED_DATE>=:STR_CDC_START::TIMESTAMP_NTZ  ,f.ETL_LAST_UPDATED_DATE >=date_trunc(''month'',dateadd(''year'',-3,current_date)))
AND CAL.DAY_OF_MONTH =''1''
QUALIFY COUNT(1) OVER (PARTITION BY CAL.CALENDAR_DATE, MASTER_CLIENT, F.CONTRACTCODE, F.DBNAME) >1
)
,FINAL AS (
   SELECT
          md5(COALESCE(r.DBNAME, '''') || ''-'' || NVL(CAL.CALENDAR_DATE::string,'''') || ''-'' || COALESCE(r.CLIENT_NUMBER,-1) || ''-'' || NVL(r.CONTRACT_CODE,'''')) AS INTAKE_KEY
         ,CAL.CALENDAR_DATE AS REPORT_DATE
         ,nvl(b.BRANCH_KEY, md5(r.DBNAME || ''-'' || r.INTAKE_OFFICE_CODE || ''-'' ||  ''DATAFLEXSYNCDATA'')) AS BRANCH_KEY
         ,md5(COALESCE(c.MASTER_DBNAME, r.DBNAME, '''') || ''-'' || COALESCE(c.MASTER_CLIENT_NUMBER, r.CLIENT_NUMBER,-1) || ''-''  ||  ''DATAFLEXSYNCDATA'' ) AS CLIENT_KEY
         ,nvl(n.CONTRACT_KEY, md5(r.DBNAME || ''-'' || nvl(r.CONTRACT_CODE,''Unknown'') || ''-''  ||  ''DATAFLEXSYNCDATA'')) AS CONTRACT_KEY
         ,3 AS SOURCE_SYSTEM_ID
		 ,r.PRE_AUTH_NUMBER   		-- Added by PJShah on 19042022
         ,r.CLIENT_BEGIN_SERVICE_DATE 	-- Added by PJShah on 19042022
         ,r.CLIENT_END_SERVICE_DATE	 	-- Added by PJShah on 19042022
         ,r.LATEST_AUTH_BEGIN_DATE	-- Added by PJShah on 19042022
         ,r.LATEST_AUTH_END_DATE	-- Added by PJShah on 19042022
--         ,coalesce(r.REAUTHORIZED_DATE, r.REAUTHORIZED_DATE, CAL.CALENDAR_DATE) as REAUTHORIZED_DATE
         ,r.REAUTHORIZED_DATE
         ,INTAKE_OFFICE_NAME AS BRANCH_NAME
         ,COALESCE(c.CLIENT_NUMBER,r.CLIENT_NUMBER, -1) AS CLIENT_NUMBER
         ,r.CONTRACT_CODE
         ,r.DBNAME AS SYSTEM_CODE
         ,SUPERVISOR_NAME as CASE_MANAGER
--         ,IFF((CASE WHEN REPORT_DATE < DATE_TRUNC(''month'',REAUTHORIZED_DATE) THEN COALESCE(r.OLD_HOURS_MONTHLY, MONTHLY_HOURS)
--            ELSE COALESCE(MONTHLY_HOURS, r.OLD_HOURS_MONTHLY)
--            END) > 744, 744, (CASE WHEN REPORT_DATE < DATE_TRUNC(''month'',MIN_REAUTH) THEN COALESCE(r.OLD_HOURS_MONTHLY, MONTHLY_HOURS)
--            ELSE COALESCE(MONTHLY_HOURS, r.OLD_HOURS_MONTHLY)
--            END)) AS MONTHLY_HOURS_AUTHORIZED_MAX
--         ,IFF((CASE WHEN REPORT_DATE < DATE_TRUNC(''month'',REAUTHORIZED_DATE) THEN r.OLD_HOURS_WEEKLY
--            ELSE WEEKLY_HOURS
--            END) > 168, 168, (CASE WHEN REPORT_DATE < DATE_TRUNC(''month'',MIN_REAUTH) THEN r.OLD_HOURS_WEEKLY
--            ELSE WEEKLY_HOURS
--            END)) AS WEEKLY_HOURS_AUTHORIZED_MAX
         ,CASE WHEN REPORT_DATE < DATE_TRUNC(''month'',REAUTHORIZED_DATE) THEN COALESCE(NULLIF(r.OLD_HOURS_MONTHLY, 0), MONTHLY_HOURS)
            ELSE COALESCE(MONTHLY_HOURS, r.OLD_HOURS_MONTHLY)
            END AS MONTHLY_HOURS_NON_ADJUSTED
--         ,CASE WHEN REPORT_DATE < DATE_TRUNC(''month'',REAUTHORIZED_DATE) THEN COALESCE(NULLIF(r.OLD_HOURS_WEEKLY, 0), WEEKLY_HOURS)
--            ELSE COALESCE(WEEKLY_HOURS, r.OLD_HOURS_WEEKLY)
--            END AS WEEKLY_HOURS_AUTHORIZED_MAX
		, COALESCE(NULLIF(r.OLD_HOURS_MONTHLY, 0), r.MONTHLY_HOURS) HOURS_MONTHLY_OLDAUTH
		, COALESCE(r.MONTHLY_HOURS, r.OLD_HOURS_MONTHLY, 0) HOURS_MONTHLY_NEWAUTH
		, COALESCE(NULLIF(r.OLD_HOURS_WEEKLY, 0), r.WEEKLY_HOURS) HOURS_WEEKLY_OLDAUTH
		, COALESCE(r.WEEKLY_HOURS, r.OLD_HOURS_WEEKLY, 0) HOURS_WEEKLY_NEWAUTH
            --        ,DATEDIFF(''day'', CAL.CALENDAR_DATE, LAST_DAY(CAL.CALENDAR_DATE))+1 AS NUMBER_DAYS
		,IFF(r.DERIVED_BEGIN_SERVICE_DATE <= CAL.FIRST_DAY_OF_MONTH, CAL.FIRST_DAY_OF_MONTH, r.DERIVED_BEGIN_SERVICE_DATE) AS PERIOD_BEGIN_SERVICE_DATE
		,IFF(r.DERIVED_END_SERVICE_DATE >= CAL.LAST_DAY_OF_MONTH, CAL.LAST_DAY_OF_MONTH, r.DERIVED_END_SERVICE_DATE) AS PERIOD_END_SERVICE_DATE
		,CASE WHEN r.ONHOLDSTARTDATE IS NULL OR r.ONHOLDENDDATE < PERIOD_BEGIN_SERVICE_DATE OR r.ONHOLDSTARTDATE > PERIOD_END_SERVICE_DATE THEN NULL
			WHEN r.ONHOLDSTARTDATE <= PERIOD_BEGIN_SERVICE_DATE THEN PERIOD_BEGIN_SERVICE_DATE
			ELSE r.ONHOLDSTARTDATE END AS PERIOD_ONHOLD_BEGIN_DATE
		,CASE WHEN PERIOD_ONHOLD_BEGIN_DATE IS NULL THEN NULL ELSE IFF(COALESCE(r.ONHOLDENDDATE, PERIOD_END_SERVICE_DATE) >= PERIOD_END_SERVICE_DATE, PERIOD_END_SERVICE_DATE, COALESCE(r.ONHOLDENDDATE, PERIOD_END_SERVICE_DATE)) END AS PERIOD_ONHOLD_END_DATE
        ,CASE WHEN COALESCE(r.REAUTHORIZED_DATE, PERIOD_BEGIN_SERVICE_DATE) <= PERIOD_BEGIN_SERVICE_DATE THEN PERIOD_BEGIN_SERVICE_DATE
			WHEN r.REAUTHORIZED_DATE > PERIOD_END_SERVICE_DATE THEN NULL 
        	ELSE r.REAUTHORIZED_DATE END AS PERIOD_REAUTHORIZED_DATE
        ,CASE WHEN COALESCE(r.REAUTHORIZED_DATE, PERIOD_ONHOLD_BEGIN_DATE) <= PERIOD_ONHOLD_BEGIN_DATE THEN PERIOD_ONHOLD_BEGIN_DATE
			WHEN r.REAUTHORIZED_DATE > PERIOD_ONHOLD_END_DATE THEN NULL 
        	ELSE r.REAUTHORIZED_DATE END AS PERIOD_REAUTHORIZED_ONHOLD_DATE
        	,NVL(DATEDIFF(''DAY'', PERIOD_BEGIN_SERVICE_DATE, COALESCE(PERIOD_REAUTHORIZED_DATE, DATEADD(DAY, 1, PERIOD_END_SERVICE_DATE))), 0) AS NUMBER_DAYS_ACTIVE_OLDAUTH
		,NVL(DATEDIFF(''DAY'', PERIOD_REAUTHORIZED_DATE, PERIOD_END_SERVICE_DATE) + 1, 0) AS NUMBER_DAYS_ACTIVE_NEWAUTH
		,IFF(PERIOD_ONHOLD_BEGIN_DATE IS NULL, 0, DATEDIFF(''DAY'', PERIOD_ONHOLD_BEGIN_DATE, COALESCE(PERIOD_REAUTHORIZED_ONHOLD_DATE, PERIOD_ONHOLD_END_DATE))) AS NUMBER_DAYS_ONHOLD_OLDAUTH
		,NVL(IFF(PERIOD_ONHOLD_BEGIN_DATE IS NULL, 0, DATEDIFF(''DAY'', PERIOD_REAUTHORIZED_ONHOLD_DATE, PERIOD_ONHOLD_END_DATE) + 1), 0) AS NUMBER_DAYS_ONHOLD_NEWAUTH
		,NVL(HOURS_MONTHLY_OLDAUTH / DAY(CAL.LAST_DAY_OF_MONTH) * (NUMBER_DAYS_ACTIVE_OLDAUTH - NUMBER_DAYS_ONHOLD_OLDAUTH), 0) +
			NVL(HOURS_MONTHLY_NEWAUTH / DAY(CAL.LAST_DAY_OF_MONTH) * (NUMBER_DAYS_ACTIVE_NEWAUTH - NUMBER_DAYS_ONHOLD_NEWAUTH), 0) AS MONTHLY_HOURS_AUTHORIZED -- Daily hours calculated from max monthly hours, multiplied by client''s "active days"
        --        ,NUMBER_DAYS/7 AS FULL_WEEKS
        ,NVL(HOURS_WEEKLY_OLDAUTH / 7 * (NUMBER_DAYS_ACTIVE_OLDAUTH - NUMBER_DAYS_ONHOLD_OLDAUTH), 0) +
        	NVL(HOURS_WEEKLY_NEWAUTH / 7 * (NUMBER_DAYS_ACTIVE_NEWAUTH - NUMBER_DAYS_ONHOLD_NEWAUTH), 0) WEEKLY_HOURS_AUTHORIZED
        ,r.AUTH_TYPE AS AUTH_TYPE,
		IFF(r.AUTH_TYPE = ''Weekly'', WEEKLY_HOURS_AUTHORIZED, MONTHLY_HOURS_AUTHORIZED) AS HOURS_AUTHORIZED,
        ccr.BillRate,
        r.DERIVED_BEGIN_SERVICE_DATE,
            ---- ETL FIELDS ___
		
    :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
                        
        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
        CURRENT_USER as ETL_INSERTED_BY ,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
        CURRENT_USER as ETL_LAST_UPDATED_BY,
        0 as ETL_DELETED_FLAG
    FROM REAUTH r
    LEFT JOIN HAH.DIM_DATE CAL
    ON DERIVED_BEGIN_SERVICE_DATE <= IFF(DATE_PART(''day'',DERIVED_BEGIN_SERVICE_DATE) <> 1,(DATEADD(''month'',1,CAL.CALENDAR_DATE)),CAL.CALENDAR_DATE)
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
	LEFT JOIN ClientContractRates CCR
		ON 
		ccr.ServiceMonthBeginDate=  CAL.CALENDAR_DATE
		AND ccr.DBName = r.DBNAME 
		AND CCR.ContractCode = r.CONTRACT_CODE
		AND NVL(CCR.ClientNumber, r.CLIENT_NUMBER) = r.CLIENT_NUMBER
    WHERE CAL.DAY_OF_MONTH = 1
     )
SELECT L.INTAKE_KEY, L.REPORT_DATE, L.BRANCH_KEY, L.CLIENT_KEY, L.CONTRACT_KEY, L.SOURCE_SYSTEM_ID,
		   L.PRE_AUTH_NUMBER   		-- Added by PJShah on 19042022
         , L.CLIENT_BEGIN_SERVICE_DATE		-- Added by PJShah on 19042022
         , L.CLIENT_END_SERVICE_DATE		-- Added by PJShah on 19042022
         , L.LATEST_AUTH_BEGIN_DATE	-- Added by PJShah on 19042022
         , L.LATEST_AUTH_END_DATE	-- Added by PJShah on 19042022	
 		,L.REAUTHORIZED_DATE,
	L.BRANCH_NAME, L.CLIENT_NUMBER, L.CONTRACT_CODE, L.BILL_RATE, L.SYSTEM_CODE, L.CASE_MANAGER,
	L.HOURS_AUTHORIZED * CAST(
			(DATEDIFF(DAY, L.START_DATE_WITH_CUTOVER, L.END_DATE_WITH_CUTOVER) + 1)
			/ DAY(LAST_DAY(L.REPORT_DATE)) AS DECIMAL(12, 5)) AS HOURS_AUTHORIZED,
	L.HOURS_AUTHORIZED_NON_ADJUSTED,
	L.ETL_TASK_KEY, L.ETL_INSERTED_TASK_KEY, L.ETL_INSERTED_DATE, L.ETL_INSERTED_BY, L.ETL_LAST_UPDATED_DATE, L.ETL_LAST_UPDATED_BY, L.ETL_DELETED_FLAG
FROM (
	SELECT F.INTAKE_KEY
	     , F.REPORT_DATE
		 , NVL(CUTOVER.START_DATE, F.REPORT_DATE) AS START_DATE_ONLY_CUTOVER
		 , NVL(CUTOVER.END_DATE, LAST_DAY(F.REPORT_DATE)) AS END_DATE_ONLY_CUTOVER
		 , IFF(START_DATE_ONLY_CUTOVER > F.REPORT_DATE, START_DATE_ONLY_CUTOVER, F.REPORT_DATE) AS START_DATE_WITH_CUTOVER
		 , IFF(END_DATE_ONLY_CUTOVER < LAST_DAY(F.REPORT_DATE), END_DATE_ONLY_CUTOVER, LAST_DAY(F.REPORT_DATE)) AS END_DATE_WITH_CUTOVER
	     , F.BRANCH_KEY
	     , F.CLIENT_KEY
	     , F.CONTRACT_KEY
	     , F.SOURCE_SYSTEM_ID
		 , F.PRE_AUTH_NUMBER   		-- Added by PJShah on 19042022
         , F.CLIENT_BEGIN_SERVICE_DATE		-- Added by PJShah on 19042022
         , F.CLIENT_END_SERVICE_DATE		-- Added by PJShah on 19042022
         , F.LATEST_AUTH_BEGIN_DATE	-- Added by PJShah on 19042022
         , F.LATEST_AUTH_END_DATE	-- Added by PJShah on 19042022	
	     , COALESCE(F.REAUTHORIZED_DATE, F.DERIVED_BEGIN_SERVICE_DATE) AS REAUTHORIZED_DATE
	     , F.BRANCH_NAME
	     , F.CLIENT_NUMBER
	     , F.CONTRACT_CODE
		 , F.BillRate AS BILL_RATE
	     , F.SYSTEM_CODE
	     , F.CASE_MANAGER
	     , F.HOURS_AUTHORIZED AS HOURS_AUTHORIZED
	     , F.MONTHLY_HOURS_NON_ADJUSTED AS HOURS_AUTHORIZED_NON_ADJUSTED
	     , F.ETL_TASK_KEY
	     , F.ETL_INSERTED_TASK_KEY
	     , F.ETL_INSERTED_DATE
	     , F.ETL_INSERTED_BY
	     , F.ETL_LAST_UPDATED_DATE
	     , F.ETL_LAST_UPDATED_BY
	     , F.ETL_DELETED_FLAG
	FROM FINAL F
	LEFT JOIN HAH.FACT_SYSTEM_CUTOVER_DATE AS CUTOVER
		ON CUTOVER.SOURCE_SYSTEM_ID = F.SOURCE_SYSTEM_ID 
			AND CUTOVER.SYSTEM_CODE = F.SYSTEM_CODE
			AND NVL(CUTOVER.BRANCH_KEY, F.BRANCH_KEY) = F.BRANCH_KEY
			AND NVL(CUTOVER.CONTRACT_KEY, F.CONTRACT_KEY) = F.CONTRACT_KEY
	LEFT JOIN DUP_INTAKE DI ON DI.INTAKE_KEY = F.INTAKE_KEY AND DI.MASTER_CLIENT <> DI.CLIENTNUMBER
	WHERE DI.INTAKE_KEY IS NULL --IF THERE ARE MULTIPLE INTAKE KEYS HAVING SAME CONTRACT IN A MONTH IT WILL PICK THE INTAKE RECORD OF A MASTER CLIENT
) L
WHERE L.REPORT_DATE BETWEEN DATE_TRUNC(MONTH, L.START_DATE_WITH_CUTOVER) AND LAST_DAY(L.END_DATE_WITH_CUTOVER);
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;

 EOT
}

