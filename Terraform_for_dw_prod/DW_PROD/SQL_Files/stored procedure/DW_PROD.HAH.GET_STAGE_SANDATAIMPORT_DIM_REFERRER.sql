CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_SANDATAIMPORT_DIM_REFERRER("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
 --*****************************************************************************************************************************
-- NAME: SANDATAIMPORT_DIM_REFERRER
--
-- PURPOSE: CREATE REFERRAL RECORDS FOR EACH CLIENT 
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 07/27/2023  DEEPEN GAJJAR          INITIAL DEVELOPMENT
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.SANDATAIMPORT_DIM_REFERRER 
SELECT 
md5(r.AGENCYID||''-''||r.REFERRALID||''-''||''SANDATAIMPORT'') as REFERRER_KEY,
''4'' as SOURCE_SYSTEM_ID,
r.AGENCYID as SYSTEM_CODE,
r.SOURCETYPE as REFERRER_TYPE,
NULL as REFERRER_CODE,
upper(iff(trim(r.LASTNAME)='''',NULL,r.LASTNAME)) as REFERRER_NAME,
iff(trim(r.ADDRESS)='''',NULL,r.ADDRESS ) as REFERRER_ADDRESS1,
iff(trim(r.ADDRESS2)='''',NULL,r.ADDRESS2) as REFERRER_ADDRESS2,
iff(trim(r.CITY)='''',NULL,r.CITY ) as REFERRER_CITY,
iff(trim(r.STATE)='''',NULL,r.STATE ) as REFERRER_STATE_CODE,
iff(trim(r.ZIP )='''',NULL,r.ZIP ) as REFERRER_ZIP,
COALESCE(r.HOMEPHONE,r.WORKPHONE, r.MOBILEPHONE) as REFERRER_PHONE,
iff(trim(r.FAX)='''',NULL,r.FAX ) as REFERRER_FAX,
NULL as DESCRIPTION,
-1 as ETL_TASK_KEY,
-1 as ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ as ETL_INSERTED_DATE,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ as ETL_LAST_UPDATED_DATE,
current_user as ETL_INSERTED_BY,
current_user as ETL_LAST_UPDATED_BY,
FALSE as ETL_DELETED_FLAG
FROM DISC_PROD.SANDATAIMPORT.SANDATA_REFERRALSOURCES r
WHERE REFERRER_NAME IS NOT NULL ;
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    ';