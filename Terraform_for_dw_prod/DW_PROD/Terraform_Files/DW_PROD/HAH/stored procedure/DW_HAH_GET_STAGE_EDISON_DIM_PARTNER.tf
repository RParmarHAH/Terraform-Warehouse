resource "snowflake_procedure" "DW_HAH_GET_STAGE_EDISON_DIM_PARTNER" {
	name ="GET_STAGE_EDISON_DIM_PARTNER"
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
-- NAME:  EDISON_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER according to EDISON 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 03/22/23     SANKET JAIN          Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.EDISON_DIM_PARTNER

WITH  PARTNER AS 
(
	SELECT MD5(''EDISON'' || ''-'' || PR.PAYERID || ''-'' || ''HHAEXCHANGE'') AS PARTNER_KEY
        , NULL AS PARENT_PARTNER_KEY
        , ''UNKNOWN'' AS PARENT_PARTNER_NAME 
		, 17 AS SOURCE_SYSTEM_ID
		, ''EDISON'' AS SYSTEM_CODE
		, PR.PAYERNAME AS PARTNER_NAME                                                                                      
		, COALESCE(PR.PAYERID,PR.CONTRACTID)  AS PARTNER_CODE
		, PR.STATUS  AS ACTIVE_FLAG
		FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PAYER_REPL PR
)
,ADDITIONAL_PARTNER AS (
	SELECT * FROM PARTNER
	UNION ALL
  	SELECT DISTINCT MD5(''EDISON'' || ''-'' || S.CONTRACTID || ''-'' || ''HHAEXCHANGE'') AS PARTNER_KEY
        , NULL AS PARENT_PARTNER_KEY
        , ''UNKNOWN'' AS PARENT_PARTNER_NAME 
		, 17 AS SOURCE_SYSTEM_ID
		, ''EDISON'' AS SYSTEM_CODE
		, CASE WHEN S.CONTRACTID IN (18121) THEN regexp_replace(S.CONTRACTNAME,''.....$'','''') ELSE S.CONTRACTNAME END AS PARTNER_NAME                                                                                      
		, S.CONTRACTID  AS PARTNER_CODE
		, CASE WHEN S.STATUS =''Active'' THEN TRUE ELSE FALSE END AS ACTIVE_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.SERVICECODES S  WHERE PARTNER_KEY NOT IN 
(SELECT PARTNER_KEY FROM PARTNER) AND S.CONTRACTID NOT IN (SELECT CONTRACTID FROM DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEEDISON.PAYER_REPL)
QUALIFY ROW_NUMBER() OVER (PARTITION BY PARTNER_CODE ORDER BY ACTIVE_FLAG desc ) = 1
)
SELECT *, ''1990-01-01'' AS START_DATE
		, ''9999-12-31''END_DATE 
		, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		, CURRENT_USER AS ETL_INSERTED_BY
		, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		, CURRENT_USER AS ETL_LAST_UPDATED_BY
	 	, 0 AS ETL_DELETED_FLAG
		, 0 AS ETL_INFERRED_MEMBER_FLAG 
FROM ADDITIONAL_PARTNER;

return ''SUCCESS'';
END;

 EOT
}

