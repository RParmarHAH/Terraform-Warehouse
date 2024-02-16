resource "snowflake_procedure" "DW_HAH_GET_STAGE_CLEARCARE_DIM_PARTNER" {
	name ="GET_STAGE_CLEARCARE_DIM_PARTNER"
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
-- NAME:  CLEARCARE_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER according to PARTNER 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 20/10/23     SAGAR GULGHANE         Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.CLEARCARE_DIM_PARTNER

SELECT DISTINCT
MD5(PCM.SYSTEM_CODE||''-''||PCM.PAYOR_ID||''-''||''CLEARCARE'') AS PARTNER_KEY
,MD5(PCM.SYSTEM_CODE||''-''||DPP.PARENT_PAYOR_ID||''-''||''CLEARCARE'') AS PARENT_PARTNER_KEY	,
DPP.PARENT_PAYOR_NAME AS PARENT_PARTNER_NAME,
''16'' AS SOURCE_SYSTEM_ID ,
''CLEARCARE'' AS SYSTEM_CODE,
DPP.PAYOR_NAME AS PARTNER_NAME,
PCM.PAYOR_ID AS PARTNER_CODE,
TRUE AS ACTIVE_FLAG,
	 TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS START_DATE,
	    TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS END_DATE
	, :STR_ETL_TASK_KEY AS ETL_TASK_KEY
	 	, :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
	    , Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE
		, CURRENT_USER AS ETL_INSERTED_BY
		, Convert_timezone(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE
		, CURRENT_USER AS ETL_LAST_UPDATED_BY
	 	, 0 AS ETL_DELETED_FLAG
		, 0 AS ETL_INFERRED_MEMBER_FLAG 
 FROM DISC_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_UI.PAYOR_CONTRACT_MAPPING PCM
   LEFT JOIN DISC_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_UI.PAYOR DPP
    ON PCM.PAYOR_ID = DPP.PAYOR_ID
    WHERE ORIGINAL_SOURCE_SYSTEM_ID=16;

return ''SUCCESS'';
END;

 EOT
}

