CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_MATRIXCARE_DIM_ACTIVITIES("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
                BEGIN
    --*****************************************************************************************************************************
-- NAME:  MATRIXCARE_DIM_ACTIVITIES
--
-- PURPOSE: 
--
-- DEVELOPMENT LOG:
-- DATE         AUTHOR              NOTES:
-- --------     ------------------- -----------------------------------------------------------------------------------------------
-- 10/25/2023   Trushali Ramoliya    Initial 
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO DW_PROD.STAGE.MATRIXCARE_DIM_ACTIVITIES
SELECT DISTINCT 
 MD5( ''MATRIXCARE'' || ''-'' || TT.ACTTYPE_ID || ''-'' || ''MATRIXCARE'') AS ACTIVITY_KEY,
 7 AS SOURCE_SYSTEM_ID,
 ''MATRIXCARE'' AS SYSTEM_CODE,
 TT.ACTTYPE_NAME AS ACTIVITY_NAME,
  :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
         :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,                            
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
	CURRENT_USER as ETL_INSERTED_BY,
	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
	CURRENT_USER as ETL_LAST_UPDATED_BY,
	0 as ETL_DELETED_FLAG,
	0 AS ETL_INFERRED_MEMBER_FLAG
FROM  DISC_PROD.MATRIXCARE.STVHC_T_ACTIVITYTYPES tt
WHERE TT.ACTTYPE_ID IN (''10165'',
''10166'',
''10167'',
''10168'',
''10169'',
''10170'');
;
 RETURN ''SUCCESS'';
    END;
    ';