CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_FACT_AREA_DEPRIVATION_INDEX("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- NAME:  Fact ADI
--
-- PURPOSE: Populates the fact area deprivation index table
--			
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 06/07/23    Ayshwarya             Initial version
--*****************************************************************************************************************************
INSERT OVERWRITE INTO FACT_AREA_DEPRIVATION_INDEX


SELECT  md5(  ''ADI''  ||  ''-''  ||a.ZIP_CODE ) AS AREA_DEPRIVATION_INDEX_KEY,
 2020,
''ADI'',
 33,
 a.ZIP_CODE,
 a.GISJOIN,
 a.FIPS,
 TRY_TO_NUMBER(a.ADI_NATRANK) AS ADI_NATRANK,
 TRY_TO_NUMBER(a.ADI_STATERANK) AS ADI_STATERANK,
 CASE WHEN a.ADI_NATRANK = ''PH'' THEN ''Low Population'' 
 WHEN a.ADI_NATRANK = ''GQ'' THEN ''High Group Quarters Population''
 WHEN a.ADI_NATRANK = ''PH-GQ'' THEN ''Low Population and High Group Quarters Population''
 WHEN a.ADI_NATRANK = ''NA'' THEN ''Not Available''
 WHEN a.ADI_NATRANK = ''QDI'' THEN ''QDI''
 END AS NATRANK_SUPRESSION_REASON,
 CASE WHEN a.ADI_STATERANK = ''PH'' THEN ''Low Population'' 
 WHEN a.ADI_STATERANK = ''GQ'' THEN ''High Group Quarters Population''
 WHEN a.ADI_STATERANK = ''GQ-PH'' THEN ''Low Population and High Group Quarters Population''
 WHEN a.ADI_STATERANK = ''NA'' THEN ''Not Available''
 WHEN a.ADI_STATERANK = ''QDI'' THEN ''QDI''
 END AS STATERANK_SUPRESSION_REASON, 
 CASE WHEN a.ZIP_TYPE = ''U'' THEN ''UNIQUE'' 
 WHEN a.ZIP_TYPE = ''P'' THEN ''POSTAL''
 ELSE ''STANDARD'' END,
 a.STATE_CODE,
-1 AS ETL_TASK_KEY,
-1 AS ETL_INSERTED_TASK_KEY,
 convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
 CURRENT_USER as ETL_INSERTED_BY ,
 convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
 CURRENT_USER as ETL_LAST_UPDATED_BY,
 0 as ETL_DELETED_FLAG	

FROM disc_prod.adi.AREA_DEPRIVATION_INDEX a;
	

return ''SUCCESS'';
END;
';