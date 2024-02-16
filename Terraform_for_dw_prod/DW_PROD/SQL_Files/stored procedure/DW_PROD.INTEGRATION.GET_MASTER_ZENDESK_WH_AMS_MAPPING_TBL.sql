CREATE OR REPLACE PROCEDURE DW_PROD.INTEGRATION.GET_MASTER_ZENDESK_WH_AMS_MAPPING_TBL("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN
--*****************************************************************************************************************************
-- NAME:  DIM_APPLICANT_JAZZHR
--
-- PURPOSE: Creates one row per DIM_APPLICANT from JAZZHR
--
-- DEVELOPMENT LOG:
-- DATE         AUTHOR                              NOTES:
-- ----------   -------------------------------     ---------------------------------------------------------------------------
-- 01/09/2022	  Manmohan Soni/Hasnain Motagamwala   Initial development
--*****************************************************************************************************************************
INSERT OVERWRITE INTO DW_PROD.INTEGRATION.ZENDESK_WH_AMS_MAPPING_TBL
with zendesk_clusters as (
	select * from DW_PROD.INTEGRATION.ZENDESK_AMS_MAPPING_OUTPUT
	where cluster_id in (select distinct cluster_id from DW_PROD.INTEGRATION.ZENDESK_AMS_MAPPING_OUTPUT where source_system_id = 999 and cluster_id IS NOT NULL)
)
--select * from zendesk_clusters ORDER BY cluster_id::int;
, zendesk_data as(
	select * from zendesk_clusters WHERE SOURCE_SYSTEM_ID = 999
)
--select * from zendesk_data ORDER BY cluster_id::int;
, WH_DATA as (
	select * from zendesk_clusters WHERE SOURCE_SYSTEM_ID <> 999
)
--select * from wh_data ORDER BY cluster_id::int;
-- , WH_NEW_RECORD AS (
	-- select * from (
    -- select row_number() over(partition by cluster_id order by EMPLOYEE_LAST_CHECK_DATE DESC NULLS LAST, EMPLOYEE_FIRST_CHECK_DATE DESC NULLS LAST, EMPLOYEE_LAST_WORKED_DATE DESC NULLS LAST, EMPLOYEE_HIRE_DATE DESC NULLS LAST) rn,*
    -- from WH_DATA
  -- ) WHERE RN = 1
-- )
-- select * from WH_NEW_RECORD ORDER BY cluster_id::int;
-- , WH_OLD_ID AS (
	-- select * from (
    -- select row_number() over(partition by cluster_id order by EMPLOYEE_LAST_CHECK_DATE ASC NULLS LAST, EMPLOYEE_FIRST_CHECK_DATE ASC NULLS LAST, EMPLOYEE_LAST_WORKED_DATE ASC NULLS LAST, EMPLOYEE_HIRE_DATE ASC NULLS LAST) rn,*
    -- from WH_DATA
  -- ) WHERE RN = 1
-- )
-- SELECT * FROM WH_OLD_ID ORDER BY CLUSTER_ID::INT;
-- , WH_RECORD as (
	-- SELECT 
		-- DISTINCT O.ID, N.EMPLOYEE_ID, N.SYSTEM_CODE, N.SOURCE_SYSTEM_ID, N.CLUSTER_ID
	-- FROM WH_DATA WH
	-- INNER JOIN WH_NEW_RECORD N ON WH.ID = N.ID AND WH.EMPLOYEE_ID = N.EMPLOYEE_ID
	-- INNER JOIN WH_OLD_ID O ON N.CLUSTER_ID = O.CLUSTER_ID
-- )
, WH_RECORD AS (
	select * from (
    select row_number() over(partition by cluster_id order by case when source_system_id in (5, 6, 10) then 1 else 2 end asc, EMPLOYEE_LAST_CHECK_DATE ASC NULLS LAST, EMPLOYEE_FIRST_CHECK_DATE ASC NULLS LAST, EMPLOYEE_LAST_WORKED_DATE ASC NULLS LAST, EMPLOYEE_HIRE_DATE ASC NULLS LAST) rn,*
    from WH_DATA
  ) WHERE RN = 1
)
-- SELECT * FROM WH_RECORD ORDER BY CLUSTER_ID::INT;
SELECT
	WH.ID AS WAREHOUSE_EMPLOYEE_KEY, 
	ZD.ID AS ZENDESK_ID,
	WH.SYSTEM_CODE AS WAREHOUSE_SYSTEM_CODE,
	ZD.SYSTEM_CODE AS ZENDESK_SYSTEM_CODE,
	WH.SOURCE_SYSTEM_ID AS WAREHOUSE_SOURCE_SYSTEM_ID,
	WH.EMPLOYEE_ID AS WAREHOUSE_EMPLOYEE_ID,
	ZD.EMPLOYEE_ID AS ZENDESK_EMPLOYEE_ID
FROM ZENDESK_DATA ZD INNER JOIN WH_RECORD WH ON ZD.CLUSTER_ID = WH.CLUSTER_ID;
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    ';