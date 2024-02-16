CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_CLEARCARE_FACT_INVOICE_TRANSACTIONS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN 
    MERGE INTO HAH.FACT_INVOICE_TRANSACTIONS TGT 
USING STAGE.CLEARCARE_FACT_INVOICE_TRANSACTIONS STAGE
ON 
TGT.TRANSACTION_KEY = STAGE.TRANSACTION_KEY
WHEN MATCHED THEN 
UPDATE SET 
	TGT.TRANSACTION_KEY =STAGE.TRANSACTION_KEY
	,TGT.TRANSACTION_NUMBER = STAGE.TRANSACTION_NUMBER
	,TGT.REVENUE_KEY = STAGE.REVENUE_KEY
	,TGT.VISIT_KEY = STAGE.VISIT_KEY
    ,TGT.TRANSACTION_TYPE_KEY = STAGE.TRANSACTION_TYPE_KEY
    ,TGT.AMOUNT = STAGE.AMOUNT
    ,TGT.TRANSACTION_CREATED = STAGE.TRANSACTION_CREATED
    ,TGT.TRANSACTION_POSTED = STAGE.TRANSACTION_POSTED
    ,TGT.TRANSACTION_DATE = STAGE.TRANSACTION_DATE
    ,TGT.FINAL_TRANSACTION_DATE = STAGE.FINAL_TRANSACTION_DATE
    ,TGT.CHECK_NUMBER = STAGE.CHECK_NUMBER
    ,TGT.CHECK_DATE = STAGE.CHECK_DATE
    ,TGT.DEPOSIT_DATE = STAGE.DEPOSIT_DATE
    ,TGT.POSTED_DATE = STAGE.POSTED_DATE
	,TGT.SYSTEM_CODE = STAGE.SYSTEM_CODE
	,TGT.SOURCE_SYSTEM_ID = STAGE.SOURCE_SYSTEM_ID
	,TGT.ETL_TASK_KEY = STAGE.ETL_TASK_KEY
	,TGT.ETL_INSERTED_TASK_KEY = STAGE.ETL_INSERTED_TASK_KEY
	,TGT.ETL_INSERTED_DATE = STAGE.ETL_INSERTED_DATE
	,TGT.ETL_INSERTED_BY = STAGE.ETL_INSERTED_BY
	,TGT.ETL_LAST_UPDATED_DATE = STAGE.ETL_LAST_UPDATED_DATE
	,TGT.ETL_LAST_UPDATED_BY = STAGE.ETL_LAST_UPDATED_BY  
	,TGT.ETL_DELETED_FLAG = STAGE.ETL_DELETED_FLAG
WHEN NOT MATCHED THEN 
INSERT ( 
        TRANSACTION_KEY
        ,TRANSACTION_NUMBER
		,REVENUE_KEY
		,VISIT_KEY
		,TRANSACTION_TYPE_KEY
		,AMOUNT
        ,TRANSACTION_CREATED
        ,TRANSACTION_POSTED
        ,TRANSACTION_DATE
        ,FINAL_TRANSACTION_DATE
        ,CHECK_NUMBER
        ,CHECK_DATE
        ,DEPOSIT_DATE
        ,POSTED_DATE
		,SYSTEM_CODE
		,SOURCE_SYSTEM_ID
		,ETL_TASK_KEY 
		,ETL_INSERTED_TASK_KEY 
		,ETL_INSERTED_DATE 
		,ETL_INSERTED_BY 
		,ETL_LAST_UPDATED_DATE 
	    ,ETL_LAST_UPDATED_BY
		,ETL_DELETED_FLAG	
) 
VALUES (
		STAGE.TRANSACTION_KEY
		,STAGE.TRANSACTION_NUMBER
		,STAGE.REVENUE_KEY
		,STAGE.VISIT_KEY
		,STAGE.TRANSACTION_TYPE_KEY
		,STAGE.AMOUNT
		,STAGE.TRANSACTION_CREATED
		,STAGE.TRANSACTION_POSTED
		,STAGE.TRANSACTION_DATE
		,STAGE.FINAL_TRANSACTION_DATE
		,STAGE.CHECK_NUMBER
		,STAGE.CHECK_DATE
		,STAGE.DEPOSIT_DATE
		,STAGE.POSTED_DATE
		,STAGE.SYSTEM_CODE
		,STAGE.SOURCE_SYSTEM_ID
		,STAGE.ETL_TASK_KEY 
		,STAGE.ETL_INSERTED_TASK_KEY 
		,STAGE.ETL_INSERTED_DATE 
		,STAGE.ETL_INSERTED_BY 
		,STAGE.ETL_LAST_UPDATED_DATE 
	    ,STAGE.ETL_LAST_UPDATED_BY
		,STAGE.ETL_DELETED_FLAG
);
SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Insrted & '' ,"number of rows updated",'' Rows Updated.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
end;
';