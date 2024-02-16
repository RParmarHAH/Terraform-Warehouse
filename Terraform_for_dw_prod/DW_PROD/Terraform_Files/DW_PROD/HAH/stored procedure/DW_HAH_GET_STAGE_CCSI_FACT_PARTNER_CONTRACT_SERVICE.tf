resource "snowflake_procedure" "DW_HAH_GET_STAGE_CCSI_FACT_PARTNER_CONTRACT_SERVICE" {
	name ="GET_STAGE_CCSI_FACT_PARTNER_CONTRACT_SERVICE"
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
-- NAME:  CCSI FACT PARTNER CONTRACT SERVICE
--
-- PURPOSE: Populates Stage CCSI  FACT PARTNER CONTRACT SERVICE
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 11/10/23      Sanket Jain          Initial version
-- 12/25/23		 Shraddha Sejpal	  Added State
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.CCSI_FACT_PARTNER_CONTRACT_SERVICE

WITH CTE AS ( 
SELECT DISTINCT 
		MD5(''CCSI'' || ''-'' || UPPER(TRIM(PCM.PAYOR_ID)) || ''-'' || upper(TRIM(R.CONTRACT_NO)) || ''-'' || UPPER(TRIM(R.SERVICE_TYPE)) || ''-'' || ''CCSI'') AS PARTNER_CONTRACT_SERVICE_KEY
		,8 AS SOURCE_SYSTEM_ID
		, ''CCSI'' AS SYSTEM_CODE
		,''IL'' AS STATE
		,MD5(''CCSI'' || ''-'' || UPPER(TRIM(PCM.PAYOR_ID)) || ''-'' || upper(TRIM(R.CONTRACT_NO)) || ''-'' || ''CCSI'') AS PARTNER_CONTRACT_KEY
		, UPPER(TRIM(PCM.PAYOR_ID))  AS PARTNER_CODE
        , UPPER(TRIM(PCM.PAYOR_NAME))  AS PARTNER_NAME
		, UPPER(TRIM(R.CONTRACT_NO)) AS CONTRACT_CODE
        , UPPER(TRIM(R.CONTRACT_NO)) AS CONTRACT_NAME,
		MD5(''CCSI'' || ''-''|| UPPER(TRIM(R.SERVICE_TYPE))   || ''-''|| ''CCSI'') AS SERVICE_KEY,
		UPPER(TRIM(R.SERVICE_TYPE)) AS SERVICE_CODE,
		UPPER(TRIM(R.SERVICE_TYPE)) AS SERVICE_NAME,
		NULL AS BILLING_KEY,
	    NULL AS BILL_CODE,
	    NULL AS BILL_NAME , 
	    TRUE AS BILLABLE_FLAG,
	    ''Hourly'' AS BILL_TYPE,
	    ''Hourly'' AS BILL_UOM,
	    ''Hourly'' AS SCHEDULE_TYPE ,
	    ''Hourly''  AS SCHEDULE_UOM,
	    TRUE AS AUTHORIZATION_REQUIRED_FLAG ,
	    TRUE AS PAYABLE_FLAG,
	    FALSE AS  EXPENSE_FLAG,
	    FALSE  AS MILEAGE_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.CCSI.RAWVRFP  R
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_UI.PAYOR_CONTRACT_MAPPING PCM
		ON  PCM.ORIGINAL_SOURCE_SYSTEM_ID = 8
		AND UPPER(R.CONTRACT_NO) = PCM.CONTRACT_CODE
WHERE R.CONTRACT_NO IS NOT NULL) 
	 SELECT *	, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		, CURRENT_USER AS ETL_INSERTED_BY
		, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		, CURRENT_USER AS ETL_LAST_UPDATED_BY
	 	, 0 AS ETL_DELETED_FLAG FROM CTE ;

	RETURN ''SUCCESS'';
end;

 EOT
}

