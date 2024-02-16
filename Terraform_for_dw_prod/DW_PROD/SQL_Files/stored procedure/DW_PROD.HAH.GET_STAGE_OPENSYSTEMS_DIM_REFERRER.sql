CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_OPENSYSTEMS_DIM_REFERRER("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
 --*****************************************************************************************************************************
-- NAME: OPENSYSTEMS_DIM_REFERRER
--
-- PURPOSE: CREATE REFERRAL RECORDS FOR EACH CLIENT 
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 07/27/2023  DEEPEN GAJJAR          INITIAL DEVELOPMENT
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.OPENSYSTEMS_DIM_REFERRER 
SELECT 
md5(r.AGENCYID||''-''||r."REFERRALSOURCEID"||''-''||''OPENSYSTEMS'') REFERRER_KEY,
''17'' as SOURCE_SYSTEM_ID,
''OPENSYSTEMS'' as SYSTEM_CODE,
r.REFERRALSOURCETYPE as REFERRER_TYPE,
NULL as REFERRER_CODE,
upper(iff(trim(r."NAME")='''',NULL,r."NAME" )) as REFERRER_NAME,
NULL as REFERRER_ADDRESS1,
NULL as REFERRER_ADDRESS2,
NULL as REFERRER_CITY,
NULL as REFERRER_STATE_CODE,
NULL as REFERRER_ZIP,
NULL as REFERRER_PHONE,
NULL as REFERRER_FAX,
NULL as DESCRIPTION,
-1 as ETL_TASK_KEY,
-1 as ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ as ETL_INSERTED_DATE,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ as ETL_LAST_UPDATED_DATE,
current_user as ETL_INSERTED_BY,
current_user as ETL_LAST_UPDATED_BY,
FALSE as ETL_DELETED_FLAG
FROM DISC_PROD.HHAEXCHANGEOPENSYSTEMS.REFERRALSOURCE r;
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    ';