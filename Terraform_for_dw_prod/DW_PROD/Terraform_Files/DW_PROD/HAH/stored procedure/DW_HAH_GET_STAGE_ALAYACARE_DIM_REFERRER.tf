resource "snowflake_procedure" "DW_HAH_GET_STAGE_ALAYACARE_DIM_REFERRER" {
	name ="GET_STAGE_ALAYACARE_DIM_REFERRER"
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
-- NAME: ALAYACARE_DIM_REFERRER
--
-- PURPOSE: CREATE REFERRAL RECORDS FOR EACH CLIENT 
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 07/27/2023  DEEPEN GAJJAR          INITIAL DEVELOPMENT
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ALAYACARE_DIM_REFERRER 
SELECT
	md5(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION),
	''Unknown'') || '' ('' || NVL(p.PROPERTIES_TBL_PROSPECT_CONTACT_IDACCOUNT ,
	-1)::number || '')'' || ''-'' || nvl(p.PROFILE_ID,
	-1)::number)
AS REFERRER_KEY,
	''9'' AS source_system_id,
	UPPER(NVL(TRIM(B.PROPERTIES_TBL_GT_ACCOUNT_DESCRIPTION), ''Unknown'') || '' ('' || NVL(p.PROPERTIES_TBL_PROSPECT_CONTACT_IDACCOUNT ,-1)::number || '')'') AS SYSTEM_CODE,
	NULL AS REFERRER_TYPE,
	NULL AS REFERRER_CODE,
	upper(iff(trim(PROFILE_REFERRAL_SOURCE)= '''', NULL , PROFILE_REFERRAL_SOURCE)) AS REFERRAL_NAME,
NULL AS REFERRER_ADDRESS1,
NULL AS REFERRER_ADDRESS2,
NULL AS REFERRER_CITY,
NULL AS REFERRER_STATE_CODE,
NULL AS REFERRER_ZIP,
NULL AS REFERRER_PHONE,
NULL AS REFERRER_FAX,
NULL AS DESCRIPTION,
-1 AS ETL_TASK_KEY,
-1 AS ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS  ETL_LAST_UPDATED_DATE,
current_user AS ETL_INSERTED_BY,
current_user AS ETL_LAST_UPDATED_BY,
FALSE AS ETL_DELETED_FLAG
FROM
	DISC_${var.SF_ENVIRONMENT}.ALAYACARE.PROFILE p
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.ALAYACARE.BRANCH b ON
	p.PROPERTIES_TBL_PROSPECT_CONTACT_IDACCOUNT = b.BRANCH_ID
WHERE
	iff(trim(PROFILE_REFERRAL_SOURCE)= '''',
	NULL ,
	PROFILE_REFERRAL_SOURCE) IS NOT NULL;
	;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}

