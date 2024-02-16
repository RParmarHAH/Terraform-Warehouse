CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_DATAFLEXSYNCDATA_DIM_CONTRACT("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME:  DataFlexSyncData_DIM_CONTRACT
--
-- PURPOSE: Creates one row per contract according to DataFlex
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 01/06/20     Greg Marsh         	Initial development
-- 03/26/20    	Rachel Stewart     	Added Payable, Millage and Billable flags
-- 04/01/20	  	Mohd Kamaludin		Added CDC
-- 04/14/20   	Rachel Stewart		Updated Service Line per Mir''''s suggestion
-- 05/14/20		Arif Ansari			Populate REVENUE_SUBCATEGORY_CODE, REVENUE_SUBCATEGORY_NAME, PAY_TRAVELS_CODE, BILLED_BY_QUARTER_HOURS, BILLED_BY_HALF_HOURS
-- 06/30/20		Mir Ali				Added default non-mileage, payable, and billable flags
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.DataFlexSyncData_DIM_CONTRACT
with sl as (
    select ContractCode, DbName, max(SERVICE_LINE_CODE) as SERVICE_LINE_CODE
    from (
             SELECT DISTINCT ContractCode,
                             DbName,
                             CASE
                             WHEN ContractName LIKE''%TEST%''THEN''DT''
                             WHEN ContractName LIKE''%DCFS%''OR ContractName LIKE''%DCS%'' THEN ''DC''
                             ELSE NVL(RevenueCategory, ''HC'')
                             END as SERVICE_LINE_CODE
             FROM DISC_PROD.DATAFLEXSYNCDATA.DFCONTRACTS F
         ) t
    group by 1,2
)
SELECT
	md5(F.DBNAME || ''-'' || F.ContractCode || ''-''  ||  ''DATAFLEXSYNCDATA'') AS CONTRACT_KEY --PK
    ,F.ContractCode AS CONTRACT_CODE --BK
    ,F.DBNAME AS SYSTEM_CODE --BK
    ,3 AS SOURCE_SYSTEM_ID --BK
	,F.ContractName AS CONTRACT_NAME
    ,NULL AS SERVICE_CODE_ID
	,NULL AS SERVICE_KEY
	,F.DEFAULTBILLCODE AS DEFAULT_BILL_CODE
    ,F.PAYROLLCODE AS PAYROLL_CODE
    ,F.REVENUECATEGORY AS REVENUE_CATEGORY
	,F.RevenueSubCategory AS REVENUE_SUBCATEGORY_CODE
	,DFREVSUBCAT.NAME AS REVENUE_SUBCATEGORY_NAME
    ,SERVICE_LINE_CODE AS PAYOR_CODE
    ,CASE WHEN SERVICE_LINE_CODE = ''BH'' THEN ''BH - Behavior Health/DD''
          WHEN SERVICE_LINE_CODE = ''HC'' THEN ''HC - Home Care''
          WHEN SERVICE_LINE_CODE = ''HH'' THEN ''HH - Home Health''
          WHEN SERVICE_LINE_CODE = ''SK'' THEN ''SK - Skilled ''
          WHEN SERVICE_LINE_CODE = ''DC'' THEN ''DC - DCFS''
          WHEN SERVICE_LINE_CODE = ''DT'' THEN ''DT - Drug Testing''
          WHEN SERVICE_LINE_CODE = ''CLS'' THEN ''CLS - Community Living''
        ELSE ''NA'' END AS PAYOR_DESCRIPTION
    ,SERVICE_LINE_CODE  AS SERVICE_LINE_CODE
    ,CASE WHEN SERVICE_LINE_CODE = ''BH'' THEN ''BH - Behavior Health/DD''
          WHEN SERVICE_LINE_CODE = ''HC'' THEN ''HC - Home Care''
          WHEN SERVICE_LINE_CODE = ''HH'' THEN ''HH - Home Health''
          WHEN SERVICE_LINE_CODE = ''SK'' THEN ''SK - Skilled ''
          WHEN SERVICE_LINE_CODE = ''DC'' THEN ''DC - DCFS''
          WHEN SERVICE_LINE_CODE = ''DT'' THEN ''DT - Drug Testing''
          WHEN SERVICE_LINE_CODE = ''CLS'' THEN ''CLS - Community Living''
        ELSE ''NA'' END AS SERVICE_LINE_DESCRIPTION
	,F.DBNAME AS CONTRACT_STATE_CODE
	, CASE WHEN BILLBYHALFHOURS = ''TRUE'' THEN ''.5HR''
           WHEN BILLEDBYQUARTERHOURS = ''TRUE'' THEN ''.25HR''
           ELSE ''1HR'' END AS TIME_TRANSLATION_CODE
	,CASE WHEN TIME_TRANSLATION_CODE = ''.5HR'' THEN 2
          WHEN TIME_TRANSLATION_CODE =  ''.25HR'' THEN 4
          ELSE 1 END AS TIME_TRANSLATION_DIVIDER
	,F.PAYTRAVELSCODE AS PAY_TRAVELS_CODE         
    ,COALESCE(F.ISMILEAGE, FALSE) AS MILEAGE_FLAG
    ,F.PAYABLE AS PAYABLE_FLAG
    ,F.BILLABLE AS BILLABLE_FLAG
	,F.BILLEDBYQUARTERHOURS AS BILLED_BY_QUARTER_HOURS
	,F.BILLBYHALFHOURS AS BILLED_BY_HALF_HOURS
    ,TO_DATE(''1900-01-01'', ''YYYY-MM-DD'') AS EFFECTIVE_FROM_DATE
    ,TO_DATE(''9999-12-31'', ''YYYY-MM-DD'') AS EFFECTIVE_TO_DATE
    ,
    ---- ETL FIELDS ----
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 AS ETL_INFERRED_MEMBER_FLAG
FROM DISC_PROD.DATAFLEXSYNCDATA.DFCONTRACTS F
left join sl sl
    on f.CONTRACTCODE = sl.CONTRACTCODE
    and f.DbName = sl.DbName
LEFT JOIN DISC_PROD.DATAFLEXSYNCDATA.DFREVENUESUBCATEGORIES AS DFREVSUBCAT
	ON F.REVENUESUBCATEGORY = DFREVSUBCAT.CODE
	AND F.DBNAME = DFREVSUBCAT.DBNAME
WHERE F.ETL_LAST_UPDATED_DATE >= :STR_CDC_START::timestamp_ntz
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    ';