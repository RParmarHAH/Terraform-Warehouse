create or replace view DW_PROD.REPORT.VW_DATAFLEX_GP_SANDATA_DISCREPENCIES(
	WD_EMP_ID,
	WD_PAYROLL_ID,
	WD_WORK_STATE,
	GP_EMP_ID,
	GP_COMPANY,
	DF_PAYROLL_ID,
	DF_STATE,
	DF_EMP_ID,
	SANDATA_STAFF_ID,
	SANDATA_STATE,
	STAFFID,
	STAFFAGENCYID,
	OTHERID2,
	EMPLOYEE_KEY,
	EMPLOYEE_ID,
	SYSTEM_CODE,
	EMPLOYEE_PID,
	EMPLOYEE_NUMBER,
	EMPLOYEE_DOB,
	EMPLOYEE_HIRE_DATE,
	EMPLOYEE_TERMINATE_DATE,
	REASON_TO_TERMINATE,
	ACTIVE_EMPLOYEE_FLAG,
	ABLE_TO_REHIRE_FLAG,
	EMPLOYEE_FIRST_NAME,
	EMPLOYEE_MIDDLE_NAME,
	EMPLOYEE_LAST_NAME,
	EMPLOYEE_ADDRESS1,
	EMPLOYEE_ADDRESS2,
	EMPLOYEE_CITY,
	EMPLOYEE_STATE_CODE,
	EMPLOYEE_ZIP,
	WORK_STATE,
	EMPLOYEE_HOME_PHONE,
	EMPLOYEE_CELL_PHONE,
	EMPLOYEE_WORK_PHONE,
	EMPLOYEE_PERSONAL_EMAIL,
	EMPLOYEE_WORK_EMAIL,
	EMPLOYEE_TYPE,
	EMPLOYEE_CATEGORY,
	JOB_TITLE,
	JOB_DESCRIPTION,
	EMPLOYEE_DEPARTMENT,
	EMPLOYEE_OFFICE_CODE
) as
SELECT wd_emp.Employee_ID AS WD_Emp_ID, wd_emp.Payroll_ID AS WD_Payroll_ID, wd_emp.Work_State AS WD_Work_State, 
       gp_emp.Employee_ID AS GP_Emp_ID, gp_emp.System_Code AS GP_Company, 
       df_Emp.Payroll_ID AS DF_Payroll_ID, df_Emp.System_Code AS DF_State, df_Emp.Employee_ID AS DF_Emp_ID, 
       ss.ID AS Sandata_Staff_ID, 
       CASE TRIM(SS.AGENCYID) 
            WHEN '8380' THEN 'IL'
            WHEN '38004' THEN 'IN'
            WHEN '8463' THEN 'MO'
       END AS Sandata_State,
       ss.STAFFID, ss.STAFFAGENCYID, ss.OTHERID2,
--       wd_emp.*
       wd_emp.Employee_Key, wd_emp.Employee_ID, wd_emp.System_Code, wd_emp.Employee_PID, wd_emp.Employee_Number, wd_emp.Employee_DOB, wd_Emp.Employee_Hire_Date, 
       wd_emp.Employee_Terminate_Date, wd_emp.Reason_to_Terminate, wd_emp.Active_Employee_Flag, wd_emp.Able_to_Rehire_Flag, 
       wd_emp.Employee_First_Name, wd_emp.Employee_Middle_Name, wd_emp.Employee_Last_Name,
       wd_emp.Employee_Address1, wd_emp.Employee_Address2, wd_emp.Employee_City, wd_emp.Employee_State_Code, wd_emp.Employee_Zip, wd_emp.Work_State,
       wd_emp.Employee_Home_Phone, wd_emp.Employee_Cell_Phone, wd_emp.Employee_Work_Phone,
       wd_emp.Employee_Personal_Email, wd_emp.Employee_Work_Email,
--       wd_emp.Employee_Gender, wd_emp.Employee_Ethnicity, wd_emp.Employee_Marital_Status,
       wd_emp.Employee_Type, wd_emp.Employee_Category, wd_emp.Job_Title, wd_emp.Job_Description, wd_emp.Employee_Department, wd_emp.employee_Office_Code
FROM DW_Prod.HAH.DIM_Employee AS wd_emp
LEFT OUTER JOIN DW_Prod.HAH.DIM_Employee AS gp_emp ON HEX_DECODE_STRING( wd_emp.Employee_PID) = HEX_DECODE_STRING( gp_emp.Employee_PID) AND gp_emp.Source_System_ID = 5
LEFT OUTER JOIN DW_Prod.HAH.DIM_Employee AS df_emp ON HEX_DECODE_STRING( wd_emp.Employee_PID) = HEX_DECODE_STRING( df_emp.Employee_PID) AND df_emp.Source_System_ID = 3 AND df_emp.System_Code IN ('IL', 'IN', 'MO', 'MS')
LEFT OUTER JOIN DISC_PROD.SANDATAIMPORT.SANDATA_STAFFS AS ss ON HEX_DECODE_STRING( wd_emp.Employee_PID) = ss.SSN AND TRIM(SS.AGENCYID) IN ( '8380', '38004', '8463') AND CASE TRIM(SS.AGENCYID) 
            WHEN '8380' THEN 'IL'
            WHEN '38004' THEN 'IN'
            WHEN '8463' THEN 'MO'
       END = wd_emp.Work_State
WHERE wd_emp.Source_System_ID = 36
AND wd_emp.Work_State IN ('IL', 'IN', 'MO', 'MS')
AND gp_emp.Employee_ID IS NOT NULL
AND df_emp.Payroll_ID IS NOT NULL
AND ( IFNULL( gp_emp.Employee_ID, '$#!') <> IFNULL( wd_emp.Payroll_ID, '#!$') OR IFNULL( df_emp.Payroll_ID, '$#!') <> IFNULL( gp_emp.Employee_ID, '#!$'))
ORDER BY 1,2,3;