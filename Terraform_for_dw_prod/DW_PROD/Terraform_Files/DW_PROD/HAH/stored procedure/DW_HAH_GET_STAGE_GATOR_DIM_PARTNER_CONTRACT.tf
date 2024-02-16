resource "snowflake_procedure" "DW_HAH_GET_STAGE_GATOR_DIM_PARTNER_CONTRACT" {
	name ="GET_STAGE_GATOR_DIM_PARTNER_CONTRACT"
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
-- NAME:  GATOR_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER according to Gator.
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 12/27/23    Meet Hariyani         Initial development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_${var.SF_ENVIRONMENT}.STAGE.GATOR_DIM_PARTNER_CONTRACT
SELECT DISTINCT MD5(DP.PARTNER_CODE  || ''-'' || CP.SL_EXTERNAL_ID__C || ''-'' || DP.PARTNER_CODE) AS PARTNER_CONTRACT_KEY
				, DP.SOURCE_SYSTEM_ID
				, DP.SYSTEM_CODE		
				, DP.PARTNER_KEY
				, DP.PARTNER_CODE
				, DP.PARTNER_NAME
				, CP.SL_EXTERNAL_ID__C AS CONTRACT_CODE
				, CP.NAME AS CONTRACT_NAME
				, NOT(NVL(CP.ISDELETED, FALSE)) AS ACTIVE_FLAG
				, CP.STARTDATE AS START_DATE
				, CP.ENDDATE AS END_DATE 
				, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
			 	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
			      , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
				, CURRENT_USER AS ETL_INSERTED_BY
				, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
				, CURRENT_USER AS ETL_LAST_UPDATED_BY
			 	, 0 AS ETL_DELETED_FLAG
FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_PARTNER DP
INNER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_PARTNER_PROGRAM_MAPPING MAPPING
	ON MAPPING.PARTNER_CODE = DP.PARTNER_CODE AND MAPPING.PARTNER_NAME = DP.PARTNER_NAME
LEFT JOIN DISC_${var.SF_ENVIRONMENT}.HEALTH_NAVIGATOR.CAREPROGRAM CP
	ON MAPPING.PROGRAM_CODE = CP.SL_EXTERNAL_ID__C
WHERE DP.SYSTEM_CODE = ''GATOR''
AND MAPPING.IS_ACTIVE ;
RETURN ''SUCCESS'';
END
 EOT
}

