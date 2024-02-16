resource "snowflake_procedure" "DW_HAH_GET_STAGE_DATAFLEXSYNCDATA_DIM_PARTNER" {
	name ="GET_STAGE_DATAFLEXSYNCDATA_DIM_PARTNER"
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
-- NAME:  DATAFLEXSYNCDATA_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER according to DATAFLEX 
--
-- Development LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 06/15/23     SANKET JAIN          Initial Development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.DATAFLEXSYNCDATA_DIM_PARTNER

SELECT DISTINCT MD5(UPPER(TRIM(C.DBNAME)) || ''-'' || UPPER(TRIM(C.CONTRACTCODE)) || ''-'' || ''DATAFLEXSYNCDATA'') AS PARTNER_KEY
        , NULL  AS PARENT_PARTNER_KEY 
        , ''UNKNOWN'' AS PARENT_PARTNER_NAME
		, 3 AS SOURCE_SYSTEM_ID
		, TRIM(C.DBNAME) AS SYSTEM_CODE
		, C.CONTRACTCODE AS PARTNER_CODE
        , C.CONTRACTNAME AS PARTNER_NAME
        , NULL AS PARTNER_TYPE_CODE
        , NULL AS PARTNER_TYPE_NAME
		, TRUE  AS ACTIVE_FLAG
		, ''1990-01-01'' AS START_DATE
		, ''9999-12-31''END_DATE 
		, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		, CURRENT_USER AS ETL_INSERTED_BY
		, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		, CURRENT_USER AS ETL_LAST_UPDATED_BY
	 	, 0 AS ETL_DELETED_FLAG
		, 0 AS ETL_INFERRED_MEMBER_FLAG 
FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCONTRACTS c
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFREVENUESUBCATEGORIES SUBCAT 
	ON TRIM(C.DBNAME) = TRIM(SUBCAT.DBNAME)
	AND TRIM(C.REVENUESUBCATEGORY) = TRIM(SUBCAT.CODE)
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFBILLCODES DB 
	ON DB.BILLCODE = C.DEFAULTBILLCODE AND C.DBNAME = DB.DBNAME;

return ''SUCCESS'';
END;

 EOT
}

