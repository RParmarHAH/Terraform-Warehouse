CREATE OR REPLACE PROCEDURE DW_PROD.HAH.MERGE_STAGE_DIM_SURVEY_RESPONSE_HEADER("SURVEY_ID" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
	RETURN_RESULT VARCHAR;
BEGIN

	MERGE INTO HAH.DIM_SURVEY_RESPONSE_HEADER DSRH
	USING (SELECT * FROM STAGE.DIM_SURVEY_RESPONSE_HEADER WHERE SURVEY_ID=:SURVEY_ID) STAGE
	ON DSRH.SURVEY_RESPONSE_HEADER_KEY = STAGE.SURVEY_RESPONSE_HEADER_KEY
	WHEN MATCHED THEN 
	UPDATE SET 
		DSRH.SURVEY_KEY=	STAGE.SURVEY_KEY,
		DSRH.SURVEY_ID=	STAGE.SURVEY_ID,
		DSRH.RECORD_ID= STAGE.RECORD_ID,
		DSRH.CLIENT_KEY=	STAGE.CLIENT_KEY,
		DSRH.WH_CLIENT_KEY=	STAGE.WH_CLIENT_KEY,
		DSRH.EMPLOYEE_KEY=	STAGE.EMPLOYEE_KEY,
		DSRH.WH_EMPLOYEE_KEY=	STAGE.WH_EMPLOYEE_KEY,
		DSRH.BRANCH_KEY=	STAGE.BRANCH_KEY,
		DSRH.PARTNER_KEY=	STAGE.PARTNER_KEY,
        DSRH.PARTNER_CONTRACT_KEY = STAGE.PARTNER_CONTRACT_KEY,
		DSRH.SOURCE_SYSTEM_ID=	STAGE.SOURCE_SYSTEM_ID,
		DSRH.SYSTEM_CODE=	STAGE.SYSTEM_CODE,
		DSRH.STATUS=	STAGE.STATUS,
		DSRH.PROGRESS=	STAGE.PROGRESS,
		DSRH.COMPLETED_FLAG=	STAGE.COMPLETED_FLAG,
		DSRH.RECORDED_DATE=	STAGE.RECORDED_DATE,
		DSRH.START_DATE=	STAGE.START_DATE,
		DSRH.END_DATE=	STAGE.END_DATE,
		DSRH.DURATION_IN_SECONDS=	STAGE.DURATION_IN_SECONDS,
		DSRH."LANGUAGE"=	STAGE."LANGUAGE",
		DSRH.LATITUDE=	STAGE.LATITUDE,
		DSRH.LONGITUDE=	STAGE.LONGITUDE,
		DSRH.IP_ADDRESS=	STAGE.IP_ADDRESS,
		DSRH.EXTERNAL_REFERENCE=	STAGE.EXTERNAL_REFERENCE,
		DSRH.DISTRIBUTION_CHANNEL=	STAGE.DISTRIBUTION_CHANNEL,
        DSRH.BATCH_NUMBER= STAGE.BATCH_NUMBER,
		DSRH.ETL_TASK_KEY=	STAGE.ETL_TASK_KEY,
		DSRH.ETL_INSERTED_TASK_KEY=	STAGE.ETL_INSERTED_TASK_KEY,
		DSRH.ETL_LAST_UPDATED_DATE=	STAGE.ETL_LAST_UPDATED_DATE,
		DSRH.ETL_LAST_UPDATED_BY=	STAGE.ETL_LAST_UPDATED_BY,
		DSRH.ETL_DELETED_FLAG=	STAGE.ETL_DELETED_FLAG
	WHEN NOT MATCHED THEN 
	INSERT ( 
	    SURVEY_RESPONSE_HEADER_KEY,
		SURVEY_KEY,
		SURVEY_ID,
		RECORD_ID,
		CLIENT_KEY,
		WH_CLIENT_KEY,
		EMPLOYEE_KEY,
		WH_EMPLOYEE_KEY,
		BRANCH_KEY,
		PARTNER_KEY,
        PARTNER_CONTRACT_KEY,
		SOURCE_SYSTEM_ID,
		SYSTEM_CODE,
		STATUS,
		PROGRESS,
		COMPLETED_FLAG,
		RECORDED_DATE,
		START_DATE,
		END_DATE,
		DURATION_IN_SECONDS,
		"LANGUAGE",
		LATITUDE,
		LONGITUDE,
		IP_ADDRESS,
		EXTERNAL_REFERENCE,
		DISTRIBUTION_CHANNEL,
        BATCH_NUMBER,
		ETL_TASK_KEY,
		ETL_INSERTED_TASK_KEY,
		ETL_INSERTED_DATE,
		ETL_INSERTED_BY,
		ETL_LAST_UPDATED_DATE,
		ETL_LAST_UPDATED_BY,
		ETL_DELETED_FLAG
	) 
	VALUES (
		STAGE.SURVEY_RESPONSE_HEADER_KEY,
		STAGE.SURVEY_KEY,
		STAGE.SURVEY_ID,
		STAGE.RECORD_ID,
		STAGE.CLIENT_KEY,
		STAGE.WH_CLIENT_KEY,
		STAGE.EMPLOYEE_KEY,
		STAGE.WH_EMPLOYEE_KEY,
		STAGE.BRANCH_KEY,
		STAGE.PARTNER_KEY,
        STAGE.PARTNER_CONTRACT_KEY,
		STAGE.SOURCE_SYSTEM_ID,
		STAGE.SYSTEM_CODE,
		STAGE.STATUS,
		STAGE.PROGRESS,
		STAGE.COMPLETED_FLAG,
		STAGE.RECORDED_DATE,
		STAGE.START_DATE,
		STAGE.END_DATE,
		STAGE.DURATION_IN_SECONDS,
		STAGE."LANGUAGE",
		STAGE.LATITUDE,
		STAGE.LONGITUDE,
		STAGE.IP_ADDRESS,
		STAGE.EXTERNAL_REFERENCE,
		STAGE.DISTRIBUTION_CHANNEL,
        STAGE.BATCH_NUMBER,
		STAGE.ETL_TASK_KEY,
		STAGE.ETL_INSERTED_TASK_KEY,
		STAGE.ETL_INSERTED_DATE,
		STAGE.ETL_INSERTED_BY,
		STAGE.ETL_LAST_UPDATED_DATE,
		STAGE.ETL_LAST_UPDATED_BY,
		STAGE.ETL_DELETED_FLAG
	);
	

	SELECT CONCAT(''Message : '',"number of rows inserted", '' Rows Inserted & '' ,"number of rows updated",'' Rows Updated.'') into :RETURN_RESULT FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return RETURN_RESULT;
	
END;
';