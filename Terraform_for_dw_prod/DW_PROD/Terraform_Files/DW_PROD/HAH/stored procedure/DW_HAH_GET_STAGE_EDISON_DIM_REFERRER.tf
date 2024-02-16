resource "snowflake_procedure" "DW_HAH_GET_STAGE_EDISON_DIM_REFERRER" {
	name ="GET_STAGE_EDISON_DIM_REFERRER"
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
-- NAME: EDISON_DIM_REFERRER
--
-- PURPOSE: CREATE REFERRAL RECORDS FOR EACH CLIENT 
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 07/27/2023  DEEPEN GAJJAR          INITIAL DEVELOPMENT
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.EDISON_DIM_REFERRER 
SELECT 
md5(r.AGENCYID||''-''||r."REFERRALSOURCEID"||''-''||''EDISON'') REFERRER_KEY,
''17'' as SOURCE_SYSTEM_ID,
''EDISON'' as SYSTEM_CODE,
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
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.REFERRALSOURCE r;
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}

