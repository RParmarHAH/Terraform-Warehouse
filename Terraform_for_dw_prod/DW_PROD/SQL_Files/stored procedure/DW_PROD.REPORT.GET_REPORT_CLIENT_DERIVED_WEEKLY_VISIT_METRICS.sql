CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_CLIENT_DERIVED_WEEKLY_VISIT_METRICS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    INSERT OVERWRITE INTO Report.Client_Derived_Weekly_Visit_Metrics 
WITH Calendar_Weeks AS  
(
	SELECT DATE_TRUNC( WEEK, CALENDAR_DATE) AS Calendar_Week
    FROM HAH.DIM_DATE
    WHERE CALENDAR_DATE BETWEEN CAST( ''1995-01-01'' AS DATE) AND DATEADD( ''WEEK'', 1, CURRENT_DATE())
	GROUP BY 1
),
Altrus_Revenue_Clients AS
(
    SELECT x.Source_System_ID,
           x.System_Code,
           x.Client_Key,
           x.Revenue_Week,
           COUNT( DISTINCT rev.Invoice_Key) AS Invoice_Count
    FROM
    (  
    SELECT r.Source_System_ID,
           r.System_Code,
           r.Client_Key,
           DATE_TRUNC( ''WEEK'', r.Report_Date) AS Revenue_Week
--           COUNT( DISTINCT r.Invoice_Key) AS Invoice_Count
    FROM HAH.FACT_REVENUE R
    INNER JOIN HAH.DIM_Contract AS cntrct ON r.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND cntrct.Revenue_Category = ''CLS'' AND cntrct.Revenue_Subcategory_Code = ''RES'' /* AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' */ AND UPPER( cntrct.Contract_Name) IN ( ''INDEPENDENT CARE WAIVER PROGRA'', ''MR COMP WAIVER'')
    WHERE R.SOURCE_SYSTEM_ID = 1 
    AND r.Report_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)    
--    AND  r.Report_Date BETWEEN ''2020-12-01'' AND ''2020-12-31''
--    AND R.BILL_CODE IN (''ALG'', ''ALP'',''ALS'',''BSC'',''BSS'',''CAG'',''CAI'',''HB'',''HBG'',''ICWP'',''ICWP-HB'',''IWCP-LB'',''LB'',''LBG'',''MRWP'',''PC1'')
    UNION
    SELECT r.Source_System_ID,
           r.System_Code,
           r.Client_Key,
           DATE_TRUNC( ''WEEK'', r.Report_Date) AS Revenue_Week
    FROM HAH.FACT_REVENUE R
    INNER JOIN HAH.DIM_Contract AS cntrct ON r.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND cntrct.Revenue_Category = ''CLS'' AND cntrct.Revenue_Subcategory_Code = ''RES'' /* AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' */ -- AND UPPER( cntrct.Contract_Name) IN ( ''INDEPENDENT CARE WAIVER PROGRA'', ''MR COMP WAIVER'')
    INNER JOIN HAH.DIM_Branch AS br ON br.Branch_Key = r.Branch_Key and UPPER( br.Office_Code) IN ( ''CAM'', ''TEB'', ''COA'', ''AWV'', ''WIS'')
    WHERE R.SOURCE_SYSTEM_ID = 1 
    AND r.Report_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
--    AND  r.Report_Date BETWEEN ''2020-12-01'' AND ''2020-12-31''
    ) x
    INNER JOIN HAH.FACT_Revenue AS rev ON rev.Client_Key = x.Client_Key AND rev.Source_System_ID = x.Source_System_Id AND DATE_TRUNC( ''WEEK'', rev.Report_Date) = x.Revenue_Week
    GROUP BY 1, 2, 3, 4
) /* SELECT COUNT( DISTINCT Client_KEY) AS Record_Count FROM Altrus_Revenue_Clients WHERE Revenue_Week >= ''2021-03-01''; */ ,
Client_List AS  -- Get a list of clients who received visits within the calendar period
(
    SELECT DISTINCT vis.Source_System_ID,
           vis.System_Code,
           vis.Client_Key
	FROM HAH.FACT_Visit AS vis
    INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Source_System_ID = cntrct.Source_System_ID AND vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) -- AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
    WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
	AND vis.CONFIRMED_FLAG = ''YES'' --AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					  
    --AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
    UNION
    -- Need revenue altrus clients that aren''t captured in visits
    SELECT DISTINCT r.Source_System_ID,
           r.System_Code,
           r.Client_Key
    FROM Altrus_Revenue_Clients AS r
    WHERE R.SOURCE_SYSTEM_ID = 1 
) /* SELECT COUNT( DISTINCT Client_Key) AS client_count FROM Client_List; */ ,
Clients_and_Branch_Visits AS
(
    SELECT DATE_TRUNC( ''YEAR'', vis.Service_Date) AS Service_Year,
           vis.Source_System_ID,
           vis.System_Code,
           vis.Client_Key,
           vis.Branch_Key,
           COUNT(DISTINCT Visit_Key) AS Record_Count
	FROM HAH.FACT_Visit AS vis
    INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Source_System_ID = cntrct.Source_System_ID AND vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) -- AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
    WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
	AND vis.CONFIRMED_FLAG = ''YES'' --AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					   
    --AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
    GROUP BY 1, vis.Source_System_ID, vis.System_Code, vis.Client_Key,  vis.Branch_Key
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS client_count FROM Clients_and_Branch_Visits; */ ,
Clients_and_Branches AS (
SELECT Service_Year, LAST_DAY( DATEADD( ''MONTH'', 11, Service_Year)) AS End_of_Service_Year, Source_System_ID, System_Code, Client_Key, Record_Count, MAX( Branch_Key) AS Branch_Key
FROM Clients_and_Branch_Visits AS cb
WHERE CAST( Service_Year AS VARCHAR)||Client_Key||CAST( Record_Count AS VARCHAR) IN (
SELECT Service_Year||Client_Key||MAX( Record_Count) 
FROM Clients_and_Branch_Visits AS cb2 
GROUP BY Service_Year, Client_Key)
GROUP BY Service_Year, 2, 3, 4, 5, 6
ORDER BY Service_Year, Source_System_ID, System_Code, Client_Key
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS client_count FROM Clients_and_Branches; */ ,
Client_Weeks AS  -- Create a list of every month for each employee
(
SELECT cm.Calendar_Week AS Service_Week,
       cl.Client_Key,
       cl.Source_System_ID,
       cl.System_Code
FROM Calendar_Weeks AS cm
FULL OUTER JOIN Client_List AS cl
WHERE cm.Calendar_Week IS NOT NULL
ORDER BY cl.Client_Key, cm.Calendar_Week
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS CLIENT_COUNT, MIN( SERVICE_WEEK), MAX( SERVICE_WEEK) FROM Client_Weeks; */ ,
Client_Visits AS  -- Compile metrics for every service/visit month the employee delivered services/visits
(
SELECT vis.Client_Key, 
       vis.Source_System_ID,
       DATE_TRUNC( ''WEEK'', vis.Service_Date) AS Service_Week,
       cb.Branch_Key,
       CAST( 0 AS INTEGER) AS Invoice_Count,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_Visits,
       SUM( vis.Hours_Served) AS Sum_of_Hours_Received
FROM HAH.Fact_Visit AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Source_System_ID = cntrct.Source_System_ID AND vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) -- AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
LEFT OUTER JOIN Clients_and_Branches AS cb ON vis.System_Code = cb.System_Code AND vis.Client_Key = cb.Client_Key AND vis.Service_Date BETWEEN cb.Service_Year AND cb.End_of_Service_Year
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' --AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					   
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
AND vis.Source_System_ID <> 1  -- exclude Altrus clients because they will be picked up in the next query
GROUP BY vis.Client_Key, vis.Source_System_ID, DATE_TRUNC( ''WEEK'', vis.Service_Date), cb.Branch_Key
UNION
SELECT Client_Key,
       Source_System_ID,
       Revenue_Week AS Service_Week,
       CAST( NULL AS VARCHAR) AS Branch_Key,
       Invoice_Count,
       CAST( 0 AS INTEGER) AS Number_of_Visits,
       CAST( 0 AS DECIMAL) AS Sum_Of_Hours_Recieved
FROM Altrus_Revenue_Clients
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS CLIENT_COUNT FROM Client_Visits; */ , 
Client_Weekly_Visits AS -- Put visits and monthly employees together
(
SELECT cm.Service_Week,
       cm.Client_Key,
       cm.Source_System_ID,
       cb.Branch_Key,
       cv.Invoice_Count,
       cv.Number_of_Visits,
       cv.Sum_of_Hours_Received
FROM Client_Weeks AS cm
LEFT OUTER JOIN Client_Visits AS cv ON cm.Service_Week = cv.Service_Week AND cm.Client_Key = cv.Client_Key and cm.Source_System_ID = cv.Source_System_ID
LEFT OUTER JOIN Clients_and_Branches AS cb ON cm.Source_System_ID = cb.Source_System_ID AND cm.Client_Key = cb.Client_Key AND cm.Service_Week BETWEEN cb.Service_Year AND cb.End_of_Service_Year
ORDER BY cm.Client_Key, cm.Service_Week
) /* SELECT COUNT( DISTINCT Client_Key) AS CLIENT_COUNT, MIN( Service_Week), MAX( Service_Week) FROM Client_Weekly_Visits; */ ,
Client_HC_Visit_Days AS
(
SELECT Client_Key, Source_System_ID,
       Srvc_Week,
       CAST( CASE WHEN Revenue_Category = ''HC'' THEN Days_Served
                  ELSE 0
             END
             AS INTEGER) AS HC_Days_Served
FROM (
       SELECT vis.Client_Key, 
              vis.Source_System_ID,
              cntrct.Revenue_Category,
              DATE_TRUNC( ''WEEK'', vis.Service_Date) AS Srvc_Week,
              COUNT( DISTINCT vis.Service_Date) AS Days_Served
       FROM HAH.Fact_Visit AS vis 
       INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Source_System_ID = cntrct.Source_System_ID AND vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
                                   /* AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' */ AND cntrct.Revenue_Category IN (''HC'') AND cntrct.Contract_Key IN (SELECT Contract_Key FROM REPORT.VW_DASHBOARD_CONTRACTS WHERE INCLUDE_FOR_EXEC_OPS_HOURS = TRUE OR INCLUDE_FOR_EXEC_OPS_CLIENTS = TRUE)
       WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
		AND vis.CONFIRMED_FLAG = ''YES'' --AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					  
       --AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
       GROUP BY vis.Client_Key, vis.Source_System_ID, Srvc_Week, cntrct.Revenue_Category
       ORDER BY vis.Client_Key, vis.Source_System_ID, Srvc_Week, cntrct.Revenue_Category
    ) x
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS CLIENT_COUNT, MIN( SRVC_WEEK), MAX( SRVC_WEEK), SUM( HC_Days_Served) FROM Client_HC_Visit_Days WHERE Source_System_ID IN (1,2); */ , 
Client_HH_Visit_Days AS
(
SELECT Client_Key, Source_System_ID,
       Srvc_Week,
       CAST( CASE WHEN Revenue_Category = ''HH'' THEN Days_Served
                  ELSE 0
             END
             AS INTEGER) AS HH_Days_Served
FROM (
       SELECT vis.Client_Key, 
              vis.Source_System_ID,
              cntrct.Revenue_Category,
              DATE_TRUNC( ''WEEK'', vis.Service_Date) AS Srvc_Week,
              COUNT( DISTINCT vis.Service_Date) AS Days_Served
       FROM HAH.Fact_Visit AS vis 
       INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Source_System_ID = cntrct.Source_System_ID AND vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
                                  /* AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' */ AND cntrct.Revenue_Category IN (''HH'') AND cntrct.Contract_Key IN (SELECT Contract_Key FROM REPORT.VW_DASHBOARD_CONTRACTS WHERE INCLUDE_FOR_EXEC_OPS_HOURS = TRUE OR INCLUDE_FOR_EXEC_OPS_CLIENTS = TRUE)
       WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
		AND vis.CONFIRMED_FLAG = ''YES'' --AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					  
       --AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
       GROUP BY vis.Client_Key, vis.Source_System_ID, Srvc_Week, cntrct.Revenue_Category
       ORDER BY vis.Client_Key, vis.Source_System_ID, Srvc_Week, cntrct.Revenue_Category
    ) x
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS CLIENT_COUNT, MIN( SRVC_WEEK), MAX( SRVC_WEEK), SUM( HH_Days_Served) FROM Client_HH_Visit_Days; */ ,
Client_Tenure_Metrics AS 
(
SELECT cmv.Client_Key,
       cmv.Source_System_ID,
       COUNT( cmv.Service_Week) AS Number_Weeks_with_Service,
       MIN( cmv.Service_Week) AS First_Service_Week,
       MAX( cmv.Service_Week) AS Last_Service_Week,
       DATEDIFF( ''MONTH'', First_Service_Week, Last_Service_Week) + 1 AS Tenure_In_Weeks,
       Tenure_In_Weeks - Number_Weeks_with_Service AS Number_Weeks_wo_Service
FROM Client_Weekly_Visits AS cmv
WHERE cmv.Number_of_Visits IS NOT NULL OR NVL( cmv.Invoice_Count, 0) > 0
GROUP BY cmv.Client_Key, cmv.Source_System_ID
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS CLIENT_COUNT, SUM( Number_Weeks_with_Service) FROM Client_Tenure_Metrics; */ ,
Client_Weekly_CLS_Visits AS
(
SELECT vis.Client_Key, 
       vis.Source_System_ID,
       DATE_TRUNC( ''WEEK'', vis.Service_Date) AS Service_Week,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_CLS_Visits,
       SUM( vis.Hours_Served) AS Sum_of_CLS_Hours_Served
FROM HAH.Fact_Visit AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Source_System_ID = cntrct.Source_System_ID AND vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
                 AND cntrct.Revenue_Category = ''CLS'' AND cntrct.Revenue_Subcategory_Code = ''RES'' -- AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' --AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					   
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
AND vis.Source_System_ID <> 1   -- Exclude Altrus CLS since it''s being calculated off of Revenue records
GROUP BY vis.Client_Key, vis.Source_System_ID, Service_Week
ORDER BY vis.Client_Key, vis.Source_System_ID, Service_Week
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS CLIENT_COUNT, SUM( Number_of_CLS_Visits), SUM( Sum_of_CLS_Hours_Served) FROM Client_Weekly_CLS_Visits; */ ,
Client_Weekly_HC_Visits AS
(
SELECT vis.Client_Key, 
       vis.Source_System_ID,
       DATE_TRUNC( ''WEEK'', vis.Service_Date) AS Service_Week,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_HC_Visits,
       SUM( vis.Hours_Served) AS Sum_of_HC_Hours_Served
FROM HAH.Fact_Visit AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Source_System_ID = cntrct.Source_System_ID AND vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
                AND cntrct.Revenue_Category = ''HC'' /* AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' */ AND cntrct.Contract_Key IN (SELECT Contract_Key FROM REPORT.VW_DASHBOARD_CONTRACTS WHERE INCLUDE_FOR_EXEC_OPS_HOURS = TRUE OR INCLUDE_FOR_EXEC_OPS_CLIENTS = TRUE)
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' --AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					   
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
--AND vis.Hours_Served >= 1
GROUP BY vis.Client_Key, vis.Source_System_ID, Service_Week
ORDER BY vis.Client_Key, vis.Source_System_ID, Service_Week
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS CLIENT_COUNT, SUM( Number_of_HC_Visits), SUM( Sum_of_HC_Hours_Served) FROM Client_Weekly_HC_Visits; */ ,
Client_Weekly_HH_Visits AS
(
SELECT vis.Client_Key, 
       vis.Source_System_ID,
       DATE_TRUNC( ''WEEK'', vis.Service_Date) AS Service_Week,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_HH_Visits,
       SUM( vis.Hours_Served) AS Sum_of_HH_Hours_Served
FROM HAH.Fact_Visit AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Source_System_ID = cntrct.Source_System_ID AND vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) 
                AND cntrct.Revenue_Category = ''HH'' /* AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE'' */ AND cntrct.Contract_Key IN (SELECT Contract_Key FROM REPORT.VW_DASHBOARD_CONTRACTS WHERE INCLUDE_FOR_EXEC_OPS_HOURS = TRUE OR INCLUDE_FOR_EXEC_OPS_CLIENTS = TRUE)
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' --AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					   
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
GROUP BY vis.Client_Key, vis.Source_System_ID, Service_Week
ORDER BY vis.Client_Key, vis.Source_System_ID, Service_Week
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS CLIENT_COUNT, SUM( Number_of_HH_Visits), SUM( Sum_of_HH_Hours_Served) FROM Client_Weekly_HH_Visits; */ ,
Client_Weekly_NA_Visits AS
(
SELECT vis.Client_Key, 
       vis.Source_System_ID,
       DATE_TRUNC( ''WEEK'', vis.Service_Date) AS Service_Week,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_NA_Visits,
       SUM( vis.Hours_Served) AS Sum_of_NA_Hours_Served
FROM HAH.Fact_Visit AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Source_System_ID = cntrct.Source_System_ID AND vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''NA'' -- AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' --AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					   
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
GROUP BY vis.Client_Key, vis.Source_System_ID, Service_Week
ORDER BY vis.Client_Key, vis.Source_System_ID, Service_Week
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS CLIENT_COUNT, SUM( Number_of_NA_Visits), SUM( Sum_of_NA_Hours_Served) FROM Client_Weekly_NA_Visits; */ ,
Client_Weekly_IS_Visits AS
(
SELECT vis.Client_Key, 
       vis.Source_System_ID,
       DATE_TRUNC( ''WEEK'', vis.Service_Date) AS Service_Week,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_IS_Visits,
       SUM( vis.Hours_Served) AS Sum_of_IS_Hours_Served
FROM HAH.Fact_Visit AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Source_System_ID = cntrct.Source_System_ID AND vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''IS'' -- AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' --AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					   
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
GROUP BY vis.Client_Key, vis.Source_System_ID, Service_Week
ORDER BY vis.Client_Key, vis.Source_System_ID, Service_Week
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS CLIENT_COUNT, SUM( Number_of_IS_Visits), SUM( Sum_of_IS_Hours_Served) FROM Client_Weekly_IS_Visits; */ ,
Client_Weekly_NS_Visits AS
(
SELECT vis.Client_Key, 
       vis.Source_System_ID,
       DATE_TRUNC( ''WEEK'', vis.Service_Date) AS Service_Week,
       CAST( COUNT( vis.Visit_Key) AS INTEGER) AS Number_of_NS_Visits,
       SUM( vis.Hours_Served) AS Sum_of_NS_Hours_Served
FROM HAH.Fact_Visit AS vis 
INNER JOIN HAH.DIM_Contract AS cntrct ON vis.Source_System_ID = cntrct.Source_System_ID AND vis.Contract_Key = cntrct.Contract_Key AND NVL( cntrct.Mileage_Flag, ''FALSE'') = ''FALSE'' AND UPPER( cntrct.Revenue_Subcategory_Name ) NOT LIKE ''%MILE%'' AND (NVL( vis.Bill_Rate, 1) >= 1 OR vis.Bill_Rate = 0) AND cntrct.Revenue_Category = ''NS'' -- AND NVL( cntrct.Billable_Flag, ''FALSE'') = ''TRUE''
WHERE vis.Service_Date BETWEEN (SELECT MIN( Calendar_Week) FROM Calendar_Weeks) AND (SELECT MAX( Calendar_Week) FROM Calendar_Weeks)
AND vis.CONFIRMED_FLAG = ''YES'' --AND NVL(vis.BILL_UNIT_TYPE, ''Hourly'') = ''Hourly''																					   
--AND vis.Status_Description IN (''Billed'', ''In Process'', ''Paid'', ''Confirmed'')
GROUP BY vis.Client_Key, vis.Source_System_ID, Service_Week
ORDER BY vis.Client_Key, vis.Source_System_ID, Service_Week
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS CLIENT_COUNT, SUM( Number_of_NS_Visits), SUM( Sum_of_NS_Hours_Served) FROM Client_Weekly_NS_Visits; */ ,
Client_Service_Line_Metrics AS
(
SELECT cm.Client_Key, cm.SOURCE_SYSTEM_ID, cm.SYSTEM_CODE, cm.Service_Week,
       CASE WHEN hccl.Number_of_HC_Visits IS NULL AND hhcl.Number_of_HH_Visits IS NULL AND (clscl.Number_of_CLS_Visits IS NULL OR NVL( arc.Invoice_Count, 0) = 0) THEN 0
            WHEN hccl.Number_of_HC_Visits IS NOT NULL AND hhcl.Number_of_HH_Visits IS NULL AND (clscl.Number_of_CLS_Visits IS NULL OR NVL( arc.Invoice_Count, 0) = 0) THEN 1
            WHEN hccl.Number_of_HC_Visits IS NULL AND hhcl.Number_of_HH_Visits IS NOT NULL AND (clscl.Number_of_CLS_Visits IS NULL OR NVL( arc.Invoice_Count, 0) = 0) THEN 1
            WHEN hccl.Number_of_HC_Visits IS NULL AND hhcl.Number_of_HH_Visits IS NULL AND (clscl.Number_of_CLS_Visits IS NOT NULL OR NVL( arc.Invoice_Count, 0) >= 1) THEN 1
            WHEN hccl.Number_of_HC_Visits IS NOT NULL AND hhcl.Number_of_HH_Visits IS NOT NULL AND (clscl.Number_of_CLS_Visits IS NULL OR NVL( arc.Invoice_Count, 0) = 0) THEN 2
            WHEN hccl.Number_of_HC_Visits IS NOT NULL AND hhcl.Number_of_HH_Visits IS NULL AND (clscl.Number_of_CLS_Visits IS NOT NULL OR NVL( arc.Invoice_Count, 0) >= 1) THEN 2
            WHEN hccl.Number_of_HC_Visits IS NULL AND hhcl.Number_of_HH_Visits IS NOT NULL AND (clscl.Number_of_CLS_Visits IS NOT NULL OR NVL( arc.Invoice_Count, 0) >= 1) THEN 2
            WHEN hccl.Number_of_HC_Visits IS NOT NULL AND hhcl.Number_of_HH_Visits IS NOT NULL AND (clscl.Number_of_CLS_Visits IS NOT NULL OR NVL( arc.Invoice_Count, 0) >= 1) THEN 3
       END AS Number_of_Service_Lines_Provided,
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
       cvdhc.HC_Days_Served,
       hccl.Number_of_HC_Visits,
       hccl.Sum_of_HC_Hours_Served,
       cvdhh.HH_Days_Served,
       hhcl.Number_of_HH_Visits,
       hhcl.Sum_of_HH_Hours_Served,
       clscl.Number_of_CLS_Visits,
       clscl.Sum_of_CLS_Hours_Served,
       arc.Invoice_Count AS CLS_Invoice_Count,
       nacl.Number_of_NA_Visits,
       nacl.Sum_of_NA_Hours_Served,
       iscl.Number_of_IS_Visits,
       iscl.Sum_of_IS_Hours_Served,
       nscl.Number_of_NS_Visits,
       nscl.Sum_of_NS_Hours_Served
FROM Client_Weeks AS cm
LEFT OUTER JOIN Client_Weekly_CLS_Visits AS clscl ON cm.Source_System_ID = clscl.Source_System_ID AND cm.Client_Key = clscl.Client_Key AND cm.Service_Week = clscl.Service_Week
LEFT OUTER JOIN Client_Weekly_HH_Visits AS hhcl ON cm.Source_System_ID = hhcl.Source_System_ID AND cm.Client_Key = hhcl.Client_Key AND cm.Service_Week = hhcl.Service_Week
LEFT OUTER JOIN Client_Weekly_HC_Visits AS hccl ON cm.Source_System_ID = hccl.Source_System_ID AND cm.Client_Key = hccl.Client_Key AND cm.Service_Week = hccl.Service_Week
LEFT OUTER JOIN Client_Weekly_NA_Visits AS nacl ON cm.Source_System_ID = nacl.Source_System_ID AND cm.Client_Key = nacl.Client_Key AND cm.Service_Week = nacl.Service_Week
LEFT OUTER JOIN Client_Weekly_IS_Visits AS iscl ON cm.Source_System_ID = iscl.Source_System_ID AND cm.Client_Key = iscl.Client_Key AND cm.Service_Week = iscl.Service_Week
LEFT OUTER JOIN Client_Weekly_NS_Visits AS nscl ON cm.Source_System_ID = nscl.Source_System_ID AND cm.Client_Key = nscl.Client_Key AND cm.Service_Week = nscl.Service_Week
LEFT OUTER JOIN Altrus_Revenue_Clients AS arc ON cm.Source_System_ID = arc.Source_System_ID AND cm.Client_Key = arc.Client_Key AND cm.Service_Week = arc.Revenue_Week
LEFT OUTER JOIN Client_HC_Visit_Days AS cvdhc ON cm.Source_System_ID = cvdhc.Source_System_ID AND cm.Client_Key = cvdhc.Client_Key AND cm.Service_Week = cvdhc.Srvc_Week
LEFT OUTER JOIN Client_HH_Visit_Days AS cvdhh ON cm.Source_System_ID = cvdhh.Source_System_ID AND cm.Client_Key = cvdhh.Client_Key AND cm.Service_Week = cvdhh.Srvc_Week
WHERE (hccl.Number_of_HC_Visits IS NOT NULL OR hhcl.Number_of_HH_Visits IS NOT NULL OR clscl.Number_of_CLS_Visits IS NOT NULL OR nacl.Number_of_NA_Visits IS NOT NULL OR iscl.Number_of_IS_Visits IS NOT NULL OR nscl.Number_of_NS_Visits IS NOT NULL OR arc.Invoice_Count IS NOT NULL OR NVL( cvdhc.HC_Days_Served, 0) <> 0 OR NVL( cvdhh.HH_Days_Served, 0) <> 0)
ORDER BY cm.Client_Key, cm.Source_System_ID, cm.Service_Week
) /* SELECT COUNT( DISTINCT CLIENT_KEY) FROM Client_Service_Line_Metrics; */, 
Client_Lag_Lead_Metrics AS -- Compute LAG and LEAD Metrics
(
SELECT cmv.Service_Week,
       cmv.Client_Key,
       cmv.Source_System_ID,
       cmv.Branch_Key,
       ctm.Number_Weeks_with_Service,
       ctm.First_Service_Week,
       ctm.Last_Service_Week,
       ctm.Tenure_In_Weeks,
       ctm.Number_Weeks_wo_Service,
       cmv.Number_of_Visits, 
       LAG( cmv.Number_of_Visits, 1, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Week) AS Previous_Week_Number_Of_Visits,
       LAG( cmv.Number_of_Visits, 2, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Week) AS Previous_2_Weeks_Number_Of_Visits,
       LEAD( cmv.Number_of_Visits, 1, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Week) AS Next_Week_Number_Of_Visits,
       LEAD( cmv.Number_of_Visits, 2, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Week) AS Next_2_Weeks_Number_Of_Visits,
       ROW_NUMBER() OVER (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Week) AS SeqNum,
       CASE WHEN NVL( cmv.Number_of_Visits, 0) <> 0 THEN ROW_NUMBER() OVER (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Week) ELSE NULL END AS SeqNum_Non_Gap,
       cmv.Sum_of_Hours_Received,
       LAG( cmv.Sum_of_Hours_Received, 1, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Week) AS Previous_Week_Sum_of_Hours_Received,
       LAG( cmv.Sum_of_Hours_Received, 2, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Week) AS Previous_2_Weeks_Sum_of_Hours_Received,
       LEAD( cmv.Sum_of_Hours_Received, 1, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Week) AS Next_Week_Sum_of_Hours_Received,
       LEAD( cmv.Sum_of_Hours_Received, 2, 0) over (PARTITION BY cmv.Client_Key ORDER BY cmv.Service_Week) AS Next_2_Weeks_Sum_of_Hours_Received,
       CASE WHEN NVL( cmv.Sum_of_Hours_Received, 0) <> 0 OR NVL( cmv.Invoice_Count, 0) > 0 THEN ''TRUE''
            ELSE ''FALSE''
       END AS Active_Flag,
       CASE WHEN ctm.First_Service_Week < cmv.Service_Week AND NVL( Previous_Week_Sum_of_Hours_Received, 0) = 0 AND NVL( cmv.Sum_of_Hours_Received, 0) > 0 THEN ''TRUE''
            ELSE ''FALSE''
       END AS Reactivated_Flag
FROM Client_Weekly_Visits AS cmv
LEFT OUTER JOIN Client_Tenure_Metrics AS ctm ON cmv.Source_System_Id = ctm.Source_System_ID AND cmv.Client_Key = ctm.Client_Key
WHERE cmv.Service_Week BETWEEN ctm.First_Service_Week AND DATEADD( ''WEEK'', 1, ctm.Last_Service_Week)
ORDER BY cmv.Client_Key, cmv.Service_Week
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS CLIENT_COUNT FROM Client_Lag_Lead_Metrics; */ ,
Compute_Client_Max_Min_Gap AS
(
SELECT x.Client_Key,x.Source_System_ID,
       COUNT( Continuous_Weeks_wo_Service) AS Number_of_Gaps_in_Service,
       MIN( Continuous_Weeks_wo_Service) AS Smallest_Gap_in_Service,
       MAX( Continuous_Weeks_wo_Service) AS Largest_Gap_in_Service
FROM
(
SELECT cllm.Client_Key,
       cllm.Source_System_ID,
       cllm.SeqNum,
       cllm.SeqNum_Non_Gap,
       (SELECT MIN(cllm2.SeqNum_Non_Gap) FROM Client_Lag_Lead_Metrics AS cllm2 WHERE cllm2.Client_Key = cllm.Client_Key AND cllm2.SeqNum_Non_Gap > cllm.SeqNum_Non_Gap) - 1 AS EndSeqNum,
       EndSeqNum - cllm.SeqNum_Non_Gap AS Continuous_Weeks_wo_Service
FROM Client_Lag_Lead_Metrics AS cllm
WHERE NOT EXISTS ( SELECT * FROM Client_Lag_Lead_Metrics AS cllm3 
                   WHERE cllm3.Client_Key = cllm.Client_Key
                   AND cllm3.SeqNum_Non_Gap = cllm.SeqNum_Non_Gap + 1)
AND cllm.SeqNum_Non_Gap IS NOT NULL    
AND EndSeqNum IS NOT NULL
ORDER BY cllm.Client_Key, cllm.SeqNum
) x
GROUP BY x.Client_Key,x.Source_System_ID
ORDER BY x.Client_Key
) /* SELECT COUNT( DISTINCT CLIENT_KEY) AS CLIENT_COUNT FROM Compute_Client_Max_Min_Gap; */
SELECT cllm.SERVICE_WEEK, 
       cllm.Client_KEY, 
       cllm.SOURCE_SYSTEM_ID, 
       cllm.Branch_Key AS Branch_Key,
       br.Detailed_Office_Name AS Office_Name,
       br.Office_State_Code AS Office_State_Code,
       cl.Referral_Date AS Referral_Date,
       cl.Client_State_Code,
       cllm.FIRST_SERVICE_WEEK AS Lifetime_First_Service_Week,
       cllm.LAST_SERVICE_WEEK AS Lifetime_Last_Service_Week,
       CAST( cllm.TENURE_IN_WEEKS AS INTEGER) AS Lifetime_Tenure_In_Weeks, 
       CAST( cllm.NUMBER_WEEKS_WITH_SERVICE AS INTEGER) AS Lifetime_NUMBER_WEEKS_WITH_SERVICE, 
       CAST( cllm.NUMBER_WEEKS_WO_SERVICE AS INTEGER) AS Lifetime_Number_Weeks_wo_Service, 
       CAST( NVL( ccmmg.Number_of_Gaps_In_Service, 0) AS INTEGER) AS Lifetime_Number_of_Gaps_In_Service, 
       CAST( ccmmg.Smallest_Gap_In_Service AS INTEGER) AS Lifetime_Smallest_Gap_In_Service, 
       CAST( ccmmg.Largest_Gap_In_Service AS INTEGER) AS Lifetime_Largest_Gap_In_Service,
       CAST( CASE WHEN cllm.FIRST_SERVICE_WEEK = cllm.SERVICE_WEEK THEN ''TRUE''
                  ELSE ''FALSE''
             END 
            AS BOOLEAN) AS New_Client_Flag,
       CAST( CASE WHEN NVL( cllm.Number_of_Visits, 0) = 0 AND NVL( cllm.Previous_Week_Number_of_Visits, 0) <> 0 THEN ''TRUE''
                  ELSE ''FALSE''
             END
            AS BOOLEAN) AS First_Week_Inactive_Flag,
       CAST( cllm.ACTIVE_FLAG AS BOOLEAN) AS Active_Flag, 
       CAST( REACTIVATED_FLAG AS BOOLEAN) AS Reactivated_Flag,
       CAST( cslm.Number_of_Service_Lines_Provided AS INTEGER) AS Number_of_Service_Lines_Provided,     
       CAST( cslm.HC_Contract_Services_Provided AS BOOLEAN) AS HC_Service_Line_Provided,
       CAST( cslm.HH_Contract_Services_Provided AS BOOLEAN) AS HH_Service_Line_Provided,
       CAST( cslm.CLS_Contract_Services_Provided AS BOOLEAN) AS CLS_Service_Line_Provided,
       CAST( cslm.NA_Contract_Services_Provided AS BOOLEAN) AS NA_Service_Line_Provided,
       CAST( cslm.IS_Contract_Services_Provided AS BOOLEAN) AS IS_Service_Line_Provided,
       CAST( cslm.NS_Contract_Services_Provided AS BOOLEAN) AS NS_Service_Line_Provided,
       cllm.NUMBER_OF_VISITS, cllm.PREVIOUS_WEEK_NUMBER_OF_VISITS, cllm.PREVIOUS_2_WEEKS_NUMBER_OF_VISITS, cllm.NEXT_WEEK_NUMBER_OF_VISITS, cllm.NEXT_2_WEEKS_NUMBER_OF_VISITS, 
       CAST( cllm.SUM_OF_HOURS_Received AS NUMBER( 9,3)) AS Sum_Of_Hours_Received, 
       CAST( cllm.PREVIOUS_WEEK_SUM_OF_HOURS_ReceiveD AS NUMBER( 9,3)) AS Previous_Week_Sum_of_Hours_Received, 
       CAST( cllm.PREVIOUS_2_WEEKS_SUM_OF_HOURS_ReceiveD AS NUMBER( 9,3)) AS Previous_2_Weeks_Sum_of_Hours_Received, 
       CAST( cllm.NEXT_WEEK_SUM_OF_HOURS_ReceiveD AS NUMBER( 9,3)) AS Next_Weeks_Sum_Of_Hours_Received, 
       CAST( cllm.NEXT_2_WEEKS_SUM_OF_HOURS_ReceiveD AS NUMBER( 9,3)) AS Next_2_Weeks_Sum_of_Hours_Received,
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
       CAST( NVL( cslm.Sum_of_NS_Hours_Served, 0) AS NUMBER( 9,3)) AS Sum_of_NS_Hours_Served
FROM Client_Lag_Lead_Metrics AS cllm
LEFT OUTER JOIN Compute_Client_Max_Min_Gap AS ccmmg ON cllm.Source_System_ID = ccmmg.Source_System_ID AND cllm.Client_Key = ccmmg.Client_Key
LEFT OUTER JOIN Client_Service_Line_Metrics AS cslm ON cllm.Source_System_ID = cslm.Source_System_ID AND cllm.Client_Key = cslm.Client_Key AND cllm.Service_Week = cslm.Service_Week
LEFT OUTER JOIN HAH.DIM_Branch AS br ON br.Branch_Key = cllm.Branch_Key
LEFT OUTER JOIN HAH.DIM_Client AS cl ON cl.Client_Key = cllm.Client_Key
WHERE cllm.Service_Week BETWEEN cllm.First_Service_Week AND DATEADD( ''WEEK'', 1, cllm.Last_Service_Week)
ORDER BY cllm.Client_Key, cllm.Service_Week;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';