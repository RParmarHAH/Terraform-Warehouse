CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_CCSI_DIM_SUPERVISOR("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
        var sql = `
        --******************************************************************************************************************************************
-- NAME:  CCSI_DIM_SUPERVISOR
--
-- PURPOSE: Creates one row per supervisor according to CCSI
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -------------------------------------------------------------------------------------------------------        
-- 09/01/21    Shraddha Sejpal		 Initial development
--******************************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.CCSI_DIM_SUPERVISOR
SELECT DISTINCT
		md5(DI.AREA ||''-''|| nvl(DI.SUPERVISOR_INITIAL,''Unknown'') ||''-''|| ''CCSI'') AS SUPERVISOR_KEY, --PK
 	 	NVL(DI.SUPERVISOR_INITIAL,'' '') AS SUPERVISOR_CODE, 
		''CCSI'' AS SYSTEM_CODE, 
		8 AS SOURCE_SYSTEM_ID, 
		DI.SUPERVISOR_NAME AS SUPERVISOR_NAME,
		B.OFFICE_STATE_CODE,
		NULL SUPERVISOR_JOB_CODE,
		NULL SUPERVISOR_JOB_TITLE,
		TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE,
	    TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE,
   		-- ETL Fields
	    
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_TASK_KEY,
        
	    
        `;    
             sql += STR_ETL_TASK_KEY;
             sql +=  
             ` AS ETL_INSERTED_TASK_KEY,
        
	    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	    CURRENT_USER as ETL_INSERTED_BY ,
	    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	    CURRENT_USER as ETL_LAST_UPDATED_BY,
	    0 as ETL_DELETED_FLAG,
	    0 AS ETL_INFERRED_MEMBER_FLAG
	FROM DISC_PROD.CCSI.DESKINFO DI
	LEFT JOIN STAGE.CCSI_DIM_BRANCH B ON TRIM(DI.AREA) = TRIM(B.OFFICE_CODE) AND B.SOURCE_SYSTEM_ID =8
	WHERE DI.ETL_LAST_UPDATED_DATE >= ''`; 
sql += STR_CDC_START
sql += `''::timestamp_ntz;`;
          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          ';