CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_PAYROLL_EMPLOYEE_DERIVED_WEEKLY_METRICS("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
  RETURN_RESULT VARCHAR(1000);
BEGIN

--*****************************************************************************************************************************
-- NAME:  GET_REPORT_PAYROLL_EMPLOYEE_DERIVED_WEEKLY_METRICS
--
-- PURPOSE: Creates derived weekly metrics for each employee based on payroll data - using from 2022 year as asked by natalie
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------    -------------------   ------------------------------------------------------------------------------------------
-- --			Divesh Aneja			Initial development
-- 12/13/23		Saurav Purohit			Added logic for Acquired System field
--*****************************************************************************************************************************

INSERT OVERWRITE INTO REPORT.PAYROLL_EMPLOYEE_DERIVED_WEEKLY_METRICS
-- dummy/test employees in all payroll systems +
-- employees with pay_periods <> 7 or pay_hours=0 or viventium records 
WITH Bill_Only_Employees AS 
(
SELECT distinct EMPLOYEE_KEY 
FROM HAH.DIM_EMPLOYEE AS emp	
WHERE ((UPPER( Employee_First_Name) LIKE ''%BILL%'' AND UPPER( Employee_Last_Name) LIKE ''%ONLY%'')
OR UPPER( Employee_First_Name) LIKE ANY ( ''%BILL%ONLY%'', ''%FIELD%STAFF%'', ''%CAREGIVER%'', ''%TEST%PROFILE%'', ''%IMPLEMENT%'', ''%EMPLOYEE%'', ''%DO%NOT%USE%'', ''%OFFICE%'')
OR UPPER( Employee_Last_Name) LIKE ANY ( ''%BILL%ONLY%'', ''%FIELD%STAFF%'', ''%CAREGIVER%'', ''%TEST%PROFILE%'', ''%IMPLEMENT%'', ''%EMPLOYEE%'', ''%DO%NOT%USE%'', ''%OFFICE%'')
OR UPPER( Employee_First_Name) = ''TEST''
OR UPPER( Employee_Last_Name) = ''TEST'') AND SOURCE_SYSTEM_ID IN (11,5,6,10,18,21,22,31,34)
UNION 
SELECT DISTINCT EMPLOYEE_KEY    	
   FROM INTEGRATION.Fact_payroll_merged
  WHERE YEAR(PAYROLL_DATE) >= 2022
    AND datediff(''day'',PAY_PERIOD_START_DATE,PAY_PERIOD_END_DATE)+1 <> 7
    AND SOURCE_SYSTEM_ID <> 34
UNION 
SELECT DISTINCT EMPLOYEE_KEY    	
   FROM INTEGRATION.Fact_payroll_merged
  WHERE SOURCE_SYSTEM_ID = 34
)
,
												-- get all weeks starting 2022
Calendar_Weeks AS  
(
	SELECT HAH_CURRENT_WEEK_FIRST_DAY AS Calendar_Week_First_Day
    FROM HAH.DIM_DATE
												-- used 2 jan here as 01st jan would lead to go back to last sunday(26-12-2021)
    WHERE Calendar_Date BETWEEN CAST( ''2022-01-02'' AS DATE) AND CURRENT_DATE()			
	GROUP BY 1
    ORDER BY 1
)
,
												-- Get a list of all employees who got payrolled within the calendar weeks 
Emp_List AS  
(
    SELECT DISTINCT  vis.EMPLOYEE_KEY 
	FROM INTEGRATION.Fact_payroll_merged AS vis
	JOIN INTEGRATION.DIM_EMPLOYEE_PAYROLL_MERGE_DEDUPE epmd
		ON vis.EMPLOYEE_KEY  = epmd.EMPLOYEE_KEY
		AND  EPMD.ORIGINAL_EMPLOYEE_KEY =  EPMD.EMPLOYEE_KEY
    where vis.payroll_date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks)
    							AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
    AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
    AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees) 
)
,
												-- Create a list of all week-employee beginning 2022
Emp_Weeks AS  
(
SELECT cw.Calendar_Week_First_Day AS Payroll_Week,
       el.Employee_Key
FROM Calendar_Weeks AS cw
FULL OUTER JOIN Emp_List AS el
WHERE cw.Calendar_Week_First_Day IS NOT NULL
ORDER BY el.Employee_Key, cw.Calendar_Week_First_Day
)
,
												-- Compile metrics for every week the employee gets payroll
Emp_payrolled AS  
(
SELECT vis.Employee_Key,  
	   dt.HAH_CURRENT_WEEK_FIRST_DAY AS Payroll_Week,
	   sum(vis.PAY_HOURS) AS pay_hours,
	   sum(vis.SERVICE_HOURS) AS service_hours,
	   sum(vis.OVERTIME_HOURS) AS OVERTIME_HOURS,
	   sum(vis.UNION_DUES_AMOUNT) AS UNION_DUES_AMOUNT 
FROM INTEGRATION.fact_payroll_merged AS vis 
INNER JOIN HAH.DIM_DATE DT 
	ON DT.CALENDAR_dATE = VIS.payroll_DATE
LEFT OUTER JOIN HAH.DIM_BRANCH AS brnch2
	on brnch2.Branch_Key = vis.Branch_Key
WHERE vis.payroll_date BETWEEN (SELECT MIN( Calendar_Week_First_Day) FROM Calendar_Weeks)
							AND (SELECT MAX( Calendar_Week_First_Day) FROM Calendar_Weeks)
AND vis.original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)	
GROUP BY vis.EMPLOYEE_KEY,Payroll_Week 
)
,
												--find a single record for employee-branch per week
emp_branch AS 
(
SELECT DISTINCT b.employee_key,					-- KEEP DISTINCT
       b.payroll_week,
       b.BRANCH_KEY AS branch_key,
       brnch.Branch_Name,
       brnch.Office_State_Code AS Branch_State_Code
FROM
												--find latest branch_key for employee per week
    (SELECT vis.employee_key,
            date_trunc(week,PAYROLL_DATE)-1 AS payroll_week,
            FIRST_Value(vis.Branch_Key) OVER (PARTITION BY vis.employee_key,payroll_week ORDER BY PAYROLL_DATE desc ) AS branch_key 
       FROM INTEGRATION.fact_payroll_merged vis
      WHERE EMPLOYEE_KEY IN (SELECT EMPLOYEE_KEY FROM emp_list)
    ) b
LEFT OUTER JOIN HAH.DIM_BRANCH AS brnch 
             on b.branch_Key = brnch.branch_Key
--GROUP BY b.employee_key,b.payroll_week,brnch.Branch_Name,brnch.Office_State_Code
ORDER BY b.employee_key,b.payroll_week
)
,
												--find first and last payroll week for a employee
first_last_payroll_week AS 
(
SELECT date_trunc(''week'',min(PAYROLL_DATE))-1 AS first_payroll_week,
       date_trunc(''week'',max(PAYROLL_DATE))-1 AS last_payroll_week,
	   EMPLOYEE_KEY  
FROM INTEGRATION.Fact_payroll_merged vis
INNER JOIN HAH.DIM_DATE DT
	ON DT.CALENDAR_dATE = VIS.payroll_DATE
WHERE payroll_date BETWEEN (SELECT MIN(Calendar_Week_First_Day) FROM Calendar_Weeks) 
					AND (SELECT MAX(Calendar_Week_First_Day) FROM Calendar_Weeks) 
GROUP BY EMPLOYEE_key
)
,
training_hours AS 
(
SELECT sum(fpdm.NUMBER_OF_UNITS) AS training_hours_units,
        EMPLOYEE_KEY, 
        date_trunc(week,PAYROLL_DATE)-1 AS payroll_week
   FROM INTEGRATION.FACT_PAYROLL_DETAILS_MERGED fpdm
  WHERE PAY_CODE_DESCRIPTION like ''%Train%''
   AND  payroll_date BETWEEN (SELECT MIN(Calendar_Week_First_Day) FROM Calendar_Weeks) 
   						AND (SELECT MAX(Calendar_Week_First_Day) FROM Calendar_Weeks)
GROUP BY EMPLOYEE_KEY,payroll_week  
)
,
payroll_week_count AS 
(
SELECT count(DISTINCT PAYROLL_date) AS count_of_weeks_with_payroll, employee_key 
FROM   INTEGRATION.FACT_PAYROLL_MERGED
WHERE PAY_HOURS > 0 
 AND  payroll_date BETWEEN (SELECT MIN(Calendar_Week_First_Day) FROM Calendar_Weeks)
 						AND (SELECT MAX(Calendar_Week_First_Day) FROM Calendar_Weeks)
GROUP BY EMPLOYEE_KEY 
)
,
emp_payroll_gap AS 
(
SELECT count(gap) AS number_of_gaps_in_payroll,
       min(gap_in_weeks) AS smallest_gap_in_payroll,
       max(gap_in_weeks) AS largest_gap_in_payroll,
       employee_key
FROM  (SELECT CASE WHEN datediff(''day'',ep.Payroll_Week,lead(ep.Payroll_Week,1) over(PARTITION BY ep.employee_key ORDER BY ep.Payroll_Week)) >7
                   THEN 0
                   ELSE 1
               END AS  gap,
               								--did -1 here below. example: gap of 2 means payroll of 1 week was not done in between.
               datediff(''week'',ep.Payroll_Week,lead(ep.Payroll_Week,1) over(PARTITION BY ep.employee_key ORDER BY ep.Payroll_Week))-1 AS gap_in_weeks,
               employee_key,
               payroll_week
         FROM  Emp_payrolled ep
       ) b
WHERE b.gap=0
GROUP BY employee_key
)
,emp_metrics AS 
(
SELECT ep.Payroll_Week,
       DATEADD( ''DAY'', 6, ep.payroll_Week) AS Payroll_Week_End_Date,
	   ew.employee_Key,
       eb.Branch_Key,
       eb.Branch_Name,
       eb.Branch_State_Code,
       flpw.first_payroll_week,
       DATEADD( ''DAY'', 6, flpw.first_payroll_week) AS first_payroll_Week_End_Date,
       flpw.last_payroll_week,
       DATEADD( ''DAY'', 6, flpw.last_payroll_week) AS last_payroll_Week_End_Date,
       datediff(''week'',first_payroll_week,last_payroll_Week)+1 AS tenure_in_weeks,
       pwc.count_of_weeks_with_payroll AS number_of_weeks_with_payroll,
       tenure_in_weeks - number_of_weeks_with_payroll AS number_of_weeks_without_payroll,
       epg.number_of_gaps_in_payroll,
       epg.smallest_gap_in_payroll,
       epg.largest_gap_in_payroll,
       lag(ep.Payroll_Week,1) over(PARTITION BY ew.employee_key ORDER BY ep.Payroll_Week) AS previous_payroll_week,
       lead(ep.Payroll_Week,1) over(PARTITION BY ew.employee_key ORDER BY ep.Payroll_Week) AS next_payroll_week,
       ep.pay_hours AS total_hours_paid,
       lag(ep.pay_hours,1) over(PARTITION BY ew.employee_key ORDER BY ep.Payroll_Week) AS previous_week_total_hours_paid,
       lag(ep.pay_hours,2) over(PARTITION BY ew.employee_key ORDER BY ep.Payroll_Week) AS previous_2_week_total_hours_paid,
       lead(ep.pay_hours,1) over(PARTITION BY ew.employee_key ORDER BY ep.Payroll_Week) AS next_week_total_hours_paid,
       lead(ep.pay_hours,2) over(PARTITION BY ew.employee_key ORDER BY ep.Payroll_Week) AS next_2_week_total_hours_paid,
       ep.service_hours AS billable_hours,
       th.training_hours_units AS training_hours_paid,
       case when ep.pay_hours <> 0 
            then true
            else false
        end as active_flag,
       ep.overtime_hours AS OT,
       CASE WHEN ep.UNION_DUES_AMOUNT <> 0 
            THEN TRUE
            ELSE FALSE 
        END AS UNION_flag 
FROM Emp_Weeks AS ew
JOIN Emp_payrolled AS ep ON ew.payroll_Week = ep.Payroll_Week AND ew.Employee_Key = ep.Employee_Key
LEFT OUTER JOIN first_last_payroll_week flpw ON flpw.employee_key = ew.employee_key 
LEFT JOIN training_hours th ON th.employee_key = ep.employee_key AND th.payroll_week = ep.payroll_week
LEFT JOIN payroll_week_count pwc ON pwc.Employee_Key = ew.Employee_Key
LEFT JOIN emp_branch eb ON eb.employee_key = ep.employee_key AND eb.payroll_week = ep.payroll_week
LEFT JOIN emp_payroll_gap epg ON ep.employee_key = epg.employee_key
WHERE ew.Employee_Key NOT IN (SELECT Employee_Key FROM Bill_Only_Employees)
ORDER BY ew.Employee_Key,ep.payroll_week
)
,												-- Using FACT EMPLOYEE ACQUIRED & AMS PAYROLL mapping TO GET the Acquisition NAME FOR the employee
AQUISITION AS 
(
SELECT DISTINCT APM.PAYROLL_SYSTEM_CODE , APM.AMS_SYSTEM_CODE
, APM.PAYROLL_EMPLOYEE_KEY, E.EMPLOYEE_KEY AS AMS_EMPLOYEE_KEY
, E.AQUISITION_NAME
, E.SERVICE_WEEK 
,FIRST_VALUE(E.AQUISITION_NAME) OVER (PARTITION BY E.EMPLOYEE_KEY, E.SERVICE_WEEK ORDER BY IFF(E.EMPLOYEE_KEY = E.ORIGINAL_EMPLOYEE_KEY,0,1))
	AS ACQUIRED_SYSTEM		-- IN CASE OF getting MORE than one Acquisition NAME FOR an employee per week IN Fact emp acquired, we ARE picking employees
							-- latest system record where original emp key & emp key will be same. Ideally we would want to join service branch key from acquired
							-- table with payrolled branch to get correct acquisition name for that particular payrolled branch, however that is not possible so using latest system logic just to pick one record
FROM
INTEGRATION.FACT_AMS_PAYROLL_MAPPING APM
JOIN HAH.FACT_EMPLOYEE_ACQUIRED_WEEKLY E ON APM.AMS_EMPLOYEE_KEY = E.EMPLOYEE_KEY
WHERE E.AQUISITION_NAME IS NOT NULL
--QUALIFY ACQUIRED_SYSTEM <> E.AQUISITION_NAME 		-- 5.6M records have NO effect OF above FIRST value logic. ONLY 5k records ARE there 
 													-- WHERE aquisition NAME will be picked FROM FIRST value logic. The end result matches with ams emp derived 
 													-- structure as acquisition names for 98% emps will match between Ams emp derived & payroll emp derived structures
)
,AQUISITION_SERVICE_WEEK AS 
(
SELECT PAYROLL_EMPLOYEE_KEY					
, IFF(ACQUIRED_SYSTEM IN (''EDISON'',''PREFERRED''),NULL,UPPER(NVL(ACQUIRED_SYSTEM,''''))) AS ACQUIRED_SYSTEM 	-- Many employees perform services TO clients OF preferred 
											-- & edison BOTH IN same period so we would GET BOTH VALUES causing duplicates. Avoiding this by taking default
											-- value of Acquired system field from dim employee for Empeon.
--
, MIN(SERVICE_WEEK) AS FIRST_SERVICE_WEEK 	-- after a point OF time, acquistion value can CHANGE, e.g clearcare TO axxess so deriving a RANGE OF weeks.. 
, MAX(SERVICE_WEEK) AS LAST_SERVICE_WEEK	-- ..for EACH employee per acquistion. Further, Service week cannot be directly joined with payroll week & bringing
											-- pay period start & end date would complicate logic so instead using this range and joining if payroll 
											-- week falls within a range of weeks, then that acquisition is selected. 
FROM AQUISITION GROUP BY 1,2
)
--
,
AQUISITION_FINAL AS 				-- TO avoid ANY other CASE OF overlapping RANGE which causes duplicate records WITH multiple acquisition FOR same emp IN same week
(									-- Currently ONLY one employee IS HAVING overlapping RANGE causing BOTH Meridius & Opensystems aquisition TO SHOW up IN same payroll week
SELECT E.EMPLOYEE_KEY, E.PAYROLL_WEEK
, FIRST_VALUE(ASW.ACQUIRED_SYSTEM)OVER(PARTITION BY E.EMPLOYEE_KEY, E.PAYROLL_WEEK ORDER BY ASW.LAST_SERVICE_WEEK DESC) AS ACQUIRED_SYSTEM  
FROM emp_metrics E 
JOIN AQUISITION_SERVICE_WEEK ASW 
ON E.EMPLOYEE_KEY = ASW.PAYROLL_EMPLOYEE_KEY 
AND  E.Payroll_Week BETWEEN ASW.FIRST_SERVICE_WEEK AND ASW.LAST_SERVICE_WEEK
WHERE ASW.ACQUIRED_SYSTEM IS NOT NULL
)
--
SELECT distinct emet.Payroll_Week,
       emet.Payroll_Week_End_Date,
	   emet.employee_Key,
       emp.source_system_id,
       FIRST_VALUE(emp.Original_Source_System_Id) OVER (PARTITION BY emet.Employee_Key ORDER BY IFF(emp.Original_Source_System_ID <> emp.Source_System_ID, 0, 1)) AS Original_Source_System_ID, 
	   emp.employee_ID,  
       emp.System_Code, 
	   emp.Employee_PID, 
	   emp.Employee_Number, 
	   emp.Payroll_ID,
       emp.Employee_Category,
       CASE WHEN emp.CASE_MANAGER_FLAG = TRUE THEN ''ADMIN'' 
       ELSE UPPER(emp.Employee_Category) 
       END AS Derived_Employee_Category,
       emp.EMPLOYEE_FIRST_NAME,
       emp.EMPLOYEE_LAST_NAME,
       emp.EMPLOYEE_DOB,
       emp.EMPLOYEE_GENDER,
       emp.EMPLOYEE_ETHNICITY, 
       emet.Branch_Key,
       emet.Branch_Name,
       emet.Branch_State_Code,
       emet.first_payroll_week,
       emet.first_payroll_Week_End_Date,
       emet.last_payroll_week,
       emet.last_payroll_Week_End_Date,
       emet.tenure_in_weeks,
       emet.number_of_weeks_with_payroll,
       emet.number_of_weeks_without_payroll,
       emet.number_of_gaps_in_payroll,
       emet.smallest_gap_in_payroll,
       emet.largest_gap_in_payroll,
       emet.previous_payroll_week,
       emet.next_payroll_week,
       emet.total_hours_paid,
       emet.previous_week_total_hours_paid,
       emet.previous_2_week_total_hours_paid,
       emet.next_week_total_hours_paid,
       emet.next_2_week_total_hours_paid,
       emet.billable_hours,
       emet.training_hours_paid,
       emet.active_flag,
       emet.OT,
       emet.UNION_flag,    
       emp.EXEMPT_FLAG AS exempt_flag, 
       emp.EMPLOYEE_TYPE,
       COALESCE(CCSI_ACQUIRED_EMPLOYEE.ACQUIRED_SYSTEM, AQ.ACQUIRED_SYSTEM, emp.acquired_system) AS acquired_system_name ,
     -- COALESCE(AQ.AQUISITION_NAME, emp.acquired_system) AS acquired_system_name ,
     -- COALESCE(emp.acquired_system, AQ.AQUISITION_NAME) AS acquired_system_name ,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
        :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
        	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
			CURRENT_USER as ETL_INSERTED_BY ,
			convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
			CURRENT_USER as ETL_LAST_UPDATED_BY,
			0 as ETL_DELETED_FLAG
FROM emp_metrics AS emet
LEFT OUTER JOIN INTEGRATION.DIM_EMPLOYEE_PAYROLL_MERGE_DEDUPE AS emp
	ON emet.Employee_Key = emp.Employee_Key
LEFT JOIN AQUISITION_FINAL AQ 
	ON AQ.EMPLOYEE_KEY = EMET.EMPLOYEE_KEY  
	AND AQ.Payroll_Week = EMET.PAYROLL_WEEK
LEFT OUTER JOIN (SELECT PAYROLL_EMPLOYEE_KEY, ACQUIRED_SYSTEM  FROM AQUISITION_SERVICE_WEEK WHERE ACQUIRED_SYSTEM = ''CCSI'') CCSI_ACQUIRED_EMPLOYEE
          ON CCSI_ACQUIRED_EMPLOYEE.PAYROLL_EMPLOYEE_KEY = emet.EMPLOYEE_KEY 
          AND emet.payroll_week >= ''2021-07-01'';
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    ';