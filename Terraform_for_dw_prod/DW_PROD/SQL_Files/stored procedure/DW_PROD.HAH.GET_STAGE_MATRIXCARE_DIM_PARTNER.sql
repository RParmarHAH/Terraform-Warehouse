CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_MATRIXCARE_DIM_PARTNER("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
    --*****************************************************************************************************************************
-- NAME:  MATRIXCARE_DIM_PARTNER
--
-- PURPOSE: Creates one row per PARTNER according to MATRIXCARE 
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 04/04/23     RAJAT SAPKAL          Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.MATRIXCARE_DIM_PARTNER

SELECT MD5(''MATRIXCARE'' || ''-'' || P.PAY_ID || ''-'' || ''MATRIXCARE'') AS PARTNER_KEY,--taken PAY_ID because payer and partner are same.
    NULL  AS PARENT_PARTNER_KEY ,
    ''UNKNOWN'' AS PARENT_PARTNER_NAME,
	7 AS SOURCE_SYSTEM_ID,
	''MATRIXCARE'' AS SYSTEM_CODE,
	 IFNULL(P.PAY_NAME,''UNKNOWN'') AS PARTNER_NAME,
	 NVL(P.PAY_ID,-1) AS PARTNER_CODE,
	 PAY_ACTIVE AS ACTIVE_FLAG,
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
FROM DISC_PROD.MATRIXCARE.STVHC_T_PAYERS p;

return ''SUCCESS'';
END;
';