resource "snowflake_view" "DW_STAGE_VW_CURRENT_DELETED_GPSYNCDATA_DIM_EMPLOYEE" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "VW_CURRENT_DELETED_GPSYNCDATA_DIM_EMPLOYEE"
	statement = <<-SQL
	 
SELECT  MD5( CAST( emp.Employee_ID AS VARCHAR)||'-'|| emp.db ) AS Employee_Key
-- 408,096
FROM DISC_${var.SF_ENVIRONMENT}.GPSyncData.GPAllEmployeesBase AS emp
-- 408,096
--INNER JOIN latest_emp ON latest_emp.Employee_ID = emp.Employee_ID
--        AND latest_emp.Max_Effective_To_Date = IFF( emp.Terminate_Date IS NULL, IFF( emp.Last_Day_Worked IS NULL, IFF( emp.Last_Check_Date IS NULL, CAST( '2030-12-31' AS DATE), emp.Last_Check_Date), emp.Last_Day_Worked), emp.Terminate_Date)
--        AND latest_emp.HIRE_DATE_CHECK = COALESCE(emp.HIRE_DATE,'1900-01-01')
LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_State AS geo ON UPPER( TRIM( emp.State)) = geo.State_ISO_Code OR UPPER( TRIM( emp.State)) = UPPER( geo.State_Name)
LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_Branch AS brnch ON ( LPAD( CAST( brnch.Office_Number AS VARCHAR), 3, '0') = LPAD( TRIM( emp.Office_NO), 3, '0') AND brnch.Source_System_ID = 3 AND emp.Office_No NOT IN (908, 950, 951, 17, 52, 53, 60, -1)) 
                                               OR ( LPAD( CAST( brnch.Office_Number AS VARCHAR), 3, '0') = LPAD( TRIM( emp.Office_NO), 3, '0') AND brnch.Source_System_ID = 3 AND emp.Office_No IN (908, 950, 951, 17, 52, 53, 60, -1) AND brnch.Office_State_Code = UPPER( TRIM( emp.Work_State)))
WHERE EMP.ETL_DELETED_FLAG = TRUE 
AND CAST(EMP.ETL_LAST_UPDATED_DATE AS DATE) IN
(SELECT MAX(CAST(ETL_LAST_UPDATED_DATE AS DATE)) FROM 
DISC_${var.SF_ENVIRONMENT}.GPSyncData.HIST_GPAllEmployeesBase);
SQL
	or_replace = true 
	is_secure = false 
}

