CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_DATAFLEXSYNCDATA_DIM_SUPERVISOR("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result varchar(1000);
BEGIN

--*****************************************************************************************************************************
-- NAME:  DataFlexSyncData_DIM_SUPERVISOR
--
-- PURPOSE: Creates one row per supervisor according to DataFlexSyncData
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 01/17/20     Greg Marsh           Initial development
-- 02/09/21		Mir Ali				 Added Dummy Supervisors for Bulk Billing (DfArInvoices)
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.DATAFLEXSYNCDATA_DIM_SUPERVISOR
WITH BULK_BILLING_SUPERVISORS AS (
    SELECT DISTINCT I.DBNAME,  
    	TRY_CAST(CONCAT(-100, I.OFFICE) AS INTEGER)::STRING AS DUMMY_SUPERVISOR_CODE,
    	MD5(I.DBNAME || ''-'' || DUMMY_SUPERVISOR_CODE || ''-'' || ''DATAFLEXSYNCDATA-DUMMY'') AS DUMMY_SUPERVISOR_KEY,
    	CONCAT(''BULK BILLING SPV for '', COALESCE(B.BRANCH_NAME, CONCAT(I.DBNAME, ''-Unknown''))) AS DUMMY_SUPERVISOR_NAME
    FROM DISC_PROD.DATAFLEXSYNCDATA.DFARINVOICES I
	LEFT JOIN HAH.DIM_BRANCH B ON B.SOURCE_SYSTEM_ID = 3 AND B.SYSTEM_CODE = I.DBNAME AND B.OFFICE_NUMBER = I.OFFICE 
)
	SELECT 
		md5(f.DbName || ''-''  || nvl(f.Code,''Unknown-'' || f.DbName) || ''-''  || ''DATAFLEXSYNCDATA'') AS SUPERVISOR_KEY, --PK
	    nvl(f.Code,''Unknown-'' || f.DbName) AS SUPERVISOR_CODE, --BK
		f.DbName AS SYSTEM_CODE, --BK
	    3 AS SOURCE_SYSTEM_ID, --BK
		f.Name AS SUPERVISOR_NAME,
		f.DbName AS SUPERVISOR_STATE_CODE,
		NULL SUPERVISOR_JOB_CODE,
		NULL SUPERVISOR_JOB_TITLE,
		TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
	    TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
   		-- ETL Fields
	    
       :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
       :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
 
	    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	    CURRENT_USER as ETL_INSERTED_BY ,
	    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	    CURRENT_USER as ETL_LAST_UPDATED_BY,
	    0 as ETL_DELETED_FLAG,
	    0 AS ETL_INFERRED_MEMBER_FLAG
	FROM DISC_PROD.DATAFLEXSYNCDATA.DfSupervisors f
	UNION ALL
	SELECT DUMMY_SUPERVISOR_KEY AS SUPERVISOR_KEY,
		DUMMY_SUPERVISOR_CODE AS SUPERVISOR_CODE,
		DBNAME AS SYSTEM_CODE,
		3 AS SOURCE_SYSTEM_ID,
		DUMMY_SUPERVISOR_NAME AS SUPERVISOR_NAME,
		DBNAME AS SUPERVISOR_STATE_CODE,
		NULL SUPERVISOR_JOB_CODE,
		NULL SUPERVISOR_JOB_TITLE,
		TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
	    TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
		-- ETL Fields
	    
        :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,

	    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	    CURRENT_USER as ETL_INSERTED_BY ,
	    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	    CURRENT_USER as ETL_LAST_UPDATED_BY,
	    0 as ETL_DELETED_FLAG,
	    0 AS ETL_INFERRED_MEMBER_FLAG
	FROM BULK_BILLING_SUPERVISORS;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
return return_result;
END;
';