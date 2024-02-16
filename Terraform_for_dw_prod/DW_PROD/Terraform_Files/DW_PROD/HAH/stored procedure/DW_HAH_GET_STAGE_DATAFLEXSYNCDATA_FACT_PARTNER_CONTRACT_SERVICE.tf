resource "snowflake_procedure" "DW_HAH_GET_STAGE_DATAFLEXSYNCDATA_FACT_PARTNER_CONTRACT_SERVICE" {
	name ="GET_STAGE_DATAFLEXSYNCDATA_FACT_PARTNER_CONTRACT_SERVICE"
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
-- NAME:  DATAFLEXSYNCDATA_FACT_PARTNER_CONTRACT_SERVICE
--
-- PURPOSE: Creates one row per PARTNER  AND CONTRACT and service according to DATAFLEX 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 06/15/23     SANKET JAIN          Initial development
-- 12/25/23		Shraddha Sejpal		 Added State
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.DATAFLEXSYNCDATA_FACT_PARTNER_CONTRACT_SERVICE

SELECT
	DISTINCT MD5(UPPER(TRIM(C.DBNAME)) || ''-'' || UPPER(TRIM(C.CONTRACTCODE)) || ''-'' || TRIM(C.REVENUESUBCATEGORY) || ''-'' || ''DATAFLEXSYNCDATA'') AS PARTNER_CONTRACT_SERVICE_KEY,
	''3'' AS SOURCE_SYSTEM_ID,
	TRIM(C.DBNAME) AS SYSTEM_CODE,
	TRIM(C.DBNAME) AS STATE,
    MD5(UPPER(TRIM(C.DBNAME)) || ''-'' || UPPER(TRIM(C.CONTRACTCODE)) || ''-'' || ''DATAFLEXSYNCDATA'') AS PARTNER_CONTRACT_KEY,
	C.CONTRACTCODE AS PARTNER_CODE,
	C.CONTRACTNAME AS PARTNER_NAME,
	C.CONTRACTCODE AS CONTRACT_CODE,
	C.CONTRACTNAME AS CONTRACT_NAME,
	MD5(TRIM(C.DBNAME) || ''-'' || TRIM(C.REVENUESUBCATEGORY) || ''-'' || TRIM(C.REVENUECATEGORY) || ''-'' || ''DATAFLEXSYNCDATA'') AS SERVICE_KEY,
	TRIM(C.REVENUESUBCATEGORY) AS SERVICECODE,
	TRIM(SUBCAT."NAME") AS SERVICENAME,
	NULL AS BILLING_KEY,
	NULLIF(C.DEFAULTBILLCODE,'''') AS BILLING_CODE,
	DB.DESCRIPTION AS BILL_NAME,
	C.BILLABLE AS BILLABLE_FLAG,
	COALESCE(DB.TYPE,''Hourly'') AS BILL_TYPE,
	CASE WHEN BILLBYHALFHOURS = ''TRUE'' THEN ''Half Hours''
         WHEN BILLEDBYQUARTERHOURS = ''TRUE'' THEN ''Quarter Hours''
    ELSE ''Hourly'' END  AS BILL_UOM,
	''Hourly'' AS SCHEDULE_TYPE,
	NULL AS SCHEDULE_UOM,
	TRUE AS AUTHORIZATION_REQUIRED_FLAG,
	C.PAYABLE AS PAYABLE_FLAG,                       
	FALSE AS EXPENSE_FLAG,                    
	COALESCE(C.ISMILEAGE, FALSE) AS MILEAGE_FLAG,                       
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY,
	0 as ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFCONTRACTS c
LEFT JOIN
	DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFREVENUESUBCATEGORIES SUBCAT 
	ON TRIM(C.DBNAME) = TRIM(SUBCAT.DBNAME)
	AND TRIM(C.REVENUESUBCATEGORY) = TRIM(SUBCAT.CODE)
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.DATAFLEXSYNCDATA.DFBILLCODES DB 
	ON DB.BILLCODE = C.DEFAULTBILLCODE AND C.DBNAME = DB.DBNAME;

return ''SUCCESS'';
END;

 EOT
}

