CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_CLEARCARE_FACT_CLIENT_SERVICE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
--*****************************************************************************************************************************
-- NAME:  CLEARCARE_FACT_CLIENT_SERVICE
--25/10/2023    Sagar Gulghane             Initial development

--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.CLEARCARE_FACT_CLIENT_SERVICE
WITH CTE AS (WITH CLIENT AS
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
            DISC_DEDUPE_PROD.CLEARCARE.CLIENT_MASTER_LIST 
    )
    UNION
        SELECT
            DISTINCT PATIENT_ID,
            MASTER_ID,
            AGENCY_ID,
            LAST_NAME,
            FIRST_NAME
        FROM
            DISC_DEDUPE_PROD.CLEARCARE.CLIENT_MATCH_LIST
        WHERE
            PATIENT_ID NOT IN (
            SELECT
                PATIENT_ID
            FROM
                DISC_DEDUPE_PROD.CLEARCARE.CLIENT_MASTER_LIST )         
    ),
         DEDUPE AS   (SELECT   * FROM DISC_PROD.CLEARCARE.BILLING_CLIENTAUTHORIZATION   
         QUALIFY ROW_NUMBER() OVER (PARTITION BY CLIENT_ID ,AUTHORIZATION_ID,PERIOD ,
         SERVICE_ID,BILL_RATE_NAME, START_DATE ,END_DATE ORDER BY UPDATED DESC)=1
         )
SELECT DISTINCT 
    MD5(''CLEARCARE'' 
                    || ''-'' || C.MASTER_ID 
                    || ''-'' || A.AUTHORIZATION_ID 
                    || ''-'' || A.PERIOD  
                    || ''-'' || COALESCE(PS.SERVICE_NAME,''UNKNOWN'')  
                    || ''-'' || A.START_DATE 
                    || ''-'' || A.END_DATE 
                    || ''-'' || A.BILL_RATE_NAME  
                    || ''-'' || COALESCE(A.BILL_RATE_ID,-1)   || ''-'' || ''CLEARCARE'') AS CLIENT_SERVICE_KEY
    ,16 AS SOURCE_SYSTEM_ID     
    , ''CLEARCARE'' AS SYSTEM_CODE,
     MD5(''CLEARCARE'' || ''-'' || NVL(PCM.PAYOR_ID,''-1'') || ''-'' || NVL(PS.SERVICE_NAME,''-1'')  || ''-'' ||  A.BILL_RATE_NAME  || ''-'' || COALESCE(A.BILL_RATE_METHOD ,''-1'') || ''-'' || ''CLEARCARE'') AS PARTNER_CONTRACT_SERVICE_KEY
    ,MD5(''CLEARCARE'' 
|| ''-'' || IFNULL(PA.CONVERSION_DATE,''1'') 
|| ''-'' || C.MASTER_ID
|| ''-'' || ''CLEARCARE'') AS CLIENT_ADMISSION_KEY
    ,MD5(
        ''CLEARCARE'' ||''-''|| C.MASTER_ID::INT ||''-''|| ''CLEARCARE'' 
    ) as CLIENT_KEY
    ,MD5(''CLEARCARE'' || ''-'' || COALESCE(PS.SERVICE_NAME,''UNKNOWN'')   || ''-'' || ''CLEARCARE'') AS SERVICE_KEY
    , CASE WHEN A.BILL_RATE_NAME = '''' AND A.BILL_RATE_METHOD = 4 THEN ''Non-Billable''
         WHEN A.BILL_RATE_NAME = '''' AND A.BILL_RATE_METHOD = 3 THEN ''Live-In''
         WHEN A.BILL_RATE_NAME = '''' AND A.BILL_RATE_METHOD = 2 THEN ''Visit''
         WHEN A.BILL_RATE_NAME = '''' AND A.BILL_RATE_METHOD = 1 THEN ''Hourly''
         ELSE A.BILL_RATE_NAME END AS BILL_CODE
,CASE WHEN AC.TYPE = 1 THEN ''Hourly''
     WHEN AC.TYPE = 2 THEN ''Visit''
     WHEN AC.TYPE = 3 THEN ''Live-In''
     WHEN AC.TYPE = 4 THEN ''Non-Billable''
END AS BILL_TYPE,
NULL AS BILL_UOM
,CASE WHEN A.BILL_RATE_METHOD = 1 THEN ''Hourly''
     WHEN A.BILL_RATE_METHOD = 2 THEN ''Visit''
     WHEN A.BILL_RATE_METHOD = 3 THEN ''Live-In''
     WHEN A.BILL_RATE_METHOD = 4 THEN ''Non-Billable'' ELSE ''Hourly''
END AS SCHEDULE_TYPE -- CHECK WITH bill_u it_type OF fact_visit
,CASE WHEN A.BILL_RATE_METHOD = 1 THEN ''Hourly''
     WHEN A.BILL_RATE_METHOD = 2 THEN ''Visit''
     WHEN A.BILL_RATE_METHOD = 3 THEN ''Live-In''
     WHEN A.BILL_RATE_METHOD = 4 THEN ''Non-Billable''
END  AS SCHEDULE_UOM
,PS.SERVICE_NAME AS AUTHORIZATION_DISCIPLINE
        ,START_DATE AS AUTHORIZATION_DATE
    ,START_DATE AS AUTHORIZATION_PERIOD_START_DATE
    ,END_DATE AS AUTHORIZATION_PERIOD_END_DATE
    ,NULL AS EFFECTIVE_DAYS,
    IFNULL((DATEDIFF(''DAY'',AUTHORIZATION_PERIOD_START_DATE,AUTHORIZATION_PERIOD_END_DATE)+1),0) AS AUTH_DAYS
   ,CASE WHEN A.BILL_RATE_METHOD = 1 THEN ''Hourly''
     WHEN A.BILL_RATE_METHOD = 2 THEN ''Visit''
     WHEN A.BILL_RATE_METHOD = 3 THEN ''Live-In''
     WHEN A.BILL_RATE_METHOD = 4 THEN ''Non-Billable'' ELSE ''Hourly''
END AS  AUTHORIZATION_TYPE,
     CASE WHEN A.PERIOD=1 THEN ''Weekly''
     WHEN A.PERIOD=2 THEN ''Monthly''
     WHEN A.PERIOD=3 THEN ''BiWeekly''
     WHEN A.PERIOD=4 THEN ''Day''
     WHEN A.PERIOD=5 THEN ''Yearly''
     WHEN A.PERIOD=6 THEN ''Entire Period'' 
       ELSE NULL END AS AUTHORIZATION_UOM,
       NULL AS AUTH_INFO
    ,INITIAL_HOURS AS AUTHORIZATION_MAX_UNITS_BY_UOM
    ,CASE WHEN PERIOD=1 THEN (AUTHORIZATION_MAX_UNITS_BY_UOM*(AUTH_DAYS/ 7)) 
          WHEN PERIOD=2 THEN  (AUTHORIZATION_MAX_UNITS_BY_UOM*(DATEDIFF(''MONTH'',AUTHORIZATION_PERIOD_START_DATE,AUTHORIZATION_PERIOD_END_DATE)+1))
          WHEN PERIOD=3 THEN (AUTHORIZATION_MAX_UNITS_BY_UOM*(AUTH_DAYS/ 14))
          WHEN PERIOD=4 THEN AUTHORIZATION_MAX_UNITS_BY_UOM*AUTH_DAYS 
          WHEN PERIOD=5 THEN (AUTHORIZATION_MAX_UNITS_BY_UOM*(AUTH_DAYS/365))
          WHEN PERIOD=6 THEN AUTHORIZATION_MAX_UNITS_BY_UOM END AS AUTHORIZATION_MAX_UNITS
           ,INITIAL_HOURS AS AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM,
          CASE WHEN PERIOD=1 THEN (AUTHORIZATION_MAX_UNITS_BY_UOM*(AUTH_DAYS/ 7)) 
          WHEN PERIOD=2 THEN (AUTHORIZATION_MAX_UNITS_BY_UOM*(DATEDIFF(''MONTH'',AUTHORIZATION_PERIOD_START_DATE,AUTHORIZATION_PERIOD_END_DATE)+1))
          WHEN PERIOD=3 THEN (AUTHORIZATION_MAX_UNITS_BY_UOM*(AUTH_DAYS/ 14))
          WHEN PERIOD=4 THEN AUTHORIZATION_MAX_UNITS_BY_UOM*AUTH_DAYS 
          WHEN PERIOD=5 THEN (authorization_max_units_by_uom*(AUTH_DAYS/365))
          WHEN PERIOD=6 THEN AUTHORIZATION_MAX_UNITS_BY_UOM END AS AUTHORIZATION_MAX_UNITS_ADUSTED
         ,IFF(A.STATUS IN (1,2),TRUE,FALSE) AS ACTIVE_FLAG
         ,IFF(A.STATUS IN (3,4),TRUE,FALSE) AS CANCELEED_FLAG
,:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
      :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
     convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
     CURRENT_USER                                              as ETL_INSERTED_BY,
     convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
     CURRENT_USER                                              as ETL_LAST_UPDATED_BY,
     0                                                          AS ETL_DELETED_FLAG   
FROM DEDUPE A   
left JOIN CLIENT C ON C.PATIENT_ID = A.CLIENT_ID-- AND C.AGENCY_ID =A.AGENCY_ID 
LEFT JOIN DISC_PROD.CLEARCARE.BILLING_BILLRATE AC ON AC.ID=A.BILL_RATE_ID AND AC.NAME=A.BILL_RATE_NAME
LEFT JOIN DISC_PROD.CLEARCARE.PROFILE_PARENTPAYERSERVICE PS ON PS.ID =A.SERVICE_ID 
--LEFT JOIN DISC_PROD.CLEARCARE.CARELOGS_CARELOG BC  ON A.CLIENT_ID=BC.PATIENT_ID AND A.AGENCY_ID =BC.AGENCY_ID 
--AND A.AUTHORIZATION_ID =BC.AUTHORIZATION_ID::VARCHAR AND A.BILL_RATE_ID =BC.BILL_RATE_OBJ_ID AND A.START_DATE BETWEEN BC.CLOCK_IN AND BC.CLOCK_OUT 
LEFT JOIN DISC_PROD.CLEARCARE.PATIENT_PATIENT PA ON C.patient_id = PA.id 
LEFT JOIN DISC_PROD.CLEARCARE.AGENCY_AGENCYLOCATION AG ON AG.ID = PA.LOCATION_ID
LEFT JOIN DISC_PROD.PAYOR_contract_UI.PAYOR_contract_MAPPING PCM ON
    CASE
        WHEN A.BILL_RATE_NAME = ''''
        AND A.BILL_RATE_METHOD = 4 THEN ''Non-Billable''
        WHEN A.BILL_RATE_NAME = ''''
        AND A.BILL_RATE_METHOD = 3 THEN ''Live-In''
        WHEN A.BILL_RATE_NAME = ''''
        AND A.BILL_RATE_METHOD = 2 THEN ''Visit''
        WHEN A.BILL_RATE_NAME = ''''
        AND A.BILL_RATE_METHOD = 1 THEN ''Hourly''
        ELSE A.BILL_RATE_NAME
    END = PCM.CONTRACT_CODE AND PCM.ORIGINAL_SOURCE_SYSTEM_ID=16
WHERE AG.AGENCY_ID IN (2459) AND START_DATE <=END_DATE)
SELECT CLIENT_SERVICE_KEY,
SOURCE_SYSTEM_ID,
SYSTEM_CODE, 
PARTNER_CONTRACT_SERVICE_KEY,
CLIENT_ADMISSION_KEY,
CLIENT_KEY,
SERVICE_KEY,
BILL_CODE,
BILL_TYPE,
BILL_UOM,
SCHEDULE_TYPE,
SCHEDULE_UOM,
AUTHORIZATION_DISCIPLINE,
AUTHORIZATION_DATE,
AUTHORIZATION_PERIOD_START_DATE,
AUTHORIZATION_PERIOD_END_DATE,
EFFECTIVE_DAYS,
AUTHORIZATION_TYPE,
AUTHORIZATION_UOM,
AUTH_INFO,
AUTHORIZATION_MAX_UNITS_BY_UOM,
AUTHORIZATION_MAX_UNITS,
AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM,
AUTHORIZATION_MAX_UNITS_ADUSTED,
ACTIVE_FLAG,
CANCELEED_FLAG,
ETL_TASK_KEY,
ETL_INSERTED_TASK_KEY,
ETL_INSERTED_DATE,
ETL_INSERTED_BY,
ETL_LAST_UPDATED_DATE,
ETL_LAST_UPDATED_BY,
ETL_DELETED_FLAG FROM CTE;
SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
RETURN return_result;

END;
';