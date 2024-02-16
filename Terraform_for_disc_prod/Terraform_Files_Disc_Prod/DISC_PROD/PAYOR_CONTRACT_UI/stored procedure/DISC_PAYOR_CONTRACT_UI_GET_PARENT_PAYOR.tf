resource "snowflake_procedure" "DISC_PAYOR_CONTRACT_UI_GET_PARENT_PAYOR" {
	name ="GET_PARENT_PAYOR"
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
-- NAME:  LOAD_PARENT_PAYOR 
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
MERGE INTO DISC_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_UI.PARENT_PAYOR TGT 
USING APP_DB_${var.SF_ENVIRONMENT}.PAYOR_CONTRACT_MAPPING.PARENT_PAYOR STAGE 
ON TGT.PARENT_PAYOR_ID = STAGE.PARENT_PAYOR_ID 
WHEN MATCHED THEN 
UPDATE SET 
	 TGT.PARENT_PAYOR_NAME = STAGE.PARENT_PAYOR_NAME
	,TGT.NOTES = STAGE.NOTES
	,TGT.ETL_TASK_KEY = :STR_ETL_TASK_KEY
	,TGT.ETL_LAST_UPDATED_DATE = CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ 
	,TGT.ETL_LAST_UPDATED_BY = CURRENT_USER
WHEN NOT MATCHED THEN 
INSERT 
	(PARENT_PAYOR_ID
	,PARENT_PAYOR_NAME
    ,NOTES
	,ETL_TASK_KEY
	,ETL_INSERTED_TASK_KEY
	,ETL_INSERTED_DATE
	,ETL_INSERTED_BY
	,ETL_LAST_UPDATED_DATE
	,ETL_LAST_UPDATED_BY
	)
VALUES 
	(STAGE.PARENT_PAYOR_ID
	,STAGE.PARENT_PAYOR_NAME
    ,STAGE.NOTES 
	,:STR_ETL_TASK_KEY  
	,:STR_ETL_TASK_KEY  
	,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ 
	,CURRENT_USER
	,CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ 
	,CURRENT_USER 
	)
;
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Insrted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;

 EOT
}

