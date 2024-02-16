CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_SANDATAIMPORT_FACT_CLIENT_SERVICE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN

--*****************************************************************************************************************************
-- NAME:  SANDATA FACT CLIENT SERVICE
--
-- PURPOSE: Populates Stage SANDATA FACT CLIENT SERVICE
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 12/28/22    RAJAT SAPKAL          Initial version
-- 03/14/23	Shraddha Sejpal	  added Cancelled_Flag
-- 03/22/23	Vijay Sharma		  Added AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM,AUTHORIZATION_MAX_UNITS_ADJUSTED
-- 04/12/23	Vijay Sharma		  Remove CONTRACT from SERVICE_KEY
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.SANDATAIMPORT_FACT_CLIENT_SERVICE
WITH UNITTYPE AS
(
	SELECT DISTINCT * FROM 
	(
		SELECT row_number() OVER (PARTITION BY SCHEDULEID ORDER BY rate desc) rn,AGENCYID ,AUTHORIZATIONID,
				CASE UNITTYPE WHEN ''01'' THEN ''Hourly'' 
					  	  	  WHEN ''02'' THEN ''Visit'' 
					  	  	  WHEN ''05'' THEN ''Hourly'' 
					  	  	  WHEN ''06'' THEN ''Per Diem'' 
			else NULL END AS UNITTYPE 
		FROM DISC_PROD.SANDATAIMPORT.SANDATA_SCHEDULESCLIENTS
		WHERE AGENCYID =''8485'' AND RATE NOT IN (0.00, 0.01) AND (UNITTYPE IS NOT NULL OR UNITTYPE <>'''')
	)
	WHERE rn=1 
),
CLIENT AS
(
	SELECT * FROM
	(
		SELECT CLIENTID, MASTER_ID, AGENCYID
		FROM DISC_DEDUPE_PROD.SANDATAIMPORT.CLIENT_MASTER_LIST
        WHERE AGENCYID=8485 
	)
	UNION
	SELECT * FROM
	(
		SELECT DISTINCT CLIENTID, MASTER_ID, AGENCYID
		FROM DISC_DEDUPE_PROD.SANDATAIMPORT.CLIENT_MATCH_LIST
		WHERE CLIENTID NOT IN (SELECT CLIENTID FROM DISC_DEDUPE_PROD.SANDATAIMPORT.CLIENT_MASTER_LIST ) 
        AND AGENCYID=8485
	)
)
,
DATA AS(
SELECT
CASE WHEN AUTH.SERVICEID IN (''CARECO'' , ''VBPCG'') THEN
MD5(
            ''CC_''||IFNULL(AUTH.AGENCYID,-1) || ''-'' ||
            IFNULL(AUTH.ADMISSIONID, ''-1'') || ''-'' ||
            IFNULL(AUTH.SERVICEID , ''UNKNOWN'') || ''-'' ||
            IFNULL(AUTH.AUTHID, -1) || ''-'' ||
            ''SANDATAIMPORT''
	)	
ELSE 
MD5(
            IFNULL(AUTH.AGENCYID,-1) || ''-'' ||
            IFNULL(AUTH.ADMISSIONID, ''-1'') || ''-'' ||
            IFNULL(AUTH.SERVICEID , ''UNKNOWN'') || ''-'' ||
            IFNULL(AUTH.AUTHID, -1) || ''-'' ||
            ''SANDATAIMPORT''
	) END  AS CLIENT_SERVICE_KEY,	
4 																	AS SOURCE_SYSTEM_ID,
CASE WHEN AUTH.SERVICEID IN (''CARECO'' , ''VBPCG'')	
		THEN ''CC_''||CAD.AGENCYID
		ELSE CAD.AGENCYID END AS SYSTEM_CODE,
CASE WHEN AUTH.SERVICEID IN (''CARECO'' , ''VBPCG'')	
THEN MD5(''CC_''||IFNULL(CAD.AGENCYID,-1) || ''-'' || IFNULL(NULLIFZERO(AUTH.PAYORID),-1) || ''-'' || IFNULL(CAD.ADMISSIONTYPE , ''UNKNOWN'') || ''-'' ||
			IFNULL(AUTH.SERVICEID , ''UNKNOWN'') || ''-'' || COALESCE(U.UNITTYPE, ''UNKNOWN'') || ''-'' || ''SANDATAIMPORT'' )
ELSE MD5(IFNULL(CAD.AGENCYID,-1) || ''-'' || IFNULL(NULLIFZERO(AUTH.PAYORID),-1) || ''-'' || IFNULL(CAD.ADMISSIONTYPE , ''UNKNOWN'') || ''-'' ||
			IFNULL(AUTH.SERVICEID , ''UNKNOWN'') || ''-'' || COALESCE(U.UNITTYPE, ''UNKNOWN'') || ''-'' || ''SANDATAIMPORT'' )
END AS PARTNER_CONTRACT_SERVICE_KEY,
CASE WHEN AUTH.SERVICEID IN (''CARECO'' , ''VBPCG'')
THEN MD5(''CC_''||IFNULL(CAD.AGENCYID,''-1'') || ''-'' || IFNULL(CAD.ADMISSIONID,''-1'') || ''-'' || IFNULL(C.MASTER_ID,''-1'')  
|| ''-'' || IFNULL(CAD.ADMISSIONTYPE , ''UNKNOWN'') || ''-'' || IFNULL(AUTH.PAYORID,''-1'') || ''-'' || IFNULL(AUTH.SERVICEID, ''UNKNOWN'') || ''-'' || ''SANDATAIMPORT'')
ELSE MD5(IFNULL(CAD.AGENCYID,''-1'') || ''-'' || IFNULL(CAD.ADMISSIONID,''-1'') || ''-'' || IFNULL(C.MASTER_ID,''-1'')  
|| ''-'' || IFNULL(CAD.ADMISSIONTYPE , ''UNKNOWN'') || ''-'' || IFNULL(AUTH.PAYORID,''-1'') || ''-'' || IFNULL(AUTH.SERVICEID, ''UNKNOWN'') || ''-'' || ''SANDATAIMPORT'') END AS CLIENT_ADMISSION_KEY,
MD5(
			IFNULL(CAD.AGENCYID,''-1'') || ''-'' ||
			IFNULL(C.MASTER_ID,''-1'') || ''-''  ||
			''SANDATAIMPORT'' 
	) 																AS CLIENT_KEY,
CASE WHEN AUTH.SERVICEID IN (''CARECO'' , ''VBPCG'') AND AUTH.SERVICEID IS NOT NULL  
	THEN MD5(''CC_''||IFNULL(CAD.AGENCYID,-1) || ''-'' || IFNULL(AUTH.SERVICEID , ''UNKNOWN'') || ''-'' || ''SANDATAIMPORT'')
WHEN AUTH.SERVICEID IS NOT NULL  
	THEN MD5(IFNULL(CAD.AGENCYID,-1) || ''-'' || IFNULL(AUTH.SERVICEID , ''UNKNOWN'') || ''-'' || ''SANDATAIMPORT'') 
ELSE  ''-1'' END AS SERVICE_KEY,
P.BILLCODE 															AS BILL_CODE,
CASE WHEN SS.DEFAULTBILLTYPE= ''01'' THEN ''Hourly''
	 WHEN SS.DEFAULTBILLTYPE= ''02'' THEN ''Visit''
	 WHEN SS.DEFAULTBILLTYPE= ''05'' THEN ''UNIT'' 
	 ELSE NULL 
END 																AS BILL_TYPE,
NULL 																AS BILL_UOM,
U.UNITTYPE 															AS SCHEDULE_TYPE,
NULL 																AS SCHEDULE_UOM,
AUTH.SERVICEID  													AS AUTHORIZATION_DISCIPLINE,
AUTH.DATEBEGIN 														AS AUTHORIZATION_DATE,
AUTH.DATEBEGIN 														AS AUTHORIZATION_PERIOD_START_DATE,
AUTH.DATEEND 														AS AUTHORIZATION_PERIOD_END_DATE,
NULL AS EFFECTIVE_DAYS,  
CASE WHEN AUTH."FORMAT"  = ''01'' THEN ''Hourly Authorization''
	 WHEN AUTH."FORMAT"  = ''02'' THEN ''Visit Authorization''
	 WHEN AUTH."FORMAT"  = ''03'' THEN ''Unit Authorization'' 
	 ELSE NULL 
END 																AS AUTHORIZAITON_TYPE,
--AUTH.LIMITTYPE 														AS AUTHORIZATION_UOM,
CASE 
     	WHEN AUTH.LIMITTYPE =''Month'' THEN ''Monthly''
        WHEN AUTH.LIMITTYPE =''Week'' THEN ''Weekly''
        WHEN AUTH.LIMITTYPE =''Year'' THEN ''Yearly''
    	ELSE AUTH.LIMITTYPE
     END                                                              AS  AUTHORIZATION_UOM,
--	CASE WHEN AUTH.MAXIMUM=0 THEN TRUE else false END                   AS UNLIMITED_UNITS_FLAG,
NULL AS AUTH_INFO,
AUTH.PERIODLIMIT 													AS AUTHORIZATION_MAX_UNITS_BY_UOM,
IFF(AUTH.FORMAT =''03'',AUTH.MAXIMUM/4,AUTH.MAXIMUM) AS AUTHORIZATION_MAX_UNITS,--Max units for period (0 for unlimited)
--
AUTH.PERIODLIMIT AS AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM,
IFF(AUTH.FORMAT =''03'',AUTH.MAXIMUM/4,AUTH.MAXIMUM) AS AUTHORIZATION_MAX_UNITS_ADJUSTED,
--
iff(current_date() between AUTH.DATEBEGIN and AUTH.DATEEND, true, false) AS ACTIVE_FLAG,
IFF(AUTH.AUTHVOIDED=1,TRUE,FALSE) AS CANCELLED_FLAG,
	:STR_ETL_TASK_KEY  AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY  AS ETL_INSERTED_TASK_KEY,
     convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
     CURRENT_USER as ETL_INSERTED_BY,
     convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
     CURRENT_USER as ETL_LAST_UPDATED_BY,
     0  as ETL_DELETED_FLAG
FROM DISC_PROD.SANDATAIMPORT.SANDATA_AUTHORIZATIONS AUTH
     LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_CLIENTADMISSIONS CAD 
     			ON CAD.ADMISSIONID = AUTH.ADMISSIONID AND CAD.AGENCYID = AUTH.AGENCYID
     LEFT JOIN CLIENT C
     			ON CAD.CLIENTID = C.CLIENTID and CAD.AGENCYID = C.AGENCYID
     LEFT join DISC_PROD.SANDATAIMPORT.SANDATA_PAYORS P 
     			ON AUTH.PAYORID =P.PAYORID AND AUTH.AGENCYID = P.AGENCYID
     LEFT JOIN DISC_PROD.SANDATAIMPORT.SANDATA_SERVICES SS 
     			ON CAD.AGENCYID = SS.AGENCYID  AND AUTH.SERVICEID =SS.SERVICECODE
     LEFT JOIN UNITTYPE U
				ON CAD.AGENCYID = U.AGENCYID  AND AUTH.AUTHID =U.AUTHORIZATIONID
	 WHERE CAD.AGENCYID=''8485'' --AND CAD.ADMISSIONSTATUS IN (''02'',''03'',''04'')--AND AUTH.AUTHVOIDED=0
)
SELECT CLIENT_SERVICE_KEY,SOURCE_SYSTEM_ID,SYSTEM_CODE,PARTNER_CONTRACT_SERVICE_KEY,CLIENT_ADMISSION_KEY,CLIENT_KEY,SERVICE_KEY,
BILL_CODE,BILL_TYPE,BILL_UOM,SCHEDULE_TYPE,SCHEDULE_UOM,AUTHORIZATION_DISCIPLINE,AUTHORIZATION_DATE,
AUTHORIZATION_PERIOD_START_DATE,AUTHORIZATION_PERIOD_END_DATE,EFFECTIVE_DAYS,AUTHORIZAITON_TYPE,AUTHORIZATION_UOM,AUTH_INFO,AUTHORIZATION_MAX_UNITS_BY_UOM,
AUTHORIZATION_MAX_UNITS,AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM,AUTHORIZATION_MAX_UNITS_ADJUSTED,
ACTIVE_FLAG,CANCELLED_FLAG,ETL_TASK_KEY,ETL_INSERTED_TASK_KEY,
ETL_INSERTED_DATE,ETL_INSERTED_BY,ETL_LAST_UPDATED_DATE,ETL_LAST_UPDATED_BY,ETL_DELETED_FLAG FROM DATA;
SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
RETURN return_result;

END;

';