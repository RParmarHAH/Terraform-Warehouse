CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_ALLIANCE_DIM_SERVICES("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN
--*****************************************************************************************************************************
-- NAME:  ALLIANCE DIM SERVICES
--
-- PURPOSE: Populates Stage DIM SERVICES  for ALLIANCE
--
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 11/07/23    Shraddha Sejpal       Initial version
--*****************************************************************************************************************************
INSERT OVERWRITE INTO STAGE.ALLIANCE_DIM_SERVICES

SELECT MD5(''ALLIANCE'' || ''-'' || SR.SERVICECODE ||  ''-'' || ''ALLIANCE'') AS SERVICE_KEY,
       ''19'' AS SOURCE_SYSTEM_ID,
       ''ALLIANCE'' AS SYSTEM_CODE,
       SR.SERVICECODE AS SERVICE_CODE,
       SR.DESCRIPTION AS SERVICE_DESCRIPTION,
       SR.SHORTDESCRIPTION AS SERVICE_TYPE,
       CASE WHEN SR.FLATRATE =TRUE THEN ''Visit'' 
       		WHEN SR.FLATRATE =FALSE THEN ''Hourly'' ELSE NULL 
       END AS SERVICE_RATE_TYPE,
       ''HC'' AS REVENUE_CATEGORY,
       ''HC'' AS REVENUE_SUBCATEGORY_CODE,
       ''HOME CARE'' AS REVENUE_SUBCATEGORY_NAME,
    	TRUE AS ACTIVE_FLAG,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_INSERTED_DATE,
        CURRENT_USER as ETL_INSERTED_BY,
        convert_timezone(''UTC'', CURRENT_TIMESTAMP) :: timestamp_ntz as ETL_UPDATED_DATE,
        CURRENT_USER as ETL_LAST_UPDATED_BY,
        0 as ETL_DELETED_FLAG
FROM DISC_PROD.GENERATIONSALLIANCE.SERVICES SR;
return ''SUCCESS'';
END;
';