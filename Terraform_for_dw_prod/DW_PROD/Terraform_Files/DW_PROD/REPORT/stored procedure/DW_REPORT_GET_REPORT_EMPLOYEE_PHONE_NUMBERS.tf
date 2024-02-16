resource "snowflake_procedure" "DW_REPORT_GET_REPORT_EMPLOYEE_PHONE_NUMBERS" {
	name ="GET_REPORT_EMPLOYEE_PHONE_NUMBERS"
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
-- NAME:  Employee_Phone_Numbers
--
-- PURPOSE: Creates a list of phone numbers for each employee
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 11/16/20    Frank Noordover       Initial development
-- 08/10/21	   Shraddha Sejpal		 Added Matrixcare Employees and Integration layer
-- 09/30/21	   Shraddha Sejpal		 Added CCSI Employees
-- 03/26/22	   Mir Ali				 Added phone number clean-up regex
--*****************************************************************************************************************************

INSERT OVERWRITE INTO Report.Employee_Phone_Numbers
WITH employee_list AS 
(
--
-- Coastal Employees --16,384
--
SELECT EMPLOYEE_KEY, SYSTEM_NAME, STATE, FULL_BRANCH_NAME, BRANCH_NAME,
	ID, CATEGORY, FIRST_NAME, LAST_NAME, 
	IFF(
		LENGTH(REGEXP_REPLACE(PHONE1, ''\\\\D'', '''')) = 10,
		REGEXP_REPLACE(PHONE1, ''\\\\D'', ''''),
		NULL) AS PHONE1, 
	IFF(
		LENGTH(REGEXP_REPLACE(PHONE2, ''\\\\D'', '''')) = 10,
		REGEXP_REPLACE(PHONE2, ''\\\\D'', ''''),
		NULL) AS PHONE2, 
	IFF(
		LENGTH(REGEXP_REPLACE(PHONE3, ''\\\\D'', '''')) = 10,
		REGEXP_REPLACE(PHONE3, ''\\\\D'', ''''),
		NULL) AS PHONE3, 
	ACTIVE_EMPLOYEE_FLAG, DERIVED_ACTIVE_EMPLOYEE_FLAG,
	LATEST_SERVICE_DATE, LATEST_CHECK_DATE
FROM (
		SELECT DISTINCT emp.Employee_Key,
		       emp.System_Code AS System_Name,
		       emp.Primary_Branch_State AS State,
		       emp.Primary_Branch_Name AS Full_Branch_Name,
		       brnch.Branch_Name AS Branch_Name,
		       emp.Employee_ID AS ID,
		       emp.Employee_Category AS Category,
		       emp.Employee_First_Name AS First_Name, 
		       emp.Employee_Last_Name AS Last_Name,
		       IFF( TRIM( emp.Employee_Home_Phone)='''', NULL, emp.Employee_Home_Phone) AS Phone1,
		       IFF( TRIM( emp.Employee_Cell_Phone)='''', NULL, emp.Employee_Cell_Phone) AS Phone2,
		       IFF( TRIM( emp.Employee_Work_Phone)='''', NULL, emp.Employee_Work_Phone) AS Phone3,
		       emp.Active_Employee_Flag, edm.Derived_Active_Employee_Flag,
		       edm.Derived_Last_Service_Date AS Latest_Service_Date,
		       edm.Derived_Last_Check_Date AS Latest_Check_Date
		FROM 
		INTEGRATION.DIM_Employee_MERGED AS emp
		LEFT OUTER JOIN Report.Employee_Derived_Metrics AS edm ON emp.Employee_Key = edm.Employee_Key AND emp.Source_System_ID = edm.Source_System_ID
		LEFT OUTER JOIN INTEGRATION.DIM_BRANCH_MERGED AS brnch ON emp.Primary_Branch_Key = brnch.Branch_Key
		WHERE emp.Source_System_ID IN (1,2)
		UNION
		-----
		-- DataFlex Employees --152,881 WITH INTEGRATION 145,715
		-----
		SELECT DISTINCT  emp.Employee_Key,
		       ''DATAFLEX'' AS System_Name,
		       NVL( emp.Primary_Branch_State, emp.System_Code) AS State,
		       emp.Primary_Branch_Name AS Full_Branch_Name,
		       brnch.Branch_Name AS Branch_Name,
		       emp.Employee_ID AS ID,
		       emp.Employee_Category AS Category,
		       emp.Employee_First_Name AS First_Name, 
		       emp.Employee_Last_Name AS Last_Name,
		       CASE WHEN ( emp.Employee_Home_Phone IS NULL OR TRIM( emp.Employee_Home_Phone) = '''') THEN IFF( TRIM( emppay.Employee_Home_Phone)='''', NULL, emppay.Employee_Home_Phone) ELSE IFF( TRIM( emp.Employee_Home_Phone)='''', NULL, emp.Employee_Home_Phone) END AS Phone1,
		       CASE WHEN ( emp.Employee_Cell_Phone IS NULL OR TRIM( emp.Employee_Cell_Phone) = '''') THEN IFF( TRIM( emppay.Employee_Cell_Phone)='''', NULL, emppay.Employee_Cell_Phone) ELSE IFF( TRIM( emp.Employee_Cell_Phone)='''', NULL, emp.Employee_Cell_Phone) END AS Phone2,
		       CASE WHEN ( emp.Employee_Work_Phone IS NULL OR TRIM( emp.Employee_Work_Phone) = '''') THEN IFF( TRIM( emppay.Employee_Work_Phone)='''', NULL, emppay.Employee_Work_Phone) ELSE IFF( TRIM( emp.Employee_Work_Phone)='''', NULL, emp.Employee_Work_Phone) END AS Phone3,
		       emp.Active_Employee_Flag, edm.Derived_Active_Employee_Flag,
		       edm.Derived_Last_Service_Date AS Latest_Service_Date,
		       edm.Derived_Last_Check_Date AS Latest_Check_Date
		FROM 
		INTEGRATION.DIM_Employee_MERGED AS emp
		LEFT OUTER JOIN INTEGRATION.DIM_Employee_MERGED AS emppay ON emp.Payroll_ID = emppay.Payroll_ID AND emppay.Source_System_ID = 5
		LEFT OUTER JOIN Report.Employee_Derived_Metrics AS edm ON emp.Employee_Key = edm.Employee_Key AND emp.Source_System_ID = edm.Source_System_ID
		LEFT OUTER JOIN INTEGRATION.DIM_BRANCH_MERGED AS brnch ON emp.Primary_Branch_Key = brnch.Branch_Key
		WHERE emp.Source_System_ID = 3
		UNION
		--
		-- Sandata employees  --19,934
		--
		SELECT DISTINCT  emp.Employee_Key,
		       ''SANDATA'' AS System_Name,
		       emp.Primary_Branch_State AS State,
		       emp.Primary_Branch_Name AS Full_Branch_Name,
		       brnch.Branch_Name AS Branch_Name,
		       emp.Employee_ID AS ID,
		       emp.Employee_Category AS Category,
		       emp.Employee_First_Name AS First_Name, 
		       emp.Employee_Last_Name AS Last_Name,
		       emp.Employee_Home_Phone AS Phone1,
		       emp.Employee_Cell_Phone AS Phone2,
		       emp.Employee_Work_Phone AS Phone3,
		       emp.Active_Employee_Flag, edm.Derived_Active_Employee_Flag,
		       edm.Derived_Last_Service_Date AS Latest_Service_Date,
		       edm.Derived_Last_Check_Date AS Latest_Check_Date
		FROM 
		INTEGRATION.DIM_Employee_MERGED AS emp
		LEFT OUTER JOIN Report.Employee_Derived_Metrics AS edm ON emp.Employee_Key = edm.Employee_Key AND emp.Source_System_ID = edm.Source_System_ID
		LEFT OUTER JOIN INTEGRATION.DIM_BRANCH_MERGED AS brnch ON emp.Primary_Branch_Key = brnch.Branch_Key
		WHERE emp.Source_System_ID = 4
		UNION
		----
		---- Great Plains employees not in dataflex and Matrixcare; i.e. Corporate and Admin employees  --5,797
		----
		SELECT DISTINCT emp.Employee_Key,
		       ''GREAT PLAINS'' AS System_Name,
		       emp.Primary_Branch_State AS State,
		       emp.Primary_Branch_Name AS Full_Branch_Name,
		       brnch.Branch_Name AS Branch_Name,
		       emp.Employee_ID AS ID,
		       emp.Employee_Category AS Category,
		       emp.Employee_First_Name AS First_Name, 
		       emp.Employee_Last_Name AS Last_Name,
		       COALESCE (emp.Employee_Home_Phone, emppay.Employee_Home_Phone, emppay_m.EMPLOYEE_HOME_PHONE) AS Phone1,
		       COALESCE (emp.Employee_Cell_Phone, emppay.Employee_Cell_Phone, emppay_m.EMPLOYEE_CELL_PHONE) AS Phone2,
		       COALESCE (emp.Employee_Work_Phone, emppay.Employee_Work_Phone, emppay_m.EMPLOYEE_WORK_PHONE) AS Phone3,
		       emp.Active_Employee_Flag, edm.Derived_Active_Employee_Flag,
		       edm.Derived_Last_Service_Date AS Latest_Service_Date,
		       edm.Derived_Last_Check_Date AS Latest_Check_Date
		FROM 
		INTEGRATION.DIM_Employee_MERGED AS emp
		LEFT JOIN INTEGRATION.DIM_EMPLOYEE_MERGED AS emppay ON emp.Employee_ID = emppay.Payroll_ID AND emppay.Source_System_ID = 3
		LEFT JOIN INTEGRATION.DIM_EMPLOYEE_MERGED AS emppay_M ON emppay_M.Source_System_ID = 7 AND emp.EMPLOYEE_FIRST_NAME = emppay_M.EMPLOYEE_FIRST_NAME
		AND emp.EMPLOYEE_LAST_NAME = EMPPAY_M.EMPLOYEE_LAST_NAME AND emp.EMPLOYEE_HOME_PHONE= COALESCE (EMPPAY_M.EMPLOYEE_HOME_PHONE::string,EMPPAY_M.EMPLOYEE_CELL_PHONE::string,EMPPAY_M.EMPLOYEE_WORK_PHONE::string)
		OR EMP.EMPLOYEE_CELL_PHONE = COALESCE (EMPPAY_M.EMPLOYEE_HOME_PHONE::string,EMPPAY_M.EMPLOYEE_CELL_PHONE::string,EMPPAY_M.EMPLOYEE_WORK_PHONE::string) 
		OR EMP.EMPLOYEE_WORK_PHONE = COALESCE (EMPPAY_M.EMPLOYEE_HOME_PHONE::string,EMPPAY_M.EMPLOYEE_CELL_PHONE::string,EMPPAY_M.EMPLOYEE_WORK_PHONE::string) 
		LEFT OUTER JOIN Report.Employee_Derived_Metrics AS edm ON emp.Employee_Key = edm.Employee_Key AND emp.Source_System_ID = edm.Source_System_ID
		LEFT OUTER JOIN INTEGRATION.DIM_BRANCH_MERGED AS brnch ON emp.Primary_Branch_Key = brnch.Branch_Key
		WHERE emp.Source_System_ID = 5 
		AND emppay.Employee_ID IS NULL AND (EMPPAY_M.EMPLOYEE_FIRST_NAME IS NULL AND EMPPAY_M.EMPLOYEE_LAST_NAME IS NULL 
		AND EMPPAY_M.EMPLOYEE_HOME_PHONE IS NULL AND EMPPAY_M.EMPLOYEE_CELL_PHONE IS NULL AND EMPPAY_M.EMPLOYEE_WORK_PHONE IS NULL)
		UNION 
		--------
		---Matrixcare employees  --WITH INTEGRATION 25,413
		--------
		SELECT DISTINCT  emp.Employee_Key,
		       ''MATRIXCARE'' AS System_Name,
		       emp.Primary_Branch_State AS State,
		       emp.Primary_Branch_Name AS Full_Branch_Name,
		       brnch.Branch_Name AS Branch_Name,
		       emp.Employee_ID AS ID,
		       emp.Employee_Category AS Category,
		       emp.Employee_First_Name AS First_Name, 
		       emp.Employee_Last_Name AS Last_Name,
		       NULLIF(emp.Employee_Home_Phone, '''') AS Phone1,
		       NULLIF(emp.Employee_Cell_Phone, '''') AS Phone2,
		       NULLIF(emp.Employee_Work_Phone, '''') AS Phone3,
		       emp.Active_Employee_Flag, edm.Derived_Active_Employee_Flag,
		       edm.Derived_Last_Service_Date AS Latest_Service_Date,
		       edm.Derived_Last_Check_Date AS Latest_Check_Date
		FROM 
		INTEGRATION.DIM_Employee_MERGED AS emp
		LEFT OUTER JOIN Report.Employee_Derived_Metrics AS edm ON emp.Employee_Key = edm.Employee_Key AND emp.Source_System_ID = edm.Source_System_ID
		LEFT OUTER JOIN INTEGRATION.DIM_BRANCH_MERGED AS brnch ON emp.Primary_Branch_Key = brnch.Branch_Key
		WHERE emp.Source_System_ID = 7 
		UNION 
		--------
		---CCSI employees  --WITH INTEGRATION 37,192
		--------
		SELECT DISTINCT  emp.Employee_Key,
		       ''CCSI'' AS System_Name,
		       emp.Primary_Branch_State AS State,
		       emp.Primary_Branch_Name AS Full_Branch_Name,
		       brnch.Branch_Name AS Branch_Name,
		       emp.Employee_ID AS ID,
		       emp.Employee_Category AS Category,
		       emp.Employee_First_Name AS First_Name, 
		       emp.Employee_Last_Name AS Last_Name,
		       NULLIF(emp.Employee_Home_Phone, '''') AS Phone1,
		       NULLIF(emp.Employee_Cell_Phone, '''') AS Phone2,
		       NULLIF(emp.Employee_Work_Phone, '''') AS Phone3,
		       emp.Active_Employee_Flag, edm.Derived_Active_Employee_Flag,
		       edm.Derived_Last_Service_Date AS Latest_Service_Date,
		       edm.Derived_Last_Check_Date AS Latest_Check_Date
		FROM 
		INTEGRATION.DIM_Employee_MERGED AS emp
		LEFT OUTER JOIN Report.Employee_Derived_Metrics AS edm ON emp.Employee_Key = edm.Employee_Key AND emp.Source_System_ID = edm.Source_System_ID
		LEFT OUTER JOIN INTEGRATION.DIM_BRANCH_MERGED AS brnch ON emp.Primary_Branch_Key = brnch.Branch_Key
		WHERE emp.Source_System_ID = 8
	) L
)
SELECT Employee_Key, System_Name, State, Full_Branch_Name, Branch_Name,
       ID, Category,
       First_Name, Last_Name,
       NVL( Phone1, NVL( Phone2, Phone3)) AS Emp_Phone1,
       CASE WHEN Phone2 = Emp_Phone1 AND Phone3 <> Emp_Phone1 THEN Phone3
            WHEN Emp_Phone1 IS NOT NULL AND Phone2 <> Emp_Phone1 THEN Phone2 
            WHEN Emp_Phone1 IS NOT NULL AND Phone2 IS NULL THEN Phone3
       END AS Emp_Phone2,
       CASE WHEN Phone3 = Emp_Phone1 OR Phone3 = Emp_Phone2 THEN NULL 
            WHEN Emp_Phone1 IS NOT NULL AND Emp_Phone2 IS NOT NULL THEN Phone3
       END AS Emp_Phone3,
       Active_Employee_Flag, Derived_Active_Employee_Flag,
       Latest_Service_Date, Latest_Check_Date
FROM employee_list
ORDER BY State, Full_Branch_Name, Category DESC, Last_Name, First_Name;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

