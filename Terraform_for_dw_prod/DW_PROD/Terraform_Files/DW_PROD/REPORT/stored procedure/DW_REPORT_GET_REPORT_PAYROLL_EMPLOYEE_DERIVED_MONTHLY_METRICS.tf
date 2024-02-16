resource "snowflake_procedure" "DW_REPORT_GET_REPORT_PAYROLL_EMPLOYEE_DERIVED_MONTHLY_METRICS" {
	name ="GET_REPORT_PAYROLL_EMPLOYEE_DERIVED_MONTHLY_METRICS"
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
  RETURN_RESULT VARCHAR(1000);
BEGIN
    -- PAYROLL EMPLOYEE DERIVED MONTHLY METRICS
--*****************************************************************************************************************************
-- NAME:  PAYROLL_EMPLOYEE_DERIVED_MONTHLY_METRICS
--
-- PURPOSE: Creates derived monthly metrics for each employee based on payroll
--
-- DEVELOPMENT LOG:
-- DATE			AUTHOR					NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- --			Divesh Aneja			Initial development
-- 12/13/23		Saurav Purohit			Added logic for Acquired System field
--*****************************************************************************************************************************

INSERT OVERWRITE INTO REPORT.PAYROLL_EMPLOYEE_DERIVED_MONTHLY_METRICS

												--employees to exclude
WITH Bill_Only_Employees AS
(
SELECT DISTINCT EMPLOYEE_KEY 
FROM HAH.DIM_Employee AS emp
WHERE ((UPPER( Employee_First_Name) LIKE ''%BILL%'' AND UPPER( Employee_Last_Name) LIKE ''%ONLY%'')
OR UPPER( Employee_First_Name) LIKE ANY ( ''%BILL%ONLY%'', ''%FIELD%STAFF%'', ''%CAREGIVER%'', ''%TEST%PROFILE%'', ''%IMPLEMENT%'', ''%EMPLOYEE%'', ''%DO%NOT%USE%'', ''%OFFICE%'')
OR UPPER( Employee_Last_Name) LIKE ANY ( ''%BILL%ONLY%'', ''%FIELD%STAFF%'', ''%CAREGIVER%'', ''%TEST%PROFILE%'', ''%IMPLEMENT%'', ''%EMPLOYEE%'', ''%DO%NOT%USE%'', ''%OFFICE%'')
OR UPPER( Employee_First_Name) = ''TEST''
OR UPPER( Employee_Last_Name) = ''TEST'') AND SOURCE_SYSTEM_ID IN (11,5,6,10,18,21,22,31,34)
--ORDER BY Primary_Branch_State, Primary_Branch_Key
UNION 
												--exclude the employees with unusual pay periods starting year 2022
SELECT DISTINCT EMPLOYEE_KEY    	
   FROM INTEGRATION.Fact_payroll_merged
  WHERE YEAR(PAYROLL_DATE) >= 2022
    AND datediff(''day'',PAY_PERIOD_START_DATE,PAY_PERIOD_END_DATE)+1 > 14
),
												--get calendar months for all months
Calendar_Months AS  
(
	SELECT DATE_TRUNC(MONTH,CALENDAR_DATE) AS Calendar_Month
    FROM HAH.DIM_DATE
    WHERE CALENDAR_DATE BETWEEN CAST(''2022-01-01'' AS DATE) AND CURRENT_DATE()
	GROUP BY 1
	ORDER BY 1
),
												--Get a list of employees who got payroll between maximum and minimum payroll months
Emp_List AS  
(
    SELECT DISTINCT vis.Employee_Key
	FROM   INTEGRATION.Fact_payroll_merged AS vis	
    WHERE  vis.payroll_date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
    AND    vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
    AND    vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
),
												-- Compile metrics for every month the employee gets payroll
emp_payrolled AS  
(
SELECT vis.employee_key,
	   DATE_TRUNC(''MONTH'',vis.payroll_date) AS payroll_month,
	   sum(vis.PAY_HOURS) as total_hours_paid,
	   sum(vis.SERVICE_HOURS) AS billable_hours,
	   sum(vis.OVERTIME_HOURS) as OT,
	   sum(vis.UNION_DUES_AMOUNT) AS total_union_dues_amount
FROM INTEGRATION.fact_payroll_merged AS vis 
WHERE EMPLOYEE_KEY IN (SELECT EMPLOYEE_KEY FROM emp_list)
AND vis.payroll_date BETWEEN (SELECT MIN(Calendar_Month) FROM Calendar_Months) AND (SELECT MAX(Calendar_Month) FROM Calendar_Months)
group by vis.Employee_Key,payroll_month
order BY vis.EMPLOYEE_KEY, payroll_month	
)
												--find a single record for employee per month
,emp_branch AS 
(
SELECT DISTINCT b.employee_key,
       b.payroll_month,
       b.BRANCH_KEY AS branch_key,
       brnch.Branch_Name,
       brnch.Office_State_Code AS Branch_State_Code
FROM
												--find latest branch_key for employee per month
    (SELECT vis.employee_key,
            date_trunc(MONTH,PAYROLL_DATE) AS payroll_month,
            FIRST_Value(vis.Branch_Key) OVER (PARTITION BY vis.employee_key,payroll_month ORDER BY PAYROLL_DATE  desc ) AS branch_key 
       FROM INTEGRATION.fact_payroll_merged vis
      WHERE EMPLOYEE_KEY IN (SELECT EMPLOYEE_KEY FROM emp_list)
    ) b
LEFT OUTER JOIN HAH.DIM_BRANCH AS brnch 
             on b.branch_Key = brnch.branch_Key
--GROUP BY b.employee_key,b.payroll_month,brnch.Branch_Name,brnch.Office_State_Code
ORDER BY b.employee_key,b.payroll_month
)
,
												-- find latest and first payroll month for each employee
first_last_payroll_month AS 
(
SELECT date_trunc(MONTH,min(PAYROLL_DATE)) AS first_payroll_month,
       date_trunc(MONTH,max(PAYROLL_DATE)) AS last_payroll_month,
	   EMPLOYEE_KEY   
FROM INTEGRATION.Fact_payroll_merged vis
WHERE EMPLOYEE_KEY IN (SELECT EMPLOYEE_KEY FROM emp_list)
AND vis.payroll_date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months)
GROUP BY EMPLOYEE_key
)
,
												--find training hour units for a employee per month
training_hours AS 
( 
SELECT EMPLOYEE_KEY,
       date_trunc(MONTH,PAYROLL_DATE) AS payroll_month, 
       sum(NUMBER_OF_UNITS) AS training_hours_units
  FROM INTEGRATION.FACT_PAYROLL_DETAILS_MERGED fpdm
 WHERE EMPLOYEE_KEY IN (SELECT EMPLOYEE_KEY FROM emp_list)
 AND fpdm.PAY_CODE_DESCRIPTION like ''%Train%''  
GROUP BY EMPLOYEE_KEY,payroll_month 
)
,
payroll_month_count AS 
(
SELECT count(DISTINCT date_trunc(MONTH,PAYROLL_date)) AS count_of_months_with_payroll,
       employee_key 
FROM   INTEGRATION.FACT_PAYROLL_MERGED vis
WHERE PAY_HOURS > 0 
  AND vis.Original_Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
  AND vis.Employee_Key NOT IN ( SELECT Employee_Key FROM Bill_Only_Employees)
 AND  vis.payroll_date BETWEEN (SELECT MIN( Calendar_Month) FROM Calendar_Months) AND (SELECT MAX( Calendar_Month) FROM Calendar_Months) 
GROUP BY EMPLOYEE_KEY 
)
,
emp_payroll_gap AS 
(
SELECT count(gap) AS number_of_gaps_in_payroll,
       min(gap_in_months) AS smallest_gap_in_payroll,
       max(gap_in_months) AS largest_gap_in_payroll,
       employee_key
FROM  (SELECT CASE WHEN datediff(''month'',ep.payroll_month,lead(ep.payroll_month,1) over(PARTITION BY ep.employee_key ORDER BY ep.payroll_month)) >1
                   THEN 0
                   ELSE 1
               END AS  gap,
               									--did -1 here below. example: gap of 2 means payroll of 1 month was not done in between.
               datediff(''month'',ep.Payroll_month,lead(ep.Payroll_month,1) over(PARTITION BY ep.employee_key ORDER BY ep.Payroll_month))-1 AS gap_in_months,
               employee_key
         FROM  Emp_payrolled ep
       ) b
WHERE b.gap=0
GROUP BY employee_key
)
--main query
,
emp_metrics AS 
(
SELECT DISTINCT    
       ep.payroll_month,
       ep.Employee_Key,
       eb.branch_key,
       eb.branch_Name,
       eb.branch_state_code,
	   flpm.first_payroll_month,
	   flpm.last_payroll_month,
	   DATEDIFF(''MONTH'', first_payroll_month, last_payroll_month) + 1 AS Tenure_In_Months,
	   pmc.count_of_months_with_payroll AS number_of_months_with_payroll,
	   tenure_in_months - number_of_months_with_payroll AS number_of_months_without_payroll,
	   epg.number_of_gaps_in_payroll,
	   epg.smallest_gap_in_payroll,
	   epg.largest_gap_in_payroll,
	   lag(ep.payroll_month,1) OVER (partition BY ep.employee_key ORDER BY ep.payroll_month) AS previous_month_of_payroll,
	   lead(ep.payroll_month,1) OVER (partition BY ep.employee_key ORDER BY ep.payroll_month) AS next_month_of_payroll,
	   ep.total_hours_paid AS total_hours_paid,
	   lag(ep.total_hours_paid,1) OVER (partition BY ep.employee_key ORDER BY ep.payroll_month) AS previous_month_total_hours_paid,
	   lag(ep.total_hours_paid,2) OVER (partition BY ep.employee_key ORDER BY ep.payroll_month) AS previous_2_month_total_hours_paid,
	   lead(ep.total_hours_paid,1) OVER (partition BY ep.employee_key ORDER BY ep.payroll_month) AS next_month_total_hours_paid,
	   lead(ep.total_hours_paid,2) OVER (partition BY ep.employee_key ORDER BY ep.payroll_month) AS next_2_month_total_hours_paid,
	   ep.billable_hours AS billable_hours,
	   th.training_hours_units as training_hours_units,
       case WHEN ep.total_hours_paid <> 0 
            THEN true
            ELSE false
       end as active_flag,
	   ep.OT as OT,
	   CASE WHEN ep.total_union_dues_amount <> 0 
            THEN TRUE
            ELSE FALSE 
        END AS UNION_flag   
FROM emp_payrolled AS ep 
left outer join first_last_payroll_month flpm on ep.employee_key = flpm.employee_key
LEFT OUTER JOIN training_hours th on ep.employee_Key = th.employee_key AND ep.payroll_Month = th.payroll_month
LEFT OUTER JOIN emp_branch eb ON eb.employee_Key = ep.employee_key AND eb.payroll_Month = ep.payroll_month
LEFT OUTER JOIN payroll_month_count pmc ON ep.employee_key = pmc.employee_key
LEFT OUTER JOIN emp_payroll_gap epg  ON ep.employee_key = epg.employee_key
)
,
AQUISITION AS									-- Using FACT EMPLOYEE ACQUIRED & AMS PAYROLL mapping TO GET the Acquisition NAME FOR the employee
(
SELECT DISTINCT APM.PAYROLL_SYSTEM_CODE , APM.AMS_SYSTEM_CODE , APM.PAYROLL_EMPLOYEE_KEY ,E.EMPLOYEE_KEY AS AMS_EMPLOYEE_KEY
, E.SERVICE_MONTH , E.AQUISITION_NAME
,FIRST_VALUE(UPPER(NULLIF(E.AQUISITION_NAME,''''))) OVER (PARTITION BY E.EMPLOYEE_KEY, E.SERVICE_MONTH ORDER BY IFF(E.EMPLOYEE_KEY = E.ORIGINAL_EMPLOYEE_KEY,0,1)) 
	AS ACQUIRED_SYSTEM		-- In case of getting more than one Acquisition name for an employee per month from Fact emp acquired, we are picking employees
							-- latest system record where original emp key & emp key will be same. Ideally we would want to join service branch key from acquired
							-- table with payrolled branch to get correct acquisition name for that particular payrolled branch, however that is not possible so using latest system logic just to pick one record
FROM					-- For example many employees perform services TO clients of preferred & edison both in same period so we would get both values per emp per month causing duplicates.
INTEGRATION.FACT_AMS_PAYROLL_MAPPING APM
JOIN HAH.FACT_EMPLOYEE_ACQUIRED E ON APM.AMS_EMPLOYEE_KEY = E.EMPLOYEE_KEY
WHERE E.AQUISITION_NAME IS NOT NULL
--QUALIFY ACQUIRED_SYSTEM = E.AQUISITION_NAME	-- 1.43M records have NO effect OF above FIRST value logic. ONLY 2.1k records are there where aquisition
 												-- name will be picked from first value logic. The end result matches with ams emp derived structure 
 												-- as the acquisition names for 99% emps will match between Ams emp derived & payroll emp derived structures
)
--
SELECT DISTINCT
emet.payroll_month,
       emet.Employee_Key,
       emp.Source_System_ID, 
       FIRST_VALUE(emp.Original_Source_System_Id) OVER (PARTITION BY emet.Employee_Key ORDER BY IFF(emp.Original_Source_System_ID <> emp.Source_System_ID, 0, 1)) AS Original_Source_System_ID, 
       emp.Employee_ID, 
	   emp.System_Code, 
	   emp.Employee_PID, 
	   emp.Employee_Number, 
	   emp.Payroll_ID,
       emp.Employee_Category,
	   CASE WHEN emp.CASE_MANAGER_FLAG = TRUE 
	        THEN ''ADMIN'' 
       ELSE UPPER(emp.Employee_Category) 
       END AS Derived_Employee_Category,
	   emp.EMPLOYEE_FIRST_NAME,
       emp.EMPLOYEE_LAST_NAME,
       emp.EMPLOYEE_DOB,
       emp.EMPLOYEE_GENDER,
       emp.EMPLOYEE_ETHNICITY,
       emet.branch_key,
       emet.branch_Name,
       emet.branch_state_code,
	   emet.first_payroll_month,
	   emet.last_payroll_month,
	   emet.Tenure_In_Months,
	   emet.number_of_months_with_payroll,
	   emet.number_of_months_without_payroll,
	   emet.number_of_gaps_in_payroll,
	   emet.smallest_gap_in_payroll,
	   emet.largest_gap_in_payroll,
	   emet.previous_month_of_payroll,
	   emet.next_month_of_payroll,
	   emet.total_hours_paid,
	   emet.previous_month_total_hours_paid,
	   emet.previous_2_month_total_hours_paid,
	   emet.next_month_total_hours_paid,
	   emet.next_2_month_total_hours_paid,
	   emet.billable_hours,
	   emet.training_hours_units,
       emet.active_flag,
	   emet.OT,
	   emet.UNION_flag,    
       emp.EXEMPT_FLAG AS exempt_flag, 
       emp.EMPLOYEE_TYPE,
       --COALESCE(emp.acquired_system, AQ.AQUISITION_NAME) AS ACQUIRED_SYSTEM_NAME,
       COALESCE(CCSI_ACQUIRED_EMPLOYEE.ACQUIRED_SYSTEM, AQ.ACQUIRED_SYSTEM, emp.acquired_system) AS acquired_system_name ,
			:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
            :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
        	convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
			CURRENT_USER as ETL_INSERTED_BY ,
			convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
			CURRENT_USER as ETL_LAST_UPDATED_BY,
			0 as ETL_DELETED_FLAG
FROM emp_metrics emet 
LEFT OUTER JOIN INTEGRATION.DIM_EMPLOYEE_PAYROLL_MERGE_DEDUPE AS emp ON emet.employee_key = emp.employee_key
LEFT OUTER JOIN AQUISITION AQ ON AQ.PAYROLL_EMPLOYEE_KEY = emet.employee_key AND emet.payroll_month = AQ.SERVICE_MONTH
LEFT OUTER JOIN (SELECT PAYROLL_EMPLOYEE_KEY, ACQUIRED_SYSTEM  FROM AQUISITION WHERE ACQUIRED_SYSTEM = ''CCSI'') CCSI_ACQUIRED_EMPLOYEE
          ON CCSI_ACQUIRED_EMPLOYEE.PAYROLL_EMPLOYEE_KEY = emet.EMPLOYEE_KEY 
          AND emet.payroll_month >= ''2021-07-01''
ORDER BY emet.employee_key,emet.payroll_month;
SELECT CONCAT (''MESSAGE : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	RETURN return_result;
    END;
    
 EOT
}

