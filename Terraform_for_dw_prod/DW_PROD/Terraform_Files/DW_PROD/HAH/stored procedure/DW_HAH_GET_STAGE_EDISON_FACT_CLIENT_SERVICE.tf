resource "snowflake_procedure" "DW_HAH_GET_STAGE_EDISON_FACT_CLIENT_SERVICE" {
	name ="GET_STAGE_EDISON_FACT_CLIENT_SERVICE"
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
-- NAME:  EDISON FACT CLIENT SERVICE
--
-- PURPOSE: Populates Stage EDISON FACT CLIENT SERVICE
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 03/03/23    SANKET JAIN			 Initial version
-- 28/03/23    Sagar Gulghane        Changed Service_key Logic
--*****************************************************************************************************************************

INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.EDISON_FACT_CLIENT_SERVICE

WITH CLIENT AS
(
	(
		SELECT MD5((AGENCYID||''-''||MASTER_ID||''-''||''EDISON'' )) as CLIENT_KEY,
		PATIENTID , MASTER_ID, TO_NUMBER(AGENCYID) AS AGENCYID, LASTNAME, FIRSTNAME, OFFICEID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CLIENT_MASTER_LIST
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT MD5((AGENCYID||''-''||MASTER_ID||''-''||''EDISON'' )) as CLIENT_KEY,
		PATIENTID , MASTER_ID, TO_NUMBER(AGENCYID) AS AGENCYID, LASTNAME, FIRSTNAME, OFFICEID
		FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CLIENT_MATCH_LIST
		WHERE PATIENTID NOT IN (SELECT PATIENTID FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CLIENT_MASTER_LIST)
	)
),
Period_wise_calculation AS (
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
		, DECODE(DAYNAME(DD.CALENDAR_DATE)
   				 , ''Sat'', IFF(PA.SATHOURS>0,1,0)
   		   		 , ''Sun'', IFF(PA.SUNHOURS>0,1,0)
   		   		 , ''Mon'', IFF(PA.MONHOURS>0,1,0)
   		   		 , ''Tue'', IFF(PA.TUEHOURS>0,1,0)
   		   		 , ''Wed'', IFF(PA.WEDHOURS>0,1,0)
   		   		 , ''Thu'', IFF(PA.THUHOURS>0,1,0)
   		   		 , ''Fri'', IFF(PA.FRIHOURS>0,1,0)
   		   	 , 0) AS DAYS
		, CASE WHEN SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND AUTH_HOURS_PER_DAY > 13 THEN 13
			    ELSE AUTH_HOURS_PER_DAY  END AS HOURS_AUTHORIZED
		, IFF(SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND AUTH_HOURS_PER_DAY > 13
				, 13, AUTH_HOURS_PER_DAY) AS HOURS_AUTHORIZED_NON_ADJUSTED
   	    , FALSE AS FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PATIENTAUTHORIZATION  PA
INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE DD
	ON DD.CALENDAR_DATE BETWEEN PA.FROMDATE AND PA.TODATE
INNER JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.SERVICECODES SC
	ON SC.SERVICECODEID = PA.SERVICECODEID
WHERE PERIOD = ''Day''
UNION ALL
SELECT PA.AUTHORIZATIONID
		, PA.PATIENTID
		, PA.SERVICECODEID
		, DD.CALENDAR_DATE
		, PA.MAXUNITSFORPERIOD/7.00 AS AUTH_HOURS_PER_DAY
		, 1 AS DAYS
		, CASE WHEN SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND AUTH_HOURS_PER_DAY > 13 THEN 13
			    ELSE AUTH_HOURS_PER_DAY  END AS HOURS_AUTHORIZED
		, IFF(SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND AUTH_HOURS_PER_DAY > 13
				, 13, AUTH_HOURS_PER_DAY) AS HOURS_AUTHORIZED_NON_ADJUSTED
   	    , IFF(AUTH_HOURS_PER_DAY >24,TRUE,FALSE) AS FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PATIENTAUTHORIZATION PA
INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE DD
	ON DD.CALENDAR_DATE::DATE BETWEEN PA.FROMDATE::DATE AND PA.TODATE::DATE
INNER JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.SERVICECODES SC
	ON SC.SERVICECODEID = PA.SERVICECODEID
WHERE PA.PERIOD = ''Week''
UNION ALL
SELECT PA.AUTHORIZATIONID
		, PA.PATIENTID
		, PA.SERVICECODEID
		, DD.CALENDAR_DATE
		, PA.MAXUNITSFORPERIOD/(DAY(LAST_DAY(DD.CALENDAR_DATE))*1.00) AS AUTH_HOURS_PER_DAY
		, 1 AS DAYS
		, CASE WHEN SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND AUTH_HOURS_PER_DAY > 13 THEN 13
			    ELSE AUTH_HOURS_PER_DAY  END AS HOURS_AUTHORIZED
		, IFF(SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND AUTH_HOURS_PER_DAY > 13
				, 13, AUTH_HOURS_PER_DAY) AS HOURS_AUTHORIZED_NON_ADJUSTED
   	    , IFF(AUTH_HOURS_PER_DAY >24,TRUE,FALSE) AS FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PATIENTAUTHORIZATION PA
INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE DD
	ON DD.CALENDAR_DATE::DATE BETWEEN PA.FROMDATE::DATE AND PA.TODATE::DATE
INNER JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.SERVICECODES SC
	ON SC.SERVICECODEID = PA.SERVICECODEID
WHERE PA.PERIOD = ''Monthly''
UNION ALL
SELECT PA.AUTHORIZATIONID
		, PA.PATIENTID
		, PA.SERVICECODEID
		, DD.CALENDAR_DATE
		, CASE WHEN SC.SERVICECODE ILIKE ''%T1019%'' AND SC.CONTRACTID = 18121 AND FROMDATE != TODATE 
					THEN (PA.MAXUNITSFORPERIOD/IFF(FROMDATE != TODATE, DATEDIFF(DAY, FROMDATE, TODATE)+1, 1) * 1.00)/4.00
		   	   WHEN FROMDATE = TODATE 
		   			THEN PA.MAXUNITSFORPERIOD
		   	   ELSE PA.MAXUNITSFORPERIOD/IFF(FROMDATE != TODATE, DATEDIFF(DAY, FROMDATE, TODATE)+1, 1) * 1.00
		  END AUTH_HOURS_PER_DAY
		, 1 AS DAYS
		, CASE WHEN SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND AUTH_HOURS_PER_DAY > 13 THEN 13
			    ELSE AUTH_HOURS_PER_DAY  END AS HOURS_AUTHORIZED
		, IFF(SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND AUTH_HOURS_PER_DAY > 13
				, 13, AUTH_HOURS_PER_DAY) AS HOURS_AUTHORIZED_NON_ADJUSTED
   	    , IFF(AUTH_HOURS_PER_DAY >24,TRUE,FALSE) AS FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PATIENTAUTHORIZATION PA
INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE DD
	ON DD.CALENDAR_DATE::DATE BETWEEN PA.FROMDATE::DATE AND PA.TODATE::DATE
INNER JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.SERVICECODES SC
	ON SC.SERVICECODEID = PA.SERVICECODEID
WHERE PERIOD = ''Entire Period'')
,Max_Auth AS
(
    SELECT AO.PATIENTID
   		 , AO.SERVICECODEID
   		 , AO.AUTHORIZATIONID
   		 , AO.FLAG
   		 , SUM(DAYS) AS DAYS
   		 , SUM(HOURS_AUTHORIZED) AS HOURS_AUTHORIZED
   		 , SUM(HOURS_AUTHORIZED_NON_ADJUSTED) AS HOURS_AUTHORIZED_NON_ADJUSTED
    FROM Period_wise_calculation AO
    INNER JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PATIENTAUTHORIZATION PA
   	 ON PA.AUTHORIZATIONID = AO.AUTHORIZATIONID
    GROUP BY AO.PATIENTID, AO.SERVICECODEID,AO.AUTHORIZATIONID,AO.FLAG
)--SELECT SUM(HOURS_AUTHORIZED)FROM Max_Auth;
SELECT 
	DISTINCT MD5(''EDISON''
			 || ''-'' || PA.AUTHORIZATIONID 
			 || ''-'' || IFNULL(RS.REVENUE_SUBCATEGORY_CODE, ''1'')
			 || ''-'' || ''EDISON'') AS CLIENT_SERVICE_KEY
	,17 AS SOURCE_SYSTEM_ID
	,''EDISON'' AS SYSTEM_CODE
	,MD5(''EDISON''
	 || ''-'' || IFNULL(SC.AGENCYID, -1) 
	 || ''-'' || IFNULL(PR.PAYERID, -1) 
	 || ''-'' || IFNULL(SC.CONTRACTID, -1) 
	 || ''-'' || IFNULL(SC.SERVICECODEID, -1) 
	 || ''-'' || IFNULL(RS.REVENUE_SUBCATEGORY_CODE, ''1'')
	 || ''-'' || IFNULL(SC.VISITTYPE, ''-1'') 
	 || ''-'' || IFNULL(SC.RATETYPETEXT, ''-1'')
	 || ''-'' || ''EDISON'') AS PARTNER_CONTRACT_SERVICE_KEY
	,MD5(''EDISON'' 
	 || ''-'' || CLIENT.PATIENTID 
	 || ''-'' || P.ADMISSIONID 
     || ''-'' ||NVL(RS.REVENUE_SUBCATEGORY_CODE,''UNKNOWN'')
	 || ''-'' || NVL(SC.SERVICECODEID,-1) 
	 || ''-'' || ''EDISON'') AS CLIENT_ADMISSION_KEY
	,DC.CLIENT_KEY AS CLIENT_KEY
 --	,MD5(''EDISON'' || ''-'' || SC.SERVICECODEID || ''-'' || ''EDISON'') AS SERVICE_KEY
    ,MD5(''EDISON'' || ''-'' || SC.SERVICECODEID ||  ''-'' ||NVL(RS.REVENUE_SUBCATEGORY_CODE,''UNKNOWN'')|| ''-'' || ''EDISON'') AS SERVICE_KEY
	,SC.SERVICECODE AS BILL_CODE 
	,SC.RATETYPETEXT AS BILL_TYPE
	,CASE WHEN CR.UNITS = 1 THEN ''Hourly''
          WHEN CR.UNITS = 2 THEN ''Half Hours''
          WHEN CR.UNITS = 4 THEN ''Quarter Hours''
     ELSE NULL END AS  BILL_UOM
    ,SC.RATETYPETEXT AS SCHEDULE_TYPE
    ,SC.RATETYPETEXT AS SCHEDULE_UOM
    ,PA.DISCIPLINE AS AUTHORIZAITON_DISCIPLINE
    ,PA.FROMDATE AS AUTHORIZATION_DATE
    ,PA.FROMDATE AS AUTHORIZATION_PERIOD_START_DATE
    ,IFF(PA.TODATE > (SELECT MAX(CALENDAR_DATE) FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE ),(SELECT MAX(CALENDAR_DATE) FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_DATE),PA.TODATE)AS AUTHORIZATION_PERIOD_END_DATE
    ,CA.DAYS AS EFFECTIVE_DAYS
	,CONCAT(TRIM(PA.TYPE),'' '',''Authorization'')AS AUTHORIZATION_TYPE
  --,PA.PERIOD AS AUTHORIZATION_UOM
    ,CASE 
     	WHEN PA.PERIOD=''Monthly'' THEN ''Monthly''
        WHEN PA.PERIOD=''Week'' THEN ''Weekly''
    	ELSE PA.PERIOD
     END AS  AUTHORIZATION_UOM
  --  ,NULL AS AUTH_INFO   
,CASE 
        WHEN PA.PERIOD = ''Day'' 
        THEN TO_VARIANT(
            OBJECT_CONSTRUCT(
                ''Sat'',IFF( SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND PA.SATHOURS > 13 ,13,PA.SATHOURS),
                ''Sun'', IFF( SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND PA.SUNHOURS > 13 ,13,PA.SUNHOURS),
                ''Mon'',IFF( SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND PA.MONHOURS > 13 ,13,PA.MONHOURS),
                ''Tue'', IFF( SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND PA.TUEHOURS > 13 ,13,PA.TUEHOURS),
                ''Wed'', IFF( SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND PA.WEDHOURS > 13 ,13,PA.WEDHOURS),
                ''Thu'', IFF( SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND PA.THUHOURS > 13 ,13,PA.THUHOURS),
                ''Fri'', IFF( SC.SERVICECODE ILIKE ANY(''%T1020%'', ''%S5126%'', ''%S5151%'') AND PA.FRIHOURS > 13 ,13,PA.FRIHOURS)
            )
        )
        ELSE NULL 
    END AS AUTH_INFO
    ,CASE WHEN PA.PERIOD =''Day'' THEN COALESCE(NULLIFZERO(PA.MONHOURS),NULLIFZERO(PA.TUEHOURS),NULLIFZERO(PA.WEDHOURS),NULLIFZERO(PA.THUHOURS),NULLIFZERO(PA.FRIHOURS),NULLIFZERO(PA.SATHOURS),NULLIFZERO(PA.SUNHOURS),0)
    	  ELSE PA.MAXUNITSFORPERIOD END AS AUTHORIZATION_MAX_UNITS_BY_UOM
    ,ROUND(CA.HOURS_AUTHORIZED_NON_ADJUSTED,1) AS AUTHORIZATION_MAX_UNITS
    ,CASE WHEN PA.PERIOD =''Day'' THEN IFF(COALESCE(NULLIFZERO(PA.MONHOURS),NULLIFZERO(PA.TUEHOURS),NULLIFZERO(PA.WEDHOURS),NULLIFZERO(PA.THUHOURS),NULLIFZERO(PA.FRIHOURS),NULLIFZERO(PA.SATHOURS),NULLIFZERO(PA.SUNHOURS),0)>24,24,COALESCE(NULLIFZERO(PA.MONHOURS),NULLIFZERO(PA.TUEHOURS),NULLIFZERO(PA.WEDHOURS),NULLIFZERO(PA.THUHOURS),NULLIFZERO(PA.FRIHOURS),NULLIFZERO(PA.SATHOURS),NULLIFZERO(PA.SUNHOURS),0))
--    	  WHEN PA.PERIOD =''Entire Period'' AND CA.FLAG = 1 THEN CA.HOURS_AUTHORIZED
--    	  WHEN PA.PERIOD =''Monthly'' AND CA.FLAG = 1 THEN CA.HOURS_AUTHORIZED/(DATEDIFF(MONTH, PA.FROMDATE, PA.TODATE)+1)
--    	  WHEN PA.PERIOD =''Week'' AND CA.FLAG =1 THEN CA.HOURS_AUTHORIZED/(DATEDIFF(WEEK, PA.FROMDATE, PA.TODATE)+1)
     ELSE PA.MAXUNITSFORPERIOD END AS AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM  
    ,ROUND(CA.HOURS_AUTHORIZED,1) AS AUTHORIZATION_MAX_UNITS_ADJUSTED
   	,IFF(CURRENT_DATE() BETWEEN PA.FROMDATE AND PA.TODATE,TRUE,FALSE) AS ACTIVE_FLAG
,CASE WHEN PA.ISDELETED =''Y'' THEN TRUE ELSE FALSE END AS CANCELLED_FLAG
   	,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
   	,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
   	,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
    ,CURRENT_USER as ETL_INSERTED_BY
    ,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
    ,CURRENT_USER as ETL_LAST_UPDATED_BY
    ,0 AS ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PATIENTAUTHORIZATION PA 
JOIN CLIENT ON CLIENT.PATIENTID = PA.PATIENTID
JOIN HAH.DIM_CLIENT DC 
	ON DC.CLIENT_KEY = CLIENT.CLIENT_KEY
	AND DC.SYSTEM_CODE = ''EDISON''
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PATIENTS P 
	ON P.PATIENTID = CLIENT.PATIENTID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.OFFICE_OFFICES_REPL O 
	ON CLIENT.OFFICEID = O.OFFICEID
LEFT JOIN Max_Auth CA ON  CA.AUTHORIZATIONID = PA.AUTHORIZATIONID
JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.SERVICECODES SC 
	ON SC.CONTRACTID = PA.CONTRACTID
   	AND SC.SERVICECODEID = PA.SERVICECODEID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CONTRACTS C 
	ON SC.CONTRACTID = C.CONTRACTID
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.CONTRACTRATES CR 
	ON  SC.SERVICECODEID  = CR.SERVICECODEID 
	AND CR.TODATE :: DATE > GETDATE()
	AND CR.FROMDATE :: DATE <= GETDATE()
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PAYER_REPL  PR
    ON IFNULL(PR.CONTRACTID,PR.PAYERID) = SC.CONTRACTID
FULL JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.VW_EDISON_REVENUE_SEG RS 
	ON SC.SERVICECODEID  = RS.SERVICECODEID
WHERE PA.AUTHORIZATIONID IS NOT NULL;

RETURN ''SUCCESS'';
end;

 EOT
}

