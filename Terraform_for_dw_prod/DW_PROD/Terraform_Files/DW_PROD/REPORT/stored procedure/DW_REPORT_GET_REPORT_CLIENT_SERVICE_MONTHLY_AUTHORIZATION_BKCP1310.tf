resource "snowflake_procedure" "DW_REPORT_GET_REPORT_CLIENT_SERVICE_MONTHLY_AUTHORIZATION_BKCP1310" {
	name ="GET_REPORT_CLIENT_SERVICE_MONTHLY_AUTHORIZATION_BKCP1310"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
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
-- NAME:  CLIENT_SERVICE_MONTHLY_AUTHORIZATION
--
-- PURPOSE: Creates one row per Month for clients authorization
--
-- 29/08/23    SANKET JAIN          Initial development	
-- 05/10/23	   Nutan Jagnade        Added ASR monthly logic
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.REPORT.CLIENT_SERVICE_MONTHLY_AUTHORIZATION_bkcp1310 

WITH ASR_MONTHLY AS (
-- FOR WEEKLY AND BY_REQUEST RECURRENCE  CALCULATION
WITH WEEKLY_AUTHS AS (
	SELECT 	
      PL.CLIENT_SERVICE_KEY
	 ,D.CALENDAR_DATE	
	 ,D.FIRST_DAY_OF_MONTH
	 ,PL.CLIENT_KEY
	 ,PL.PARTNER_CONTRACT_SERVICE_KEY	 
     ,PL.AUTHORIZATION_DISCIPLINE  
   	 ,PL.AUTHORIZATION_UOM
     ,NULL AS PICKER
  	 ,NULL AS SKIPPER
   	 ,PL.AUTH_INFO
	  , CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN AUTHORIZATION_MAX_UNITS_BY_UOM ELSE 0 END AS HOURS_AUTHORIZED
  	  , CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN IFF(PL.AUTHORIZATION_MAX_UNITS_BY_UOM>0,1,0) ELSE 0 END AS EFFECTIVE_DAYS 
  	  ,PL.AUTHORIZATION_PERIOD_START_DATE
     ,PL.AUTHORIZATION_PERIOD_END_DATE
	  ,HOURS_AUTHORIZED AS HOURS_AUTHORIZED_NON_ADJUSTED
	  ,PL.SOURCE_SYSTEM_ID
	 ,PL.ORIGINAL_SOURCE_SYSTEM_ID
	 ,IFNULL(TRIM(REPLACE(TRIM(REPLACE(PL.AUTHORIZATION_TYPE,''Authorization'')),''UNKNOWN'')),''Hourly'') AS ATYPE
	 ,IFF(PL.AUTHORIZATION_PERIOD_START_DATE <= D.FIRST_DAY_OF_MONTH, D.FIRST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_START_DATE) AS PERIOD_BEGIN_SERVICE_DATE
	 ,IFF(PL.AUTHORIZATION_PERIOD_END_DATE >= D.LAST_DAY_OF_MONTH, D.LAST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_END_DATE) AS PERIOD_END_SERVICE_DATE
	 ,NULL AS PERIOD_ONHOLD_BEGIN_DATE
	 ,NULL AS PERIOD_ONHOLD_END_DATE
	 ,DATEDIFF(''DAY'',PERIOD_BEGIN_SERVICE_DATE,PERIOD_BEGIN_SERVICE_DATE)+1 AS ACTUALMONTHDAYS
	 ,NULL AS MONTHDAYSWOH
	 ,HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED
	 ,HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED
     ,INVALID_FLAG
	  ,IFF(PL.AUTHORIZATION_MAX_UNITS >24,TRUE,FALSE) AS FLAG
FROM 
DW_${var.SF_ENVIRONMENT}.integration.FACT_CLIENT_SERVICE_MERGED PL
 JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE D ON		
	PL.AUTHORIZATION_PERIOD_START_DATE <=D.CALENDAR_DATE AND PL.AUTHORIZATION_PERIOD_END_DATE >=D.CALENDAR_DATE	
	AND AUTH_INFO=D.DAY_OF_WEEK
	WHERE
 PL.ORIGINAL_SOURCE_SYSTEM_ID =13
	AND PL.AUTHORIZATION_UOM IN(''Weekly'' ,''By Request (Weekly)'')
)
-- FOR BIWEEKLY, Every 14 Days, Every 3 Weeks, Every 4 Weeks RECURRENCE CALCULATION
,  BIWEEKLY_TO_EVERY4WEEK_AUTHS AS (
	SELECT
	     PL.CLIENT_SERVICE_KEY,
		D.CALENDAR_DATE,
		D.FIRST_DAY_OF_MONTH,
		PL.CLIENT_KEY,
	    PL.PARTNER_CONTRACT_SERVICE_KEY,
	    PL.AUTHORIZATION_DISCIPLINE  ,
   	    PL.AUTHORIZATION_UOM,
		PL.AUTH_INFO,
		CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN AUTHORIZATION_MAX_UNITS_BY_UOM ELSE 0 END AS HOURS_AUTHORIZED,
  	    CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN IFF(PL.AUTHORIZATION_MAX_UNITS_BY_UOM>0,1,0) ELSE 0 END AS EFFECTIVE_DAYS,
  	    PL.AUTHORIZATION_PERIOD_START_DATE,
        PL.AUTHORIZATION_PERIOD_END_DATE,
	  HOURS_AUTHORIZED AS HOURS_AUTHORIZED_NON_ADJUSTED,
	  PL.SOURCE_SYSTEM_ID,
	 PL.ORIGINAL_SOURCE_SYSTEM_ID,
	 IFNULL(TRIM(REPLACE(TRIM(REPLACE(PL.AUTHORIZATION_TYPE,''Authorization'')),''UNKNOWN'')),''Hourly'') AS ATYPE,
	 IFF(PL.AUTHORIZATION_PERIOD_START_DATE <= D.FIRST_DAY_OF_MONTH, D.FIRST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_START_DATE) AS PERIOD_BEGIN_SERVICE_DATE,
	 IFF(PL.AUTHORIZATION_PERIOD_END_DATE >= D.LAST_DAY_OF_MONTH, D.LAST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_END_DATE) AS PERIOD_END_SERVICE_DATE,
	 NULL AS PERIOD_ONHOLD_BEGIN_DATE,
	 NULL AS PERIOD_ONHOLD_END_DATE,
	 DATEDIFF(''DAY'',PERIOD_BEGIN_SERVICE_DATE,PERIOD_BEGIN_SERVICE_DATE)+1 AS ACTUALMONTHDAYS,
	 NULL AS MONTHDAYSWOH,
	 HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED,
	 HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED
     ,INVALID_FLAG,
	 IFF(PL.AUTHORIZATION_MAX_UNITS >24,TRUE,FALSE) AS FLAG,
	ROW_NUMBER() OVER (PARTITION BY PL.CLIENT_SERVICE_KEY ORDER BY D.CALENDAR_DATE) AS PICKER
		FROM
		DW_${var.SF_ENVIRONMENT}.integration.FACT_CLIENT_SERVICE_MERGED PL
	JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE D ON
	PL.AUTHORIZATION_PERIOD_START_DATE <=D.CALENDAR_DATE AND PL.AUTHORIZATION_PERIOD_END_DATE >=D.CALENDAR_DATE	
	AND AUTH_INFO=D.DAY_OF_WEEK
	WHERE
	PL.ORIGINAL_SOURCE_SYSTEM_ID =13
	AND PL.AUTHORIZATION_UOM IN(''BiWeekly'',''Every 4 Weeks'',''Every 3 Weeks'') 
)
-- FOR MONTHLY RECURRENCE CALCULATION
, MONTHLY_AUTHS AS (
		SELECT
		 PL.CLIENT_SERVICE_KEY,
		D.CALENDAR_DATE,
		D.FIRST_DAY_OF_MONTH,
		 PL.CLIENT_KEY,
	   PL.PARTNER_CONTRACT_SERVICE_KEY,	
			 PL.AUTHORIZATION_DISCIPLINE,
			 PL.AUTHORIZATION_UOM,
			PL.AUTH_INFO,
	   CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN AUTHORIZATION_MAX_UNITS_BY_UOM ELSE 0 END AS HOURS_AUTHORIZED,
  	   CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN IFF(PL.AUTHORIZATION_MAX_UNITS_BY_UOM>0,1,0) ELSE 0 END AS EFFECTIVE_DAYS,
	  PL.AUTHORIZATION_PERIOD_START_DATE,
        PL.AUTHORIZATION_PERIOD_END_DATE,
  	   HOURS_AUTHORIZED AS HOURS_AUTHORIZED_NON_ADJUSTED,
	  PL.SOURCE_SYSTEM_ID,
	  PL.ORIGINAL_SOURCE_SYSTEM_ID,
	  IFNULL(TRIM(REPLACE(TRIM(REPLACE(PL.AUTHORIZATION_TYPE,''Authorization'')),''UNKNOWN'')),''Hourly'') AS ATYPE,
	 IFF(PL.AUTHORIZATION_PERIOD_START_DATE <= D.FIRST_DAY_OF_MONTH, D.FIRST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_START_DATE) AS PERIOD_BEGIN_SERVICE_DATE,
	 IFF(PL.AUTHORIZATION_PERIOD_END_DATE >= D.LAST_DAY_OF_MONTH, D.LAST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_END_DATE) AS PERIOD_END_SERVICE_DATE,
	 NULL AS PERIOD_ONHOLD_BEGIN_DATE,
	 NULL AS PERIOD_ONHOLD_END_DATE,
	 DATEDIFF(''DAY'',PERIOD_BEGIN_SERVICE_DATE,PERIOD_BEGIN_SERVICE_DATE)+1 AS ACTUALMONTHDAYS,
	 NULL AS MONTHDAYSWOH,
	 HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED,
	 HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED
     ,INVALID_FLAG,
	  IFF(PL.AUTHORIZATION_MAX_UNITS >24,TRUE,FALSE) AS FLAG,
	ROW_NUMBER() OVER (PARTITION BY PL.CLIENT_SERVICE_KEY, DATE_TRUNC(MONTH,D.CALENDAR_DATE) ORDER BY D.CALENDAR_DATE) AS PICKER
		FROM
			DW_${var.SF_ENVIRONMENT}.integration.FACT_CLIENT_SERVICE_MERGED PL
		JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE D ON
		D.CALENDAR_DATE BETWEEN PL.AUTHORIZATION_PERIOD_START_DATE AND PL.AUTHORIZATION_PERIOD_END_DATE
	AND AUTH_INFO=D.DAY_OF_WEEK
		WHERE
		PL.ORIGINAL_SOURCE_SYSTEM_ID =13
	AND PL.AUTHORIZATION_UOM IN(''Monthly'')
)
-- FOR BIMONTHLY RECURRENCE CALCULATION
, BIMONTHLY_AUTHS AS (
		SELECT
		PL.CLIENT_SERVICE_KEY,
		D.CALENDAR_DATE,
		D.FIRST_DAY_OF_MONTH,
		 PL.CLIENT_KEY,
	   PL.PARTNER_CONTRACT_SERVICE_KEY,		
			PL.AUTHORIZATION_DISCIPLINE,
			PL.AUTHORIZATION_UOM,
			PL.AUTH_INFO,
	 CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN AUTHORIZATION_MAX_UNITS_BY_UOM ELSE 0 END AS HOURS_AUTHORIZED,
  	   CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN IFF(PL.AUTHORIZATION_MAX_UNITS_BY_UOM>0,1,0) ELSE 0 END AS EFFECTIVE_DAYS,
	  PL.AUTHORIZATION_PERIOD_START_DATE,
        PL.AUTHORIZATION_PERIOD_END_DATE,
  	   HOURS_AUTHORIZED AS HOURS_AUTHORIZED_NON_ADJUSTED,
	   PL.SOURCE_SYSTEM_ID,
	  PL.ORIGINAL_SOURCE_SYSTEM_ID,
	  IFNULL(TRIM(REPLACE(TRIM(REPLACE(PL.AUTHORIZATION_TYPE,''Authorization'')),''UNKNOWN'')),''Hourly'') AS ATYPE,
	 IFF(PL.AUTHORIZATION_PERIOD_START_DATE <= D.FIRST_DAY_OF_MONTH, D.FIRST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_START_DATE) AS PERIOD_BEGIN_SERVICE_DATE,
	 IFF(PL.AUTHORIZATION_PERIOD_END_DATE >= D.LAST_DAY_OF_MONTH, D.LAST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_END_DATE) AS PERIOD_END_SERVICE_DATE,
	 NULL AS PERIOD_ONHOLD_BEGIN_DATE,
	 NULL AS PERIOD_ONHOLD_END_DATE,
	 DATEDIFF(''DAY'',PERIOD_BEGIN_SERVICE_DATE,PERIOD_BEGIN_SERVICE_DATE)+1 AS ACTUALMONTHDAYS,
	 NULL AS MONTHDAYSWOH,
	 HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED,
	 HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED,
     INVALID_FLAG,
	 IFF(PL.AUTHORIZATION_MAX_UNITS >24,TRUE,FALSE) AS FLAG,
	 ROW_NUMBER() OVER (PARTITION BY PL.CLIENT_SERVICE_KEY, DATE_TRUNC(MONTH,D.CALENDAR_DATE) ORDER BY D.CALENDAR_DATE) AS PICKER,
	 DENSE_RANK() OVER (PARTITION BY PL.CLIENT_SERVICE_KEY ORDER BY D.YEAR_MONTH) AS SKIPPER
		FROM
			DW_${var.SF_ENVIRONMENT}.integration.FACT_CLIENT_SERVICE_MERGED PL
		JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE D ON
		D.CALENDAR_DATE BETWEEN PL.AUTHORIZATION_PERIOD_START_DATE AND PL.AUTHORIZATION_PERIOD_END_DATE
	AND AUTH_INFO=D.DAY_OF_WEEK
		WHERE
		PL.ORIGINAL_SOURCE_SYSTEM_ID =13
	AND PL.AUTHORIZATION_UOM IN(''BiMonthly'')
)

-- FOR SEMI-ANNUAL and Every 6 MONTHS RECURRENCE CALCULATION (Based on assumption, there is no data to verify this!)
-- FOR ANNUAL RECURRENCE CALCULATION  (Based on assumption, there is no data to verify this!)

--FOR Every 5 WEEKS and Every 6 WEEKS RECURRENCE CALCULATION
, EVERY_FIVE_TO_SIX_WEEKS_AUTHS AS (
	SELECT
	    PL.CLIENT_SERVICE_KEY,
		D.CALENDAR_DATE,
		D.FIRST_DAY_OF_MONTH,
		 PL.CLIENT_KEY,
	   PL.PARTNER_CONTRACT_SERVICE_KEY,	
		PL.AUTHORIZATION_DISCIPLINE,
		PL.AUTHORIZATION_UOM,
		PL.auth_info,
	 CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN AUTHORIZATION_MAX_UNITS_BY_UOM ELSE 0 END AS HOURS_AUTHORIZED,
  	   CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN IFF(PL.AUTHORIZATION_MAX_UNITS_BY_UOM>0,1,0) ELSE 0 END AS EFFECTIVE_DAYS,
	PL.AUTHORIZATION_PERIOD_START_DATE,
        PL.AUTHORIZATION_PERIOD_END_DATE,
  	   HOURS_AUTHORIZED AS HOURS_AUTHORIZED_NON_ADJUSTED,
	 PL.SOURCE_SYSTEM_ID,
	  PL.ORIGINAL_SOURCE_SYSTEM_ID,
	  IFNULL(TRIM(REPLACE(TRIM(REPLACE(PL.AUTHORIZATION_TYPE,''Authorization'')),''UNKNOWN'')),''Hourly'') AS ATYPE,
	 IFF(PL.AUTHORIZATION_PERIOD_START_DATE <= D.FIRST_DAY_OF_MONTH, D.FIRST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_START_DATE) AS PERIOD_BEGIN_SERVICE_DATE,
	 IFF(PL.AUTHORIZATION_PERIOD_END_DATE >= D.LAST_DAY_OF_MONTH, D.LAST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_END_DATE) AS PERIOD_END_SERVICE_DATE,
	 NULL AS PERIOD_ONHOLD_BEGIN_DATE,
	 NULL AS PERIOD_ONHOLD_END_DATE,
	 DATEDIFF(''DAY'',PERIOD_BEGIN_SERVICE_DATE,PERIOD_BEGIN_SERVICE_DATE)+1 AS ACTUALMONTHDAYS,
	 NULL AS MONTHDAYSWOH,
	 HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED,
	 HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED,
     INVALID_FLAG,
	 IFF(PL.AUTHORIZATION_MAX_UNITS >24,TRUE,FALSE) AS FLAG,
	 ROW_NUMBER() OVER (PARTITION BY PL.CLIENT_SERVICE_KEY ORDER BY D.CALENDAR_DATE) AS PICKER
	FROM
		DW_${var.SF_ENVIRONMENT}.integration.FACT_CLIENT_SERVICE_MERGED PL
	JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE D ON
	D.CALENDAR_DATE BETWEEN PL.AUTHORIZATION_PERIOD_START_DATE AND PL.AUTHORIZATION_PERIOD_END_DATE
	AND AUTH_INFO=D.DAY_OF_WEEK
	WHERE
	PL.ORIGINAL_SOURCE_SYSTEM_ID =13
	AND PL.AUTHORIZATION_UOM IN(''Every 5 weeks'',''Every 6 weeks'')
)
--FOR PLANS RECURRING ONCE
, ONE_TIME_AUTHS AS (
	SELECT DISTINCT 
	PL.CLIENT_SERVICE_KEY,
		D.FIRST_DAY_OF_MONTH,
		D.CALENDAR_DATE,
		 PL.CLIENT_KEY,
	   PL.PARTNER_CONTRACT_SERVICE_KEY,
		PL.AUTHORIZATION_DISCIPLINE,
		PL.AUTHORIZATION_UOM,
		PL.auth_info,
		NULL AS PICKER,
		NULL AS SKIPPER,
		 CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN AUTHORIZATION_MAX_UNITS_BY_UOM ELSE 0 END AS HOURS_AUTHORIZED,
  	   CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN IFF(PL.AUTHORIZATION_MAX_UNITS_BY_UOM>0,1,0) ELSE 0 END AS EFFECTIVE_DAYS,
	  PL.AUTHORIZATION_PERIOD_START_DATE,
        PL.AUTHORIZATION_PERIOD_END_DATE,
  	   HOURS_AUTHORIZED AS HOURS_AUTHORIZED_NON_ADJUSTED,
	  PL.SOURCE_SYSTEM_ID,
	  PL.ORIGINAL_SOURCE_SYSTEM_ID,
	  IFNULL(TRIM(REPLACE(TRIM(REPLACE(PL.AUTHORIZATION_TYPE,''Authorization'')),''UNKNOWN'')),''Hourly'') AS ATYPE,
	 IFF(PL.AUTHORIZATION_PERIOD_START_DATE <= D.FIRST_DAY_OF_MONTH, D.FIRST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_START_DATE) AS PERIOD_BEGIN_SERVICE_DATE,
	 IFF(PL.AUTHORIZATION_PERIOD_END_DATE >= D.LAST_DAY_OF_MONTH, D.LAST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_END_DATE) AS PERIOD_END_SERVICE_DATE,
	 NULL AS PERIOD_ONHOLD_BEGIN_DATE,
	 NULL AS PERIOD_ONHOLD_END_DATE,
	 DATEDIFF(''DAY'',PERIOD_BEGIN_SERVICE_DATE,PERIOD_BEGIN_SERVICE_DATE)+1 AS ACTUALMONTHDAYS,
	 NULL AS MONTHDAYSWOH,
	 HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED,
	 HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED,
     INVALID_FLAG,
	  IFF(PL.AUTHORIZATION_MAX_UNITS >24,TRUE,FALSE) AS FLAG
	FROM
		DW_${var.SF_ENVIRONMENT}.integration.FACT_CLIENT_SERVICE_MERGED PL
	INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE D
    ON 
    D.CALENDAR_DATE BETWEEN PL.AUTHORIZATION_PERIOD_START_DATE AND PL.AUTHORIZATION_PERIOD_END_DATE
	AND AUTH_INFO=D.DAY_OF_WEEK
		WHERE
		PL.ORIGINAL_SOURCE_SYSTEM_ID =13
	AND PL.AUTHORIZATION_UOM IN(''One Time'')
)
-- FOR Every 90 Days RECURRENCE CALCULATION
, EVERY_NINETY_DAYS_AUTHS AS (
		SELECT
		PL.CLIENT_SERVICE_KEY,
		D.CALENDAR_DATE,
		D.FIRST_DAY_OF_MONTH,
		PL.CLIENT_KEY,
	    PL.PARTNER_CONTRACT_SERVICE_KEY,		
		PL.AUTHORIZATION_DISCIPLINE,
		PL.AUTHORIZATION_UOM,
		PL.AUTH_INFO,
		CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN AUTHORIZATION_MAX_UNITS_BY_UOM ELSE 0 END AS HOURS_AUTHORIZED,
  	  CASE WHEN DAYOFWEEK(D.CALENDAR_DATE) = AUTH_INFO THEN IFF(PL.AUTHORIZATION_MAX_UNITS_BY_UOM>0,1,0) ELSE 0 END AS EFFECTIVE_DAYS,
	  PL.AUTHORIZATION_PERIOD_START_DATE,
        PL.AUTHORIZATION_PERIOD_END_DATE,
  	  HOURS_AUTHORIZED AS HOURS_AUTHORIZED_NON_ADJUSTED,
	  PL.SOURCE_SYSTEM_ID,
	  PL.ORIGINAL_SOURCE_SYSTEM_ID,
	  IFNULL(TRIM(REPLACE(TRIM(REPLACE(PL.AUTHORIZATION_TYPE,''Authorization'')),''UNKNOWN'')),''Hourly'') AS ATYPE,
	 IFF(PL.AUTHORIZATION_PERIOD_START_DATE <= D.FIRST_DAY_OF_MONTH, D.FIRST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_START_DATE) AS PERIOD_BEGIN_SERVICE_DATE,
	 IFF(PL.AUTHORIZATION_PERIOD_END_DATE >= D.LAST_DAY_OF_MONTH, D.LAST_DAY_OF_MONTH, PL.AUTHORIZATION_PERIOD_END_DATE) AS PERIOD_END_SERVICE_DATE,
	 NULL AS PERIOD_ONHOLD_BEGIN_DATE,
	 NULL AS PERIOD_ONHOLD_END_DATE,
	 DATEDIFF(''DAY'',PERIOD_BEGIN_SERVICE_DATE,PERIOD_BEGIN_SERVICE_DATE)+1 AS ACTUALMONTHDAYS,
	 NULL AS MONTHDAYSWOH,
	 HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED,
	 HOURS_AUTHORIZED AS PERIOD_HOURS_AUTHORIZED,
     INVALID_FLAG,
	 IFF(PL.AUTHORIZATION_MAX_UNITS >24,TRUE,FALSE) AS FLAG,
	 ROW_NUMBER() OVER (PARTITION BY PL.CLIENT_SERVICE_KEY ORDER BY D.CALENDAR_DATE) AS PICKER
		FROM
			DW_${var.SF_ENVIRONMENT}.integration.FACT_CLIENT_SERVICE_MERGED PL
		JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE D ON
		 D.CALENDAR_DATE BETWEEN PL.AUTHORIZATION_PERIOD_START_DATE AND PL.AUTHORIZATION_PERIOD_END_DATE
	AND AUTH_INFO=D.DAY_OF_WEEK
		WHERE
		PL.ORIGINAL_SOURCE_SYSTEM_ID =13
	AND PL.AUTHORIZATION_UOM IN(''Every 90 Days'')
)
,TOTAL_AUTHS AS (
	SELECT * FROM (
	SELECT FIRST_DAY_OF_MONTH, SOURCE_SYSTEM_ID, ORIGINAL_SOURCE_SYSTEM_ID, AUTHORIZATION_PERIOD_START_DATE AS AUTH_START_DATE, 
	AUTHORIZATION_PERIOD_END_DATE AS AUTH_END_DATE, CLIENT_SERVICE_KEY, ATYPE, 
CLIENT_KEY, PARTNER_CONTRACT_SERVICE_KEY, HOURS_AUTHORIZED AS AUTHORIZATION_MAX_UNITS, HOURS_AUTHORIZED AS  AUTHORIZATION_MAX_UNITS_ADJUSTED, 
EFFECTIVE_DAYS AS AUTHDAYS, PERIOD_BEGIN_SERVICE_DATE, PERIOD_END_SERVICE_DATE, PERIOD_ONHOLD_BEGIN_DATE, PERIOD_ONHOLD_END_DATE, ACTUALMONTHDAYS, 
MONTHDAYSWOH, PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED, PERIOD_HOURS_AUTHORIZED,INVALID_FLAG
		FROM WEEKLY_AUTHS -- 0, 1 AND 7
		UNION ALL
		SELECT FIRST_DAY_OF_MONTH, SOURCE_SYSTEM_ID, ORIGINAL_SOURCE_SYSTEM_ID, AUTHORIZATION_PERIOD_START_DATE AS AUTH_START_DATE, 
	AUTHORIZATION_PERIOD_END_DATE AS AUTH_END_DATE, CLIENT_SERVICE_KEY, ATYPE, 
CLIENT_KEY, PARTNER_CONTRACT_SERVICE_KEY, HOURS_AUTHORIZED AS AUTHORIZATION_MAX_UNITS, HOURS_AUTHORIZED AS  AUTHORIZATION_MAX_UNITS_ADJUSTED, 
EFFECTIVE_DAYS AS AUTHDAYS, PERIOD_BEGIN_SERVICE_DATE, PERIOD_END_SERVICE_DATE, PERIOD_ONHOLD_BEGIN_DATE, PERIOD_ONHOLD_END_DATE, ACTUALMONTHDAYS, 
MONTHDAYSWOH, PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED, PERIOD_HOURS_AUTHORIZED,INVALID_FLAG
		FROM BIWEEKLY_TO_EVERY4WEEK_AUTHS WHERE AUTHORIZATION_UOM  IN (''BiWeekly'') AND PICKER % 2 = 1 --2 ,13
		UNION ALL 
		SELECT FIRST_DAY_OF_MONTH, SOURCE_SYSTEM_ID, ORIGINAL_SOURCE_SYSTEM_ID, AUTHORIZATION_PERIOD_START_DATE AS AUTH_START_DATE, 
	AUTHORIZATION_PERIOD_END_DATE AS AUTH_END_DATE, CLIENT_SERVICE_KEY, ATYPE, 
CLIENT_KEY, PARTNER_CONTRACT_SERVICE_KEY, HOURS_AUTHORIZED AS AUTHORIZATION_MAX_UNITS, HOURS_AUTHORIZED AS  AUTHORIZATION_MAX_UNITS_ADJUSTED, 
EFFECTIVE_DAYS AS AUTHDAYS, PERIOD_BEGIN_SERVICE_DATE, PERIOD_END_SERVICE_DATE, PERIOD_ONHOLD_BEGIN_DATE, PERIOD_ONHOLD_END_DATE, ACTUALMONTHDAYS, 
MONTHDAYSWOH, PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED, PERIOD_HOURS_AUTHORIZED,INVALID_FLAG
		FROM BIWEEKLY_TO_EVERY4WEEK_AUTHS WHERE AUTHORIZATION_UOM  IN (''Every 3 weeks'') AND PICKER % 3 = 1 --6
		UNION ALL
		SELECT FIRST_DAY_OF_MONTH, SOURCE_SYSTEM_ID, ORIGINAL_SOURCE_SYSTEM_ID, AUTHORIZATION_PERIOD_START_DATE AS AUTH_START_DATE, 
	AUTHORIZATION_PERIOD_END_DATE AS AUTH_END_DATE, CLIENT_SERVICE_KEY, ATYPE, 
CLIENT_KEY, PARTNER_CONTRACT_SERVICE_KEY, HOURS_AUTHORIZED AS AUTHORIZATION_MAX_UNITS, HOURS_AUTHORIZED AS  AUTHORIZATION_MAX_UNITS_ADJUSTED, 
EFFECTIVE_DAYS AS AUTHDAYS, PERIOD_BEGIN_SERVICE_DATE, PERIOD_END_SERVICE_DATE, PERIOD_ONHOLD_BEGIN_DATE, PERIOD_ONHOLD_END_DATE, ACTUALMONTHDAYS, 
MONTHDAYSWOH, PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED, PERIOD_HOURS_AUTHORIZED,INVALID_FLAG
		FROM BIWEEKLY_TO_EVERY4WEEK_AUTHS WHERE AUTHORIZATION_UOM  IN (''Every 4 weeks'') AND PICKER % 4 = 1 --9
		UNION ALL
	SELECT FIRST_DAY_OF_MONTH, SOURCE_SYSTEM_ID, ORIGINAL_SOURCE_SYSTEM_ID, AUTHORIZATION_PERIOD_START_DATE AS AUTH_START_DATE, 
	AUTHORIZATION_PERIOD_END_DATE AS AUTH_END_DATE, CLIENT_SERVICE_KEY, ATYPE, 
CLIENT_KEY, PARTNER_CONTRACT_SERVICE_KEY, HOURS_AUTHORIZED AS AUTHORIZATION_MAX_UNITS, HOURS_AUTHORIZED AS  AUTHORIZATION_MAX_UNITS_ADJUSTED, 
EFFECTIVE_DAYS AS AUTHDAYS, PERIOD_BEGIN_SERVICE_DATE, PERIOD_END_SERVICE_DATE, PERIOD_ONHOLD_BEGIN_DATE, PERIOD_ONHOLD_END_DATE, ACTUALMONTHDAYS, 
MONTHDAYSWOH, PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED, PERIOD_HOURS_AUTHORIZED,INVALID_FLAG
		FROM MONTHLY_AUTHS WHERE AUTHORIZATION_UOM IN(''Monthly'') AND PICKER = 1
		UNION ALL
		SELECT FIRST_DAY_OF_MONTH, SOURCE_SYSTEM_ID, ORIGINAL_SOURCE_SYSTEM_ID, AUTHORIZATION_PERIOD_START_DATE AS AUTH_START_DATE, 
	AUTHORIZATION_PERIOD_END_DATE AS AUTH_END_DATE, CLIENT_SERVICE_KEY, ATYPE, 
CLIENT_KEY, PARTNER_CONTRACT_SERVICE_KEY, HOURS_AUTHORIZED AS AUTHORIZATION_MAX_UNITS, HOURS_AUTHORIZED AS  AUTHORIZATION_MAX_UNITS_ADJUSTED, 
EFFECTIVE_DAYS AS AUTHDAYS, PERIOD_BEGIN_SERVICE_DATE, PERIOD_END_SERVICE_DATE, PERIOD_ONHOLD_BEGIN_DATE, PERIOD_ONHOLD_END_DATE, ACTUALMONTHDAYS, 
MONTHDAYSWOH, PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED, PERIOD_HOURS_AUTHORIZED,INVALID_FLAG
		FROM BIMONTHLY_AUTHS WHERE AUTHORIZATION_UOM IN(''BiMonthly'') AND PICKER = 1 AND SKIPPER % 2 = 1
		UNION ALL
	SELECT FIRST_DAY_OF_MONTH, SOURCE_SYSTEM_ID, ORIGINAL_SOURCE_SYSTEM_ID, AUTHORIZATION_PERIOD_START_DATE AS AUTH_START_DATE, 
	AUTHORIZATION_PERIOD_END_DATE AS AUTH_END_DATE, CLIENT_SERVICE_KEY, ATYPE, 
CLIENT_KEY, PARTNER_CONTRACT_SERVICE_KEY, HOURS_AUTHORIZED AS AUTHORIZATION_MAX_UNITS, HOURS_AUTHORIZED AS  AUTHORIZATION_MAX_UNITS_ADJUSTED, 
EFFECTIVE_DAYS AS AUTHDAYS, PERIOD_BEGIN_SERVICE_DATE, PERIOD_END_SERVICE_DATE, PERIOD_ONHOLD_BEGIN_DATE, PERIOD_ONHOLD_END_DATE, ACTUALMONTHDAYS, 
MONTHDAYSWOH, PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED, PERIOD_HOURS_AUTHORIZED,INVALID_FLAG
		FROM EVERY_FIVE_TO_SIX_WEEKS_AUTHS WHERE AUTHORIZATION_UOM  IN (''Every 5 weeks'') AND PICKER % 5 = 1
		UNION ALL
		SELECT FIRST_DAY_OF_MONTH, SOURCE_SYSTEM_ID, ORIGINAL_SOURCE_SYSTEM_ID, AUTHORIZATION_PERIOD_START_DATE AS AUTH_START_DATE, 
	AUTHORIZATION_PERIOD_END_DATE AS AUTH_END_DATE, CLIENT_SERVICE_KEY, ATYPE, 
CLIENT_KEY, PARTNER_CONTRACT_SERVICE_KEY, HOURS_AUTHORIZED AS AUTHORIZATION_MAX_UNITS, HOURS_AUTHORIZED AS  AUTHORIZATION_MAX_UNITS_ADJUSTED, 
EFFECTIVE_DAYS AS AUTHDAYS, PERIOD_BEGIN_SERVICE_DATE, PERIOD_END_SERVICE_DATE, PERIOD_ONHOLD_BEGIN_DATE, PERIOD_ONHOLD_END_DATE, ACTUALMONTHDAYS, 
MONTHDAYSWOH, PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED, PERIOD_HOURS_AUTHORIZED,INVALID_FLAG
		FROM EVERY_FIVE_TO_SIX_WEEKS_AUTHS WHERE AUTHORIZATION_UOM  IN (''Every 6 weeks'') AND PICKER % 6 = 1
		UNION ALL
		SELECT FIRST_DAY_OF_MONTH, SOURCE_SYSTEM_ID, ORIGINAL_SOURCE_SYSTEM_ID, AUTHORIZATION_PERIOD_START_DATE AS AUTH_START_DATE, 
	AUTHORIZATION_PERIOD_END_DATE AS AUTH_END_DATE, CLIENT_SERVICE_KEY, ATYPE, 
CLIENT_KEY, PARTNER_CONTRACT_SERVICE_KEY, HOURS_AUTHORIZED AS AUTHORIZATION_MAX_UNITS, HOURS_AUTHORIZED AS  AUTHORIZATION_MAX_UNITS_ADJUSTED, 
EFFECTIVE_DAYS AS AUTHDAYS, PERIOD_BEGIN_SERVICE_DATE, PERIOD_END_SERVICE_DATE, PERIOD_ONHOLD_BEGIN_DATE, PERIOD_ONHOLD_END_DATE, ACTUALMONTHDAYS, 
MONTHDAYSWOH, PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED, PERIOD_HOURS_AUTHORIZED,INVALID_FLAG
		FROM ONE_TIME_AUTHS --12
		UNION ALL
		SELECT  FIRST_DAY_OF_MONTH, SOURCE_SYSTEM_ID, ORIGINAL_SOURCE_SYSTEM_ID, AUTHORIZATION_PERIOD_START_DATE AS AUTH_START_DATE, 
	AUTHORIZATION_PERIOD_END_DATE AS AUTH_END_DATE, CLIENT_SERVICE_KEY, ATYPE, 
CLIENT_KEY, PARTNER_CONTRACT_SERVICE_KEY, HOURS_AUTHORIZED AS AUTHORIZATION_MAX_UNITS, HOURS_AUTHORIZED AS  AUTHORIZATION_MAX_UNITS_ADJUSTED, 
EFFECTIVE_DAYS AS AUTHDAYS, PERIOD_BEGIN_SERVICE_DATE, PERIOD_END_SERVICE_DATE, PERIOD_ONHOLD_BEGIN_DATE, PERIOD_ONHOLD_END_DATE, ACTUALMONTHDAYS, 
MONTHDAYSWOH, PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED, PERIOD_HOURS_AUTHORIZED,INVALID_FLAG
		FROM EVERY_NINETY_DAYS_AUTHS WHERE AUTHORIZATION_UOM  IN(''Every 90 days'') AND PICKER % 90 = 1
	) WHERE FIRST_DAY_OF_MONTH >= ''2011-01-01'' -- ASR in Prime was started IN 2011-01-01
)
	SELECT DISTINCT FIRST_DAY_OF_MONTH, SOURCE_SYSTEM_ID, ORIGINAL_SOURCE_SYSTEM_ID,AUTH_START_DATE,AUTH_END_DATE,CLIENT_SERVICE_KEY, ATYPE, 
	CLIENT_KEY, PARTNER_CONTRACT_SERVICE_KEY,SUM(AUTHORIZATION_MAX_UNITS) AS AUTHORIZATION_MAX_UNITS, SUM(AUTHORIZATION_MAX_UNITS_ADJUSTED) AS AUTHORIZATION_MAX_UNITS_ADJUSTED,
	SUM(AUTHDAYS) AS AUTHDAYS,PERIOD_BEGIN_SERVICE_DATE, PERIOD_END_SERVICE_DATE, PERIOD_ONHOLD_BEGIN_DATE, PERIOD_ONHOLD_END_DATE, ACTUALMONTHDAYS,
	MONTHDAYSWOH, SUM(PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED) as PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED, 
	SUM(PERIOD_HOURS_AUTHORIZED) as PERIOD_HOURS_AUTHORIZED,INVALID_FLAG
    FROM TOTAL_AUTHS AO
    GROUP BY FIRST_DAY_OF_MONTH,  SOURCE_SYSTEM_ID, ORIGINAL_SOURCE_SYSTEM_ID,AUTH_START_DATE,AUTH_END_DATE,CLIENT_SERVICE_KEY, ATYPE, 
	CLIENT_KEY, PARTNER_CONTRACT_SERVICE_KEY,PERIOD_BEGIN_SERVICE_DATE, PERIOD_END_SERVICE_DATE, PERIOD_ONHOLD_BEGIN_DATE, PERIOD_ONHOLD_END_DATE, ACTUALMONTHDAYS,
	MONTHDAYSWOH,INVALID_FLAG
)
,OTHER_SYSTEMS AS (
	SELECT DISTINCT D.FIRST_DAY_OF_MONTH,SOURCE_SYSTEM_ID ,ORIGINAL_SOURCE_SYSTEM_ID,AUTHORIZATION_PERIOD_START_DATE AS AUTH_START_DATE ,
	AUTHORIZATION_PERIOD_END_DATE AS AUTH_END_DATE, CLIENT_SERVICE_KEY ,
	IFNULL(TRIM(REPLACE(TRIM(REPLACE(AUTHORIZATION_TYPE,''Authorization'')),''UNKNOWN'')),''Hourly'') AS ATYPE,
	CLIENT_KEY ,PARTNER_CONTRACT_SERVICE_KEY ,AUTH.AUTHORIZATION_MAX_UNITS ,AUTH.AUTHORIZATION_MAX_UNITS_ADJUSTED,
	COALESCE(NULLIFZERO(EFFECTIVE_DAYS),DATEDIFF(''DAY'',AUTHORIZATION_PERIOD_START_DATE,AUTHORIZATION_PERIOD_END_DATE)+1) AS AUTHDAYS
	,IFF(AUTHORIZATION_PERIOD_START_DATE <= D.FIRST_DAY_OF_MONTH, D.FIRST_DAY_OF_MONTH, AUTHORIZATION_PERIOD_START_DATE) AS PERIOD_BEGIN_SERVICE_DATE
	,IFF(AUTHORIZATION_PERIOD_END_DATE >= D.LAST_DAY_OF_MONTH, D.LAST_DAY_OF_MONTH, AUTHORIZATION_PERIOD_END_DATE) AS PERIOD_END_SERVICE_DATE
	,NULL AS PERIOD_ONHOLD_BEGIN_DATE, NULL AS PERIOD_ONHOLD_END_DATE
	,CASE WHEN CONCAT(AUTH.AUTHORIZATION_UOM,'' '',AUTH.ORIGINAL_SOURCE_SYSTEM_ID)=''Day 17''
		THEN AUTHDAYS/(DATEDIFF(''MONTH'',AUTHORIZATION_PERIOD_START_DATE,AUTHORIZATION_PERIOD_END_DATE)+1)
	WHEN D.FIRST_DAY_OF_MONTH<=AUTHORIZATION_PERIOD_START_DATE AND D.LAST_DAY_OF_MONTH<=AUTHORIZATION_PERIOD_END_DATE
		THEN (DATEDIFF(''DAY'',AUTHORIZATION_PERIOD_START_DATE,LAST_DAY_OF_MONTH)+1)
	WHEN D.FIRST_DAY_OF_MONTH<=AUTHORIZATION_PERIOD_START_DATE AND D.LAST_DAY_OF_MONTH>=AUTHORIZATION_PERIOD_END_DATE
		THEN (DATEDIFF(''DAY'',AUTHORIZATION_PERIOD_START_DATE,AUTHORIZATION_PERIOD_END_DATE)+1)
	WHEN D.FIRST_DAY_OF_MONTH>=AUTHORIZATION_PERIOD_START_DATE AND D.LAST_DAY_OF_MONTH<=AUTHORIZATION_PERIOD_END_DATE
		THEN (DATEDIFF(''DAY'',FIRST_DAY_OF_MONTH,LAST_DAY_OF_MONTH)+1)
	WHEN D.FIRST_DAY_OF_MONTH>=AUTHORIZATION_PERIOD_START_DATE AND D.LAST_DAY_OF_MONTH>=AUTHORIZATION_PERIOD_END_DATE
		THEN (DATEDIFF(''DAY'',FIRST_DAY_OF_MONTH,AUTHORIZATION_PERIOD_END_DATE)+1) END AS ACTUALMONTHDAYS
	,ACTUALMONTHDAYS AS MONTHDAYSWOH
	,ACTUALMONTHDAYS* ((AUTHORIZATION_MAX_UNITS) /AUTHDAYS) AS PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED
	,MONTHDAYSWOH* ((AUTHORIZATION_MAX_UNITS_ADJUSTED) /AUTHDAYS) AS PERIOD_HOURS_AUTHORIZED
    ,INVALID_FLAG
	FROM DW_${var.SF_ENVIRONMENT}.INTEGRATION.FACT_CLIENT_SERVICE_MERGED  AUTH
	JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE D ON AUTH.AUTHORIZATION_PERIOD_START_DATE <=D.CALENDAR_DATE AND AUTH.AUTHORIZATION_PERIOD_END_DATE >=D.CALENDAR_DATE
	WHERE AUTH.CANCELLED_FLAG=FALSE AND AUTH.ORIGINAL_SOURCE_SYSTEM_ID NOT IN(13)
)
, all_data AS (
SELECT * FROM ASR_MONTHLY
UNION ALL 
SELECT * FROM OTHER_SYSTEMS)
SELECT DISTINCT *,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	    CURRENT_USER as ETL_INSERTED_BY ,
	    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	    CURRENT_USER as ETL_LAST_UPDATED_BY,
	    0 as ETL_DELETED_FLAG
FROM all_data;


SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

