resource "snowflake_procedure" "DW_HAH_GET_STAGE_PREFERRED_DIM_PARTNER_CONTRACT" {
	name ="GET_STAGE_PREFERRED_DIM_PARTNER_CONTRACT"
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
-- NAME:  PREFERRED_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER according to PREFERRED 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 03/22/23     SANKET JAIN          Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.PREFERRED_DIM_PARTNER_CONTRACT

SELECT DISTINCT MD5(''PREFERRED'' || ''-'' ||  NVL(PR.PAYERID,-1) || ''-'' || COALESCE(PR.CONTRACTID,PR.PAYERID,S.CONTRACTID) || ''-'' || ''HHAEXCHANGE'') AS PARTNER_CONTRACT_KEY
		, 17 AS SOURCE_SYSTEM_ID
		, CONCAT(''PREFERRED - '',CASE WHEN STATE=''DE'' OR PAYERNAME ILIKE ANY (''%DE'') THEN ''DE''  ELSE ''PA'' END) AS SYSTEM_CODE	
        ,''NY'' AS STATE	
		, MD5(''PREFERRED'' || ''-'' || COALESCE(PR.PAYERID,S.CONTRACTID) || ''-'' || ''HHAEXCHANGE'') AS PARTNER_KEY
		, COALESCE(PR.PAYERID,PR.CONTRACTID,S.CONTRACTID) AS PARTNER_CODE
		, COALESCE(PR.PAYERNAME,S.CONTRACTNAME)
		, COALESCE(PR.CONTRACTID,PR.PAYERID,S.CONTRACTID) AS CONTRACT_CODE
		, COALESCE(PR.PAYERNAME,S.CONTRACTNAME) AS CONTRACT_NAME
		, COALESCE(PR.STATUS,CASE WHEN S.STATUS =''Active'' THEN TRUE ELSE FALSE END) AS ACTIVE_FLAG
		, ''1990-01-01'' AS START_DATE
		, ''9999-12-31''END_DATE 
		, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		, CURRENT_USER AS ETL_INSERTED_BY
		, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		, CURRENT_USER AS ETL_LAST_UPDATED_BY
	 	, 0 AS ETL_DELETED_FLAG
FROM  DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.SERVICECODES S
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HHAEXCHANGEPREFERRED.STAGE_PAYER_REPL PR
	ON IFNULL(PR.CONTRACTID, PR.PAYERID) = S.CONTRACTID;

return ''SUCCESS'';
END;

 EOT
}

