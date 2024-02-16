resource "snowflake_procedure" "DW_INTEGRATION_FACT_CLIENT_SERVICE_MERGED_POSTPROCESSING" {
	name ="FACT_CLIENT_SERVICE_MERGED_POSTPROCESSING"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
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
--***************************************************************************************************************************
-- DEVELOPMENT LOG:
-- DATE         AUTHOR                  NOTES:
-- --------     -------------------     -----------------------------------------------------------------------------------------------
--03/20/2023    SANKET JAIN             Initial version 
--***************************************************************************************************************************
 
INSERT OVERWRITE INTO INTEGRATION.FACT_CLIENT_SERVICE_MERGED
SELECT CS.CLIENT_SERVICE_KEY,
       COALESCE(CM.SOURCE_SYSTEM_ID, CS.SOURCE_SYSTEM_ID) AS SOURCE_SYSTEM_ID,
       CS.SOURCE_SYSTEM_ID AS ORIGINAL_SOURCE_SYSTEM_ID,
       COALESCE(CM.SYSTEM_CODE, CS.SYSTEM_CODE) AS SYSTEM_CODE,
       CS.SYSTEM_CODE AS ORIGINAL_SYSTEM_CODE,
       PARTNER_CONTRACT_SERVICE_KEY,
       CLIENT_ADMISSION_KEY,
       COALESCE(CM.CLIENT_KEY, CS.CLIENT_KEY) AS CLIENT_KEY,
       CS.CLIENT_KEY AS ORIGINAL_CLIENT_KEY,
       CS.SERVICE_KEY,
       CS.BILL_CODE,
       CS.BILL_TYPE,
       CS.BILL_UOM,
       CS.SCHEDULE_TYPE,
       CS.SCHEDULE_UOM,
       CS.AUTHORIZATION_DISCIPLINE,
       CS.AUTHORIZATION_DATE,
       CS.AUTHORIZATION_PERIOD_START_DATE,
       CS.AUTHORIZATION_PERIOD_END_DATE,
       CS.EFFECTIVE_DAYS,
       CS.AUTHORIZATION_TYPE,
       CS.AUTHORIZATION_UOM,
       CS.AUTH_INFO,
       CS.AUTHORIZATION_MAX_UNITS_BY_UOM,
       CS.AUTHORIZATION_MAX_UNITS,
       CS.AUTHORIZATION_MAX_UNITS_ADJUSTED_BY_UOM,
       CS.AUTHORIZATION_MAX_UNITS_ADJUSTED,
       CS.ACTIVE_FLAG,
       CS.CANCELLED_FLAG,
       CS.ETL_TASK_KEY,
       CS.ETL_INSERTED_TASK_KEY,
       CS.ETL_INSERTED_DATE,
       CS.ETL_INSERTED_BY,
       CS.ETL_LAST_UPDATED_DATE,
       CS.ETL_LAST_UPDATED_BY,
       CS.ETL_DELETED_FLAG
FROM HAH.FACT_CLIENT_SERVICE AS CS
    LEFT JOIN INTEGRATION.DIM_CLIENT_MERGED AS CM
        ON CM.ORIGINAL_CLIENT_KEY = CS.CLIENT_KEY;
RETURN ''SUCCESS'';
end;

 EOT
}

