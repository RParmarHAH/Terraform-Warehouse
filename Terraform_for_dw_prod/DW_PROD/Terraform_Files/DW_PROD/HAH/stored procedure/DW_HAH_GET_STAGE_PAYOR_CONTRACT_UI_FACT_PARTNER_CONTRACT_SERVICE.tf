resource "snowflake_procedure" "DW_HAH_GET_STAGE_PAYOR_CONTRACT_UI_FACT_PARTNER_CONTRACT_SERVICE" {
	name ="GET_STAGE_PAYOR_CONTRACT_UI_FACT_PARTNER_CONTRACT_SERVICE"
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
-- NAME:  PAYOR_CONTRACT_UI_FACT_PARTNER_CONTRACT_SERVICE
--
-- PURPOSE: Creates one row per PARTNER according to ASR 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 01/30/24    Shraddha Sejpal        Initial development
-- 02/08/24    Nutan Jagnade          Added state
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.PAYOR_CONTRACT_UI_FACT_PARTNER_CONTRACT_SERVICE
SELECT DISTINCT MD5( PCM.SYSTEM_CODE||''-''||PCM.PAYOR_ID||''-''||PCM.ORIGINAL_SYSTEM_CODE||''-''||PCM.CONTRACT_CODE||''-''||PCM.CONTRACT_NAME||''-''||''Payor_Contract UI'') AS PARTNER_CONTRACT_SERVICE_KEY
		, PCM.SOURCE_SYSTEM_ID AS SOURCE_SYSTEM_ID
		, PCM.SYSTEM_CODE AS SYSTEM_CODE
		, PCM.ORIGINAL_SOURCE_SYSTEM_ID AS ORIGINAL_SOURCE_SYSTEM_ID
		, PCM.ORIGINAL_SYSTEM_CODE AS ORIGINAL_SYSTEM_CODE
		, P.PAYOR_STATE_CODE AS STATE
        , MD5( PCM.SYSTEM_CODE||''-''||PCM.PAYOR_ID||''-''||PCM.ORIGINAL_SYSTEM_CODE||''-''||PCM.CONTRACT_CODE||''-''||PCM.CONTRACT_NAME||''-''||''Payor_Contract UI'') AS PARTNER_CONTRACT_KEY
		, NVL(PCM.PAYOR_ID, ''-1'') AS PARTNER_CODE
		, PCM.PAYOR_NAME AS PARTNER_NAME 
		, PCM.CONTRACT_CODE AS CONTRACT_CODE
		, PCM.CONTRACT_NAME AS CONTRACT_NAME
        ,NULL AS SERVICE_KEY
		,NULL AS SERVICE_CODE
        ,NULL AS SERVICE_NAME
		,NULL AS BILLING_KEY
		,NULL AS BILLING_CODE
		,NULL AS BILL_NAME
		,NULL AS BILLABLE_FLAG
		,NULL AS BILL_TYPE
		,NULL AS BILL_UOM
		,NULL AS SCHEDULE_TYPE
		,NULL AS SCHEDULE_UOM
		,NULL AS AUTHORIZATION_REQUIRED_FLAG
		,NULL AS PAYABLE_FLAG             
		,NULL AS EXPENSE_FLAG                
		,NULL AS MILEAGE_FLAG
		, -1 AS ETL_TASK_KEY
		, -1 AS ETL_INSERTED_TASK_KEY
	    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		, CURRENT_USER AS ETL_INSERTED_BY
		, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		, CURRENT_USER AS ETL_LAST_UPDATED_BY
	 	, 0 AS ETL_DELETED_FLAG
	FROM DISC_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_UI.PAYOR_CONTRACT_MAPPING PCM
LEFT JOIN  DISC_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_UI.PAYOR P ON P.PAYOR_ID = PCM.PAYOR_ID;
return ''SUCCESS'';
END;

 EOT
}

