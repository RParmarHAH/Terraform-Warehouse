resource "snowflake_procedure" "DISC_PAYOR_CONTRACT_UI_GET_PAYOR_CONTRACT_MAPPING_BKP_08JUN23" {
	name ="GET_PAYOR_CONTRACT_MAPPING_BKP_08JUN23"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PAYOR_CONTRACT_UI"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

--*****************************************************************************************************************************
-- NAME:  LOAD_PAYOR_CONTRACT_MAPPING_BKP_08JUN23 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- ----------  -------------------   -----------------------------------------------------------------------------------------------
-- 2023-11-20 KOMAL DHOKAI            INITIAL DEVELOPMENT
--*****************************************************************************************************************************

DECLARE
    RETURN_RESULT VARCHAR;
BEGIN
MERGE INTO DISC_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_UI.PAYOR_CONTRACT_MAPPING TGT 
USING APP_DB_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_MAPPING.PAYOR_CONTRACT_MAPPING STAGE 
	ON TGT.PAYOR_ID = STAGE.PAYOR_ID 
	AND TGT.ORIGINAL_SOURCE_SYSTEM_ID = STAGE.SOURCE_SYSTEM_ID
	AND TGT.ORIGINAL_SYSTEM_CODE = STAGE.SYSTEM_CODE
	AND TGT.CONTRACT_CODE = STAGE.CONTRACT_CODE
    AND TGT.CONTRACT_NAME = STAGE.CONTRACT_NAME
WHEN MATCHED THEN 
UPDATE SET 
     TGT.PAYOR_NAME = STAGE.PAYOR_NAME
	,TGT.SOURCE_SYSTEM_ID = ''28''
	,TGT.SYSTEM_CODE = ''Payor_Contract UI''
    ,TGT.ORIGINAL_SOURCE_SYSTEM_ID = STAGE.SOURCE_SYSTEM_ID
	,TGT.ORIGINAL_SYSTEM_CODE = STAGE.SYSTEM_CODE
	,TGT.ORIGINAL_SOURCE_SYSTEM_NAME = STAGE.SOURCE_SYSTEM_NAME
	,TGT.CONTRACT_CODE = STAGE.CONTRACT_CODE
	,TGT.CONTRACT_NAME = STAGE.CONTRACT_NAME
	,TGT.ETL_TASK_KEY = :STR_ETL_TASK_KEY
	,TGT.ETL_LAST_UPDATED_DATE = CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ 
	,TGT.ETL_LAST_UPDATED_BY = CURRENT_USER
WHEN NOT MATCHED THEN 
INSERT 
	(PAYOR_ID
    ,PAYOR_NAME
	,SOURCE_SYSTEM_ID
	,SYSTEM_CODE
    ,ORIGINAL_SOURCE_SYSTEM_ID
    ,ORIGINAL_SYSTEM_CODE
    ,ORIGINAL_SOURCE_SYSTEM_NAME
	,CONTRACT_CODE
	,CONTRACT_NAME
	,ETL_TASK_KEY
	,ETL_INSERTED_TASK_KEY
	,ETL_INSERTED_DATE
	,ETL_INSERTED_BY
	,ETL_LAST_UPDATED_DATE
	,ETL_LAST_UPDATED_BY
    )
VALUES 
	(STAGE.PAYOR_ID
    ,STAGE.PAYOR_NAME
    ,''28''
    ,''Payor_Contract UI''
    ,STAGE.SOURCE_SYSTEM_ID
    ,STAGE.SYSTEM_CODE
	,STAGE.SOURCE_SYSTEM_NAME
    ,STAGE.CONTRACT_CODE
	,STAGE.CONTRACT_NAME
	,:STR_ETL_TASK_KEY  
	,:STR_ETL_TASK_KEY  
	,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ 
	,CURRENT_USER
	,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ 
	,CURRENT_USER
    )
;
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Inserted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

