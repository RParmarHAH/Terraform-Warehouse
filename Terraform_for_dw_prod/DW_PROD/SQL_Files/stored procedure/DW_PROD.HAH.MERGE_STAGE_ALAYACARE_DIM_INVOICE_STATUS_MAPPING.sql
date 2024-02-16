CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_ALAYACARE_DIM_INVOICE_STATUS_MAPPING()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN 
    MERGE INTO DW_PROD.HAH.DIM_INVOICE_STATUS_MAPPING TGT 
USING DW_PROD.STAGE.ALAYACARE_DIM_INVOICE_STATUS_MAPPING STAGE 
ON TGT.INVOICE_STATUS_KEY = STAGE.INVOICE_STATUS_KEY
WHEN MATCHED THEN 
UPDATE SET 
	TGT.SOURCE_SYSTEM_ID = STAGE.SOURCE_SYSTEM_ID
	,TGT.SYSTEM_CODE = STAGE.SYSTEM_CODE
	,TGT.DERIVED_INVOICE_STATUS = STAGE.DERIVED_INVOICE_STATUS
	,TGT.INVOICE_STATUS_KEY = STAGE.INVOICE_STATUS_KEY
	,TGT.ETL_TASK_KEY = STAGE.ETL_TASK_KEY
	,TGT.ETL_INSERTED_TASK_KEY = STAGE.ETL_INSERTED_TASK_KEY
	,TGT.ETL_INSERTED_DATE = STAGE.ETL_INSERTED_DATE
	,TGT.ETL_INSERTED_BY = STAGE.ETL_INSERTED_BY
	,TGT.ETL_LAST_UPDATED_DATE = STAGE.ETL_LAST_UPDATED_DATE
	,TGT.ETL_LAST_UPDATED_BY = STAGE.ETL_LAST_UPDATED_BY  
WHEN NOT MATCHED THEN 
INSERT ( 
	SOURCE_SYSTEM_ID,
	SYSTEM_CODE,
	DERIVED_INVOICE_STATUS,
	INVOICE_STATUS_KEY,
	ETL_TASK_KEY,
	ETL_INSERTED_TASK_KEY,
	ETL_INSERTED_DATE,
	ETL_INSERTED_BY,
	ETL_LAST_UPDATED_DATE,
	ETL_LAST_UPDATED_BY
) 
VALUES (
	STAGE.SOURCE_SYSTEM_ID,
	STAGE.SYSTEM_CODE,
	STAGE.DERIVED_INVOICE_STATUS,
	STAGE.INVOICE_STATUS_KEY,
	STAGE.ETL_TASK_KEY,
	STAGE.ETL_INSERTED_TASK_KEY,
	STAGE.ETL_INSERTED_DATE,
	STAGE.ETL_INSERTED_BY,
	STAGE.ETL_LAST_UPDATED_DATE,
	STAGE.ETL_LAST_UPDATED_BY
);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Insrted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
end;
';