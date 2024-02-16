resource "snowflake_procedure" "DW_REPORT_GET_REPORT_CLIENT_COUNT" {
	name ="GET_REPORT_CLIENT_COUNT"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN
        --*****************************************************************************************************************************
-- NAME:  CLIENT_COUNT
--
-- PURPOSE: Creates a report table for the ops performance dashboard that handles different client counts at the supervisor levvel

-- 04/02/20    Rachel Stewart     Added Flower box, removed the Dataflex specific filters
-- 04/20/20    Rachel Stewart     Added date filter for > 2020
--*****************************************************************************************************************************
--- CREATE OR REPLACE TABLE REPORT.CLIENT_COUNT
INSERT OVERWRITE INTO REPORT.CLIENT_COUNT

WITH LOST AS(SELECT
contract_key,supervisor_key,branch_key,ADD_MONTHS(DATE_TRUNC(''month'',REPORT_DATE),1) AS REPORT_DATE,
count(1) as lostclientcount
FROM
(SELECT DISTINCT YEAR,Month FROM HAH.DIM_DATE) date
inner join
(
    select distinct visit.client_key,visit.contract_key,visit.supervisor_key,visit.service_date,visit.BRANCH_KEY,REPORT_DATE
    from
    hah.fact_visit visit
    inner join
    (
      select client_key,
      visit_key,
      row_number() over (partition by client_key order by service_date desc) LastServiceRecord
      from hah.fact_visit
      where year(service_date) in (2018,2019,2020)
    ) latestdata
    on latestdata.visit_key = visit.visit_key
    and lastservicerecord = 1
)LostClientCount
on date_part(month,(dateadd(month,1,LostClientCount.service_date))) = MONTH
and date_part(year,(dateadd(month,1,LostClientCount.service_date))) = YEAR
group by contract_key,supervisor_key,branch_key,DATE_TRUNC(''month'',REPORT_DATE)
order by REPORT_DATE DESC
),
 VISIT AS (
  SELECT
     V.BRANCH_KEY
    ,V.SUPERVISOR_KEY
    ,V.CONTRACT_KEY
    ,DATE_TRUNC(''month'',V.REPORT_DATE) AS REPORT_DATE
    ,ADD_MONTHS(DATE_TRUNC(''month'',V.REPORT_DATE),-1) AS LAST_MONTH
    ,(IFF(C.CLIENT_CONVERTED_FLAG = 1,COUNT (DISTINCT V.CLIENT_KEY), 0)) AS CONVERTED_CLIENT
    , COUNT (DISTINCT V.CLIENT_NUMBER) AS CLIENTS
    ,IFF(DATE_TRUNC(''month'',C.FIRST_SERVICE_DATE) = DATE_TRUNC(''month'',V.REPORT_DATE), 1,0) AS NEW_CLIENT
    ,IFF(DATE_TRUNC(''month'',C.REFERRAL_DATE) = DATE_TRUNC(''month'',V.REPORT_DATE), 1,0) AS REFERRED_LAST_MONTH
    ,IFF((DATE_TRUNC(''month'',C.REFERRAL_DATE) = DATE_TRUNC(''month'',V.REPORT_DATE)) AND (DATE_TRUNC(''month'',C.FIRST_SERVICE_DATE) = DATE_TRUNC(''month'',V.REPORT_DATE)),1,0) AS CONVERTED_LAST_MONTH
    FROM HAH.FACT_VISIT V
    INNER JOIN HAH.DIM_CLIENT C ON V.CLIENT_KEY = C.CLIENT_KEY
    INNER JOIN HAH.DIM_DATE D ON DATE_TRUNC(''month'',C.LAST_SERVICE_DATE) = ADD_MONTHS(DATE_TRUNC(''month'',D.CALENDAR_DATE),1)
    INNER JOIN HAH.DIM_CONTRACT CON ON V.CONTRACT_KEY = CON.CONTRACT_KEY
    INNER JOIN HAH.DIM_SUPERVISOR S ON V.SUPERVISOR_KEY = S.SUPERVISOR_KEY
  WHERE NVL(REVENUE_CATEGORY, '''') <> ''CLS'' AND YEAR BETWEEN 2018 AND 2020 AND ((V.SOURCE_SYSTEM_ID = 3 AND CON.BILLABLE_FLAG = 1 AND CON.PAYABLE_FLAG =1 AND (IFNULL(CON.MILEAGE_FLAG,0)=0)) OR V.SOURCE_SYSTEM_ID = 4)
 GROUP BY
 V.BRANCH_KEY
 ,V.SUPERVISOR_KEY
 ,V.CONTRACT_KEY
 ,DATE_TRUNC(''month'',V.REPORT_DATE)
,ADD_MONTHS(DATE_TRUNC(''month'',V.REPORT_DATE),-1)
 ,C.CLIENT_CONVERTED_FLAG  ,V.CLIENT_NUMBER
 ,C.FIRST_SERVICE_DATE
  ,C.LAST_SERVICE_DATE
  ,C.REFERRAL_DATE
),FINAL AS(
 SELECT
CON.CONTRACT_KEY
,CON.SUPERVISOR_KEY
,CON.REPORT_DATE
,CON.BRANCH_KEY
,CON.LAST_MONTH
,lostclientcount AS LOST_CLIENT
,SUM (CLIENTS ) AS CLIENT_COUNT
,SUM(NEW_CLIENT) AS NEW_CLIENTS
,SUM(CONVERTED_CLIENT) AS CONVERTED_CLIENT
,SUM(REFERRED_LAST_MONTH) AS REFERRED_LAST_MONTH
,SUM(CONVERTED_LAST_MONTH) AS CONVERTED_LAST_MONTH
--,SUM(NEW_CLIENT) - SUM(LOST_CLIENT)  AS NET_CHANGE_CLIENTS
FROM VISIT CON
FULL OUTER JOIN LOST L ON L.SUPERVISOR_KEY = CON.SUPERVISOR_KEY AND L.BRANCH_KEY =CON.BRANCH_KEY AND L.CONTRACT_KEY = CON.CONTRACT_KEY AND L.REPORT_DATE = CON.REPORT_DATE
GROUP BY
CON.CONTRACT_KEY
,CON.SUPERVISOR_KEY
,CON.REPORT_DATE
,CON.LAST_MONTH
,CON.BRANCH_KEY
,LOST_CLIENT)
SELECT
CONTRACT_KEY
,BRANCH_KEY
,SUPERVISOR_KEY
,REPORT_DATE
,LAST_MONTH
,SUM (CLIENT_COUNT) OVER (PARTITION BY SUPERVISOR_KEY,REPORT_DATE) AS CLIENT_COUNT
,LOST_CLIENT
,NEW_CLIENTS
,CONVERTED_CLIENT
,REFERRED_LAST_MONTH
,CONVERTED_LAST_MONTH,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
CURRENT_USER as ETL_INSERTED_BY ,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
CURRENT_USER as ETL_LAST_UPDATED_BY,
0 as ETL_DELETED_FLAG,
0 AS ETL_INFERRED_MEMBER_FLAG
FROM FINAL
WHERE REPORT_DATE >= ''2020-01-01'';

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

