resource "snowflake_procedure" "DW_REPORT_GET_REPORT_CLIENT_DERIVED_MONTHLY_VISIT_METRICS_SEC" {
	name ="GET_REPORT_CLIENT_DERIVED_MONTHLY_VISIT_METRICS_SEC"
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

    Insert overwrite into Report.Client_Derived_Monthly_Visit_Metrics_SEC 
WITH Calendar_Months AS  -- get calendar months for months we have service/visit data
(
	SELECT DATE_TRUNC( MONTH, CALENDAR_DATE) AS Calendar_Month
    FROM HAH.DIM_DATE
    WHERE CALENDAR_DATE BETWEEN CAST( ''1995-01-01'' AS DATE) AND DATEADD( ''MONTH'', 1, CURRENT_DATE())
	GROUP BY 1
),
Altrus_Revenue_Clients AS
(
    SELECT x.Client_Key,
           x.Revenue_Month,
           COUNT( DISTINCT rev.Invoice_Key) AS Invoice_Count
    FROM
    (  
    SELECT r.Client_Key,
           DATE_TRUNC( ''MONTH'', r.Report_Date) AS Revenue_Month
--           COUNT( DISTINCT r.Invoice_Key) AS Invoice_Count
    FROM INTEGRATION.FACT_REVENUE_MERGED R
    INNER JOIN HAH.DIM_Contract AS cntrct ON r.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND cntrct.Revenue_Category = ''CLS'' AND cntrct.Revenue_Subcategory_Code = ''RES''  AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' AND UPPER( cntrct.Contract_Name) IN ( ''INDEPENDENT CARE WAIVER PROGRA'', ''MR COMP WAIVER'')
    WHERE R.ORIGINAL_SOURCE_SYSTEM_ID = 1 
    AND r.Report_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)    
--    AND  r.Report_Date BETWEEN ''2020-12-01'' AND ''2020-12-31''
--    AND R.BILL_CODE IN (''ALG'', ''ALP'',''ALS'',''BSC'',''BSS'',''CAG'',''CAI'',''HB'',''HBG'',''ICWP'',''ICWP-HB'',''IWCP-LB'',''LB'',''LBG'',''MRWP'',''PC1'')
    UNION
    SELECT r.Client_Key,
           DATE_TRUNC( ''MONTH'', r.Report_Date) AS Revenue_Month
    FROM INTEGRATION.FACT_REVENUE_MERGED R
    INNER JOIN HAH.DIM_Contract AS cntrct ON r.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND cntrct.Revenue_Category = ''CLS'' AND cntrct.Revenue_Subcategory_Code = ''RES''  AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' -- AND UPPER( cntrct.Contract_Name) IN ( ''INDEPENDENT CARE WAIVER PROGRA'', ''MR COMP WAIVER'')
    INNER JOIN HAH.DIM_Branch AS br ON br.Branch_Key = r.Original_Branch_Key and UPPER( br.Office_Code) IN ( ''CAM'', ''TEB'', ''COA'', ''AWV'', ''WIS'')
    WHERE R.SOURCE_SYSTEM_ID = 1 
    AND r.Report_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
--    AND  r.Report_Date BETWEEN ''2020-12-01'' AND ''2020-12-31''
    ) x
    INNER JOIN INTEGRATION.FACT_REVENUE_MERGED AS rev ON rev.Client_Key = x.Client_Key AND DATE_TRUNC( ''MONTH'', rev.Report_Date) = x.Revenue_Month
    GROUP BY 1, 2
), -- SELECT COUNT( DISTINCT Client_KEY) AS Record_Count FROM Altrus_Revenue_Clients WHERE Revenue_Month = ''2020-12-01'';
Client_List AS  -- Get a list of clients who received visits within the calendar period
(
    SELECT DISTINCT 
           vis.Client_Key
	FROM INTEGRATION.FACT_VISIT_MERGED AS vis
    INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
    WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
	AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					 
    --AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
    UNION
    -- Need revenue altrus clients that aren''t captured in visits
    SELECT DISTINCT 
           r.Client_Key
    FROM Altrus_Revenue_Clients AS r
    --WHERE R.SOURCE_SYSTEM_ID = 1 
), 
Clients_and_Branch_Visits AS
(
    SELECT DATE_TRUNC( ''YEAR'', vis.Service_Date) AS Service_Year,
           vis.Client_Key,
           vis.Branch_Key,
           COUNT(DISTINCT Visit_Key) AS Record_Count
	FROM INTEGRATION.FACT_VISIT_MERGED AS vis
    INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
    WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
	AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					 
    --AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
    GROUP BY 1, 2, 3
),
Clients_and_Branches AS (
SELECT Service_Year, LAST_DAY( DATEADD( ''MONTH'', 11, Service_Year)) AS End_of_Service_Year, Client_Key, Record_Count, MAX( Branch_Key) AS Branch_Key
FROM Clients_and_Branch_Visits AS cb
WHERE CAST( Service_Year AS VARCHAR)||Client_Key||CAST( Record_Count AS VARCHAR) IN (
SELECT Service_Year||Client_Key||MAX( Record_Count) 
FROM Clients_and_Branch_Visits AS cb2 
GROUP BY Service_Year, Client_Key)
GROUP BY Service_Year, 2, 3, 4
),
Client_Months AS  -- Create a list of every month for each employee
(
SELECT cm.Calendar_Month AS Service_Month,
       cl.Client_Key
FROM Calendar_Months AS cm
FULL OUTER JOIN Client_List AS cl
WHERE cm.Calendar_Month IS NOT NULL
ORDER BY cl.Client_Key, cm.Calendar_Month
),
client_branch_month as
(
  select distinct vis.client_key,
  DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
  first_value(vis.branch_key) over (partition by vis.client_key,DATE_TRUNC( ''MONTH'', vis.Service_Date) order by service_Date desc ) branch_key
  FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					 
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
AND vis.Original_Source_System_ID <> 1 
),
Client_Visits AS  -- Compile metrics for every service/visit month the employee delivered services/visits
(
SELECT vis.Client_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       cb.Branch_Key,
	   cbm.branch_key as original_branch_key,
	   CAST( 0 AS INTEGER) AS Invoice_Count,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_Visits,
       SUM( vis.Hours_Served) AS Sum_of_Hours_Received
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
LEFT OUTER JOIN Clients_and_Branches AS cb ON vis.Client_Key = cb.Client_Key AND vis.Service_Date BETWEEN cb.Service_Year AND cb.End_of_Service_Year
LEFT OUTER JOIN client_branch_month AS cbm ON vis.Client_Key = cbm.Client_Key AND DATE_TRUNC( ''MONTH'', vis.Service_Date) = cbm.Service_Month

WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					 
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
AND vis.Original_Source_System_ID <> 1  -- exclude Altrus clients because they will be picked up in the next query
GROUP BY vis.Client_Key, DATE_TRUNC( ''MONTH'', vis.Service_Date), cb.Branch_Key,cbm.branch_key 
  
UNION
SELECT Client_Key,
       Revenue_Month AS Service_Month,
       CAST( NULL AS VARCHAR) AS Branch_Key,
       CAST( NULL AS VARCHAR) AS original_Branch_Key,
       Invoice_Count,
       CAST( 0 AS INTEGER) AS Number_of_Visits,
       CAST( 0 AS DECIMAL) AS Sum_Of_Hours_Recieved
FROM Altrus_Revenue_Clients
), 
Client_Monthly_Visits AS -- Put visits and monthly employees together
(
SELECT cm.Service_Month,
       cm.Client_Key,
       cb.Branch_Key,
	   cv.original_branch_key,
       cv.Invoice_Count,
       cv.Number_of_Visits,
       cv.Sum_of_Hours_Received
FROM Client_Months AS cm
LEFT OUTER JOIN Client_Visits AS cv ON cm.Service_Month = cv.Service_Month AND cm.Client_Key = cv.Client_Key
LEFT OUTER JOIN Clients_and_Branches AS cb ON cm.Client_Key = cb.Client_Key AND cm.Service_Month BETWEEN cb.Service_Year AND cb.End_of_Service_Year
),
Client_HC_Visit_Days AS
(
SELECT Client_Key, 
       Srvc_Month,
       CAST( CASE WHEN Revenue_Category = ''HC'' THEN Days_Served
                  ELSE 0
             END
             AS INTEGER) AS HC_Days_Served
FROM (
       SELECT vis.Client_Key, 
              cntrct.Revenue_Category,
              DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Srvc_Month,
              COUNT( DISTINCT vis.Service_Date) AS Days_Served
       FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
       INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
                                   AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' AND cntrct.Revenue_Category IN (''HC'') AND cntrct.Contract_Key IN (SELECT Contract_Key FROM REPORT.VW_DASHBOARD_CONTRACTS WHERE INCLUDE_FOR_EXEC_OPS_HOURS = TRUE)
       WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
		AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					 
       --AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
       GROUP BY vis.Client_Key, Srvc_Month, cntrct.Revenue_Category
    ) x
), 
Client_HH_Visit_Days AS
(
SELECT Client_Key,
       Srvc_Month,
       CAST( CASE WHEN Revenue_Category = ''HH'' THEN Days_Served
                  ELSE 0
             END
             AS INTEGER) AS HH_Days_Served
FROM (
       SELECT vis.Client_Key, 
              cntrct.Revenue_Category,
              DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Srvc_Month,
              COUNT( DISTINCT vis.Service_Date) AS Days_Served
       FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
       INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
                                   AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' AND cntrct.Revenue_Category IN (''HH'') AND cntrct.Contract_Key IN (SELECT Contract_Key FROM REPORT.VW_DASHBOARD_CONTRACTS WHERE INCLUDE_FOR_EXEC_OPS_HOURS = TRUE)
       WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
		AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					 
       --AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
       GROUP BY vis.Client_Key, Srvc_Month, cntrct.Revenue_Category
       ORDER BY vis.Client_Key, Srvc_Month, cntrct.Revenue_Category
    ) x
), 
Client_OTHER_Visit_Days AS
(
SELECT Client_Key,
       Srvc_Month,
       CAST( CASE WHEN Revenue_Category = ''OTHER'' THEN Days_Served
                  ELSE 0
             END
             AS INTEGER) AS OTHER_Days_Served
FROM (
       SELECT vis.Client_Key, 
              cntrct.Revenue_Category,
              DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Srvc_Month,
              COUNT( DISTINCT vis.Service_Date) AS Days_Served
       FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
       INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
                                   AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' AND cntrct.Revenue_Category IN (''OTHER'') AND cntrct.Contract_Key IN (SELECT Contract_Key FROM REPORT.VW_DASHBOARD_CONTRACTS WHERE INCLUDE_FOR_EXEC_OPS_HOURS = TRUE)
       WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
		AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					 
       --AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
       GROUP BY vis.Client_Key, Srvc_Month, cntrct.Revenue_Category
       ORDER BY vis.Client_Key, Srvc_Month, cntrct.Revenue_Category
    ) x
),
Client_Tenure_Metrics AS 
(
SELECT cmv.Client_Key,
       COUNT( cmv.Service_Month) AS Number_Months_with_Service,
       MIN( cmv.Service_Month) AS First_Service_Month,
       MAX( cmv.Service_Month) AS Last_Service_Month,
       DATEDIFF( ''MONTH'', First_Service_Month, Last_Service_Month) + 1 AS Tenure_In_Months,
       Tenure_In_Months - Number_Months_with_Service AS Number_Months_wo_Service
FROM Client_Monthly_Visits AS cmv
WHERE cmv.Number_of_Visits IS NOT NULL OR NVL( cmv.Invoice_Count, 0) > 0
GROUP BY cmv.Client_Key
),
Client_Monthly_CLS_Visits AS
(
SELECT vis.Client_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_CLS_Visits,
       SUM( vis.Hours_Served) AS Sum_of_CLS_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
                 AND cntrct.Revenue_Category = ''CLS'' AND cntrct.Revenue_Subcategory_Code = ''RES''  AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					  
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
AND vis.Original_Source_System_ID <> 1   -- Exclude Altrus CLS since it''s being calculated off of Revenue records
GROUP BY vis.Client_Key, Service_Month
ORDER BY vis.Client_Key, Service_Month
),
Client_Monthly_HC_Visits AS
(
SELECT vis.Client_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_HC_Visits,
       SUM( vis.Hours_Served) AS Sum_of_HC_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
                AND cntrct.Revenue_Category = ''HC'' AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' AND cntrct.Contract_Key IN (SELECT Contract_Key FROM REPORT.VW_DASHBOARD_CONTRACTS WHERE INCLUDE_FOR_EXEC_OPS_HOURS = TRUE)
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					  
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
--AND vis.Hours_Served >= 1
GROUP BY vis.Client_Key, Service_Month
),
Client_Monthly_HH_Visits AS
(
SELECT vis.Client_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_HH_Visits,
       SUM( vis.Hours_Served) AS Sum_of_HH_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
                AND cntrct.Revenue_Category = ''HH'' AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' AND cntrct.Contract_Key IN (SELECT Contract_Key FROM REPORT.VW_DASHBOARD_CONTRACTS WHERE INCLUDE_FOR_EXEC_OPS_HOURS = TRUE)
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					  
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
GROUP BY vis.Client_Key, Service_Month
),
Client_Monthly_NA_Visits AS
(
SELECT vis.Client_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_NA_Visits,
       SUM( vis.Hours_Served) AS Sum_of_NA_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''NA'' AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					  
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
GROUP BY vis.Client_Key, Service_Month
),
Client_Monthly_IS_Visits AS
(
SELECT vis.Client_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_IS_Visits,
       SUM( vis.Hours_Served) AS Sum_of_IS_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''IS'' AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					  
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
GROUP BY vis.Client_Key, Service_Month
),
Client_Monthly_NS_Visits AS
(
SELECT vis.Client_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_NS_Visits,
       SUM( vis.Hours_Served) AS Sum_of_NS_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''NS'' AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					  
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
GROUP BY vis.Client_Key, Service_Month
),
Client_Monthly_OTHER_Visits AS
(
SELECT vis.Client_Key, 
       DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_OTHER_Visits,
       SUM( vis.Hours_Served) AS Sum_of_OTHER_Hours_Served
FROM INTEGRATION.FACT_VISIT_MERGED AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
                AND cntrct.Revenue_Category = ''OTHER'' AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' AND cntrct.Contract_Key IN (SELECT Contract_Key FROM REPORT.VW_DASHBOARD_CONTRACTS WHERE INCLUDE_FOR_EXEC_OPS_HOURS = TRUE)
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
AND vis.CONFIRMED_FLAG = ''YES'' AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					  
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
GROUP BY vis.Client_Key, Service_Month
),
Client_Service_Line_Metrics AS
(
SELECT cm.Client_Key, cm.Service_Month,
	   IFF(hccl.Number_of_HC_Visits IS NOT NULL, 1, 0)
		   + IFF(hhcl.Number_of_HH_Visits IS NOT NULL, 1, 0)
		   + IFF(clscl.Number_of_CLS_Visits IS NOT NULL OR NVL( arc.Invoice_Count, 0) >= 1, 1, 0)
		   + IFF(othercl.Number_of_OTHER_Visits IS NOT NULL, 1, 0) AS Number_of_Service_Lines_Provided,
	   /*
       CASE WHEN hccl.Number_of_HC_Visits IS NULL AND hhcl.Number_of_HH_Visits IS NULL AND (clscl.Number_of_CLS_Visits IS NULL OR NVL( arc.Invoice_Count, 0) = 0) THEN 0
            WHEN hccl.Number_of_HC_Visits IS NOT NULL AND hhcl.Number_of_HH_Visits IS NULL AND (clscl.Number_of_CLS_Visits IS NULL OR NVL( arc.Invoice_Count, 0) = 0) THEN 1
            WHEN hccl.Number_of_HC_Visits IS NULL AND hhcl.Number_of_HH_Visits IS NOT NULL AND (clscl.Number_of_CLS_Visits IS NULL OR NVL( arc.Invoice_Count, 0) = 0) THEN 1
            WHEN hccl.Number_of_HC_Visits IS NULL AND hhcl.Number_of_HH_Visits IS NULL AND (clscl.Number_of_CLS_Visits IS NOT NULL OR NVL( arc.Invoice_Count, 0) >= 1) THEN 1
            WHEN hccl.Number_of_HC_Visits IS NOT NULL AND hhcl.Number_of_HH_Visits IS NOT NULL AND (clscl.Number_of_CLS_Visits IS NULL OR NVL( arc.Invoice_Count, 0) = 0) THEN 2
            WHEN hccl.Number_of_HC_Visits IS NOT NULL AND hhcl.Number_of_HH_Visits IS NULL AND (clscl.Number_of_CLS_Visits IS NOT NULL OR NVL( arc.Invoice_Count, 0) >= 1) THEN 2
            WHEN hccl.Number_of_HC_Visits IS NULL AND hhcl.Number_of_HH_Visits IS NOT NULL AND (clscl.Number_of_CLS_Visits IS NOT NULL OR NVL( arc.Invoice_Count, 0) >= 1) THEN 2
            WHEN hccl.Number_of_HC_Visits IS NOT NULL AND hhcl.Number_of_HH_Visits IS NOT NULL AND (clscl.Number_of_CLS_Visits IS NOT NULL OR NVL( arc.Invoice_Count, 0) >= 1) THEN 3
       END AS Number_of_Service_Lines_Provided,
       */
       CASE WHEN hccl.Number_of_HC_Visits IS NOT NULL THEN ''TRUE''
            ELSE ''FALSE''
       END HC_Contract_Services_Provided,
       CASE WHEN hhcl.Number_of_HH_Visits IS NOT NULL THEN ''TRUE''
            ELSE ''FALSE''
       END HH_Contract_Services_Provided,
       CASE WHEN clscl.Number_of_CLS_Visits IS NOT NULL OR NVL( arc.Invoice_Count, 0) >= 1 THEN ''TRUE''
            ELSE ''FALSE''
       END CLS_Contract_Services_Provided,
       CASE WHEN nacl.Number_of_NA_Visits IS NOT NULL THEN ''TRUE''
            ELSE ''FALSE''
       END NA_Contract_Services_Provided,
       CASE WHEN iscl.Number_of_IS_Visits IS NOT NULL THEN ''TRUE''
            ELSE ''FALSE''
       END IS_Contract_Services_Provided,
       CASE WHEN nscl.Number_of_NS_Visits IS NOT NULL THEN ''TRUE''
            ELSE ''FALSE''
       END NS_Contract_Services_Provided,
       CASE WHEN othercl.Number_of_OTHER_Visits IS NOT NULL THEN ''TRUE''
            ELSE ''FALSE''
       END OTHER_Contract_Services_Provided,
       cvdhc.HC_Days_Served,
       hccl.Number_of_HC_Visits,
       hccl.Sum_of_HC_Hours_Served,
       cvdhh.HH_Days_Served,
       hhcl.Number_of_HH_Visits,
       hhcl.Sum_of_HH_Hours_Served,
       cvdother.OTHER_Days_Served,
       othercl.Number_of_OTHER_Visits,
       othercl.Sum_of_OTHER_Hours_Served,
       clscl.Number_of_CLS_Visits,
       clscl.Sum_of_CLS_Hours_Served,
       arc.Invoice_Count AS CLS_Invoice_Count,
       nacl.Number_of_NA_Visits,
       nacl.Sum_of_NA_Hours_Served,
       iscl.Number_of_IS_Visits,
       iscl.Sum_of_IS_Hours_Served,
       nscl.Number_of_NS_Visits,
       nscl.Sum_of_NS_Hours_Served
FROM Client_Months AS cm
LEFT OUTER JOIN Client_Monthly_CLS_Visits AS clscl ON cm.Client_Key = clscl.Client_Key AND cm.Service_Month = clscl.Service_Month
LEFT OUTER JOIN Client_Monthly_HH_Visits AS hhcl ON cm.Client_Key = hhcl.Client_Key AND cm.Service_Month = hhcl.Service_Month
LEFT OUTER JOIN Client_Monthly_HC_Visits AS hccl ON cm.Client_Key = hccl.Client_Key AND cm.Service_Month = hccl.Service_Month
LEFT OUTER JOIN Client_Monthly_NA_Visits AS nacl ON cm.Client_Key = nacl.Client_Key AND cm.Service_Month = nacl.Service_Month
LEFT OUTER JOIN Client_Monthly_IS_Visits AS iscl ON cm.Client_Key = iscl.Client_Key AND cm.Service_Month = iscl.Service_Month
LEFT OUTER JOIN Client_Monthly_NS_Visits AS nscl ON cm.Client_Key = nscl.Client_Key AND cm.Service_Month = nscl.Service_Month
LEFT OUTER JOIN Client_Monthly_OTHER_Visits AS othercl ON cm.Client_Key = othercl.Client_Key AND cm.Service_Month = othercl.Service_Month
LEFT OUTER JOIN Altrus_Revenue_Clients AS arc ON cm.Client_Key = arc.Client_Key AND cm.Service_Month = arc.Revenue_Month
LEFT OUTER JOIN Client_HC_Visit_Days AS cvdhc ON cm.Client_Key = cvdhc.Client_Key AND cm.Service_Month = cvdhc.Srvc_Month
LEFT OUTER JOIN Client_HH_Visit_Days AS cvdhh ON cm.Client_Key = cvdhh.Client_Key AND cm.Service_Month = cvdhh.Srvc_Month
LEFT OUTER JOIN Client_OTHER_Visit_Days AS cvdother ON cm.Client_Key = cvdother.Client_Key AND cm.Service_Month = cvdother.Srvc_Month
WHERE (othercl.Number_of_OTHER_Visits IS NOT NULL OR hccl.Number_of_HC_Visits IS NOT NULL OR hhcl.Number_of_HH_Visits IS NOT NULL OR clscl.Number_of_CLS_Visits IS NOT NULL OR nacl.Number_of_NA_Visits IS NOT NULL OR iscl.Number_of_IS_Visits IS NOT NULL OR nscl.Number_of_NS_Visits IS NOT NULL OR arc.Invoice_Count IS NOT NULL OR NVL( cvdhc.HC_Days_Served, 0) <> 0 OR NVL( cvdhh.HH_Days_Served, 0) <> 0)
), 
Client_Lag_Lead_Metrics AS -- Compute LAG and LEAD Metrics
(
SELECT cmv.Service_Month,
       cmv.Client_Key,
       cmv.Branch_Key,
	   cmv.original_branch_key,
       ctm.Number_Months_with_Service,
       ctm.First_Service_Month,
       ctm.Last_Service_Month,
       ctm.Tenure_In_Months,
       ctm.Number_Months_wo_Service,
       cmv.Number_of_Visits, 
       LAG( cmv.Number_of_Visits, 1, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Month) AS Previous_Month_Number_Of_Visits,
       LAG( cmv.Number_of_Visits, 2, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Month) AS Previous_2_Month_Number_Of_Visits,
       LEAD( cmv.Number_of_Visits, 1, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Month) AS Next_Month_Number_Of_Visits,
       LEAD( cmv.Number_of_Visits, 2, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Month) AS Next_2_Month_Number_Of_Visits,
       ROW_NUMBER() OVER (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Month) AS SeqNum,
       CASE WHEN NVL( cmv.Number_of_Visits, 0) <> 0 THEN ROW_NUMBER() OVER (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Month) ELSE NULL END AS SeqNum_Non_Gap,
       cmv.Sum_of_Hours_Received,
       LAG( cmv.Sum_of_Hours_Received, 1, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Month) AS Previous_Month_Sum_of_Hours_Received,
       LAG( cmv.Sum_of_Hours_Received, 2, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Month) AS Previous_2_Month_Sum_of_Hours_Received,
       LEAD( cmv.Sum_of_Hours_Received, 1, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Month) AS Next_Month_Sum_of_Hours_Received,
       LEAD( cmv.Sum_of_Hours_Received, 2, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Month) AS Next_2_Month_Sum_of_Hours_Received,
       CASE WHEN NVL( cmv.Sum_of_Hours_Received, 0) <> 0 OR NVL( cmv.Invoice_Count, 0) > 0 THEN ''TRUE''
            ELSE ''FALSE''
       END AS Active_Flag,
       CASE WHEN ctm.First_Service_Month < cmv.Service_Month AND NVL( Previous_Month_Sum_of_Hours_Received, 0) = 0 AND NVL( cmv.Sum_of_Hours_Received, 0) > 0 THEN ''TRUE''
            ELSE ''FALSE''
       END AS Reactivated_Flag
FROM Client_Monthly_Visits AS cmv
LEFT OUTER JOIN Client_Tenure_Metrics AS ctm ON cmv.Client_Key = ctm.Client_Key
WHERE cmv.Service_Month BETWEEN ctm.First_Service_Month AND DATEADD( ''MONTH'', 1, ctm.Last_Service_Month)
), 
Compute_Client_Max_Min_Gap AS
(
SELECT x.Client_Key,
       COUNT( Continuous_Months_wo_Service) AS Number_of_Gaps_in_Service,
       MIN( Continuous_Months_wo_Service) AS Smallest_Gap_in_Service,
       MAX( Continuous_Months_wo_Service) AS Largest_Gap_in_Service
FROM
(
SELECT cllm.Client_Key,
       cllm.SeqNum,
       cllm.SeqNum_Non_Gap,
       (SELECT MIN(cllm2.SeqNum_Non_Gap) FROM Client_Lag_Lead_Metrics AS cllm2 WHERE cllm2.Client_Key = cllm.Client_Key AND cllm2.SeqNum_Non_Gap > cllm.SeqNum_Non_Gap) - 1 AS EndSeqNum,
       EndSeqNum - cllm.SeqNum_Non_Gap AS Continuous_Months_wo_Service
FROM Client_Lag_Lead_Metrics AS cllm
WHERE NOT EXISTS ( SELECT * FROM Client_Lag_Lead_Metrics AS cllm3 
                   WHERE cllm3.Client_Key = cllm.Client_Key
                   AND cllm3.SeqNum_Non_Gap = cllm.SeqNum_Non_Gap + 1)
AND cllm.SeqNum_Non_Gap IS NOT NULL    
AND EndSeqNum IS NOT NULL
) x
GROUP BY x.Client_Key
)
SELECT DISTINCT cllm.SERVICE_MONTH, 
       cllm.Client_KEY, 
       COALESCE(cl.SOURCE_SYSTEM_ID, -1) AS SOURCE_SYSTEM_ID,
       -- Since the Client_Key is now the new key select the key where the source system IDs DO NOT match, as the original source system ID
       FIRST_VALUE(COALESCE(cl.Original_Source_System_Id, -1)) OVER (PARTITION BY cl.Client_Key ORDER BY IFF(cl.Original_Source_System_ID <> cl.Source_System_ID, 0, 1)) AS Original_Source_System_ID, 
       cllm.Branch_Key AS Branch_Key,
	   cllm.original_branch_key,
       br.Detailed_Office_Name AS Office_Name,
       br.Office_State_Code AS Office_State_Code,
         CL.AGENCY AS AGENCY,
       CASE WHEN CL.AGENCY IN (''COMMUNITY CARE'') THEN TRUE ELSE FALSE END AS CCSI_FLAG,
           cl.Derived_Referral_Date AS Referral_Date,
       cl.Client_State_Code,
       cllm.FIRST_SERVICE_MONTH AS Lifetime_First_Service_Month, 
       cllm.LAST_SERVICE_MONTH AS Lifetime_Last_Service_Month, 
       CAST( cllm.TENURE_IN_MONTHS AS INTEGER) AS Lifetime_Tenure_In_Months, 
       CAST( cllm.NUMBER_MONTHS_WITH_SERVICE AS INTEGER) AS Lifetime_NUMBER_MONTHS_WITH_SERVICE, 
       CAST( cllm.NUMBER_MONTHS_WO_SERVICE AS INTEGER) AS Lifetime_Number_Months_wo_Service, 
       CAST( NVL( ccmmg.Number_of_Gaps_In_Service, 0) AS INTEGER) AS Lifetime_Number_of_Gaps_In_Service, 
       CAST( ccmmg.Smallest_Gap_In_Service AS INTEGER) AS Lifetime_Smallest_Gap_In_Service, 
       CAST( ccmmg.Largest_Gap_In_Service AS INTEGER) AS Lifetime_Largest_Gap_In_Service,
       CAST( CASE WHEN cllm.FIRST_SERVICE_MONTH = cllm.SERVICE_MONTH THEN ''TRUE''
                  ELSE ''FALSE''
             END 
            AS BOOLEAN) AS New_Client_Flag,
       CAST( CASE WHEN NVL( cllm.Number_of_Visits, 0) = 0 AND NVL( cllm.Previous_Month_Number_of_Visits, 0) <> 0 THEN ''TRUE''
                  ELSE ''FALSE''
             END
            AS BOOLEAN) AS First_Month_Inactive_Flag,
       CAST( cllm.ACTIVE_FLAG AS BOOLEAN) AS Active_Flag, 
       CAST( REACTIVATED_FLAG AS BOOLEAN) AS Reactivated_Flag,
       CAST( cslm.Number_of_Service_Lines_Provided AS INTEGER) AS Number_of_Service_Lines_Provided,     
       CAST( cslm.HC_Contract_Services_Provided AS BOOLEAN) AS HC_Service_Line_Provided,
       CAST( cslm.HH_Contract_Services_Provided AS BOOLEAN) AS HH_Service_Line_Provided,
       CAST( cslm.CLS_Contract_Services_Provided AS BOOLEAN) AS CLS_Service_Line_Provided,
       CAST( cslm.NA_Contract_Services_Provided AS BOOLEAN) AS NA_Service_Line_Provided,
       CAST( cslm.IS_Contract_Services_Provided AS BOOLEAN) AS IS_Service_Line_Provided,
       CAST( cslm.NS_Contract_Services_Provided AS BOOLEAN) AS NS_Service_Line_Provided,
       CAST( cslm.OTHER_Contract_Services_Provided AS BOOLEAN) AS OTHER_Service_Line_Provided,
       cllm.NUMBER_OF_VISITS, cllm.PREVIOUS_MONTH_NUMBER_OF_VISITS, cllm.PREVIOUS_2_MONTH_NUMBER_OF_VISITS, cllm.NEXT_MONTH_NUMBER_OF_VISITS, cllm.NEXT_2_MONTH_NUMBER_OF_VISITS, 
       CAST( cllm.SUM_OF_HOURS_Received AS NUMBER( 9,3)) AS Sum_Of_Hours_Received, 
       CAST( cllm.PREVIOUS_MONTH_SUM_OF_HOURS_ReceiveD AS NUMBER( 9,3)) AS Previous_Month_Sum_of_Hours_Received, 
       CAST( cllm.PREVIOUS_2_MONTH_SUM_OF_HOURS_ReceiveD AS NUMBER( 9,3)) AS Previous_2_Month_Sum_of_Hours_Received, 
       CAST( cllm.NEXT_MONTH_SUM_OF_HOURS_ReceiveD AS NUMBER( 9,3)) AS Next_Month_Sum_Of_Hours_Received, 
       CAST( cllm.NEXT_2_MONTH_SUM_OF_HOURS_ReceiveD AS NUMBER( 9,3)) AS Next_2_Month_Sum_of_Hours_Received,
       HC_Days_Served AS Number_Of_HC_Visit_Days, 
       CAST( NVL( cslm.Number_of_HC_Visits, 0) AS INTEGER) AS Number_of_HC_Visits,
       CAST( NVL( cslm.Sum_of_HC_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_HC_Hours_Served,
       HH_Days_Served AS Number_Of_HH_Visit_Days,
       CAST( NVL( cslm.Number_of_HH_Visits, 0) AS INTEGER) AS Number_of_HH_Visits,
       CAST( NVL( cslm.Sum_of_HH_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_HH_Hours_Served,
       CAST( NVL( cslm.Number_of_CLS_Visits, 0) AS INTEGER) AS Number_of_CLS_Visits,
       CAST( NVL( cslm.Sum_of_CLS_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_CLS_Hours_Served,
       CAST( NVL( cslm.Number_of_NA_Visits, 0) AS INTEGER) AS Number_of_NA_Visits,
       CAST( NVL( cslm.Sum_of_NA_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_NA_Hours_Served,
       CAST( NVL( cslm.Number_of_IS_Visits, 0) AS INTEGER) AS Number_of_IS_Visits,
       CAST( NVL( cslm.Sum_of_IS_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_IS_Hours_Served,
       CAST( NVL( cslm.Number_of_NS_Visits, 0) AS INTEGER) AS Number_of_NS_Visits,
       CAST( NVL( cslm.Sum_of_NS_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_NS_Hours_Served,
       OTHER_Days_Served AS Number_Of_OTHER_Visit_Days,
       CAST( NVL( cslm.Number_of_OTHER_Visits, 0) AS INTEGER) AS Number_of_OTHER_Visits,
       CAST( NVL( cslm.Sum_of_OTHER_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_OTHER_Hours_Served
FROM Client_Lag_Lead_Metrics AS cllm
LEFT OUTER JOIN Compute_Client_Max_Min_Gap AS ccmmg ON cllm.Client_Key = ccmmg.Client_Key
LEFT OUTER JOIN Client_Service_Line_Metrics AS cslm ON cllm.Client_Key = cslm.Client_Key AND cllm.Service_Month = cslm.Service_Month
LEFT OUTER JOIN INTEGRATION.DIM_BRANCH_MERGED AS br ON br.Original_Branch_Key = cllm.Branch_Key
LEFT OUTER JOIN INTEGRATION.DIM_CLIENT_MERGED AS cl ON cl.Client_Key = cllm.Client_Key
WHERE cllm.Service_Month BETWEEN cllm.First_Service_Month AND DATEADD( ''MONTH'', 1, cllm.Last_Service_Month);

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

