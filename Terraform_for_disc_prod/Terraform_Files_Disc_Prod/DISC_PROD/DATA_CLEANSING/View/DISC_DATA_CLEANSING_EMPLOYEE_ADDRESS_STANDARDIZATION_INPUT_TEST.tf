resource "snowflake_view" "DISC_DATA_CLEANSING_EMPLOYEE_ADDRESS_STANDARDIZATION_INPUT_TEST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	name = "EMPLOYEE_ADDRESS_STANDARDIZATION_INPUT_TEST"
	statement = <<-SQL
	 SELECT SOURCE_SYSTEM_ID, SYSTEM_CODE, EMPLOYEE_ID, 
       EMPLOYEE_FIRST_NAME, EMPLOYEE_LAST_NAME, 
       SRC_EMPLOYEE_ADDRESS AS Address, SRC_EMPLOYEE_CITY AS City, SRC_EMPLOYEE_STATE_CODE AS State, TRIM( LEFT( SRC_EMPLOYEE_ZIP, 5)) AS Zip
FROM DISC_${var.SF_ENVIRONMENT}.Data_Cleansing.Employee_Src_Attributes 
WHERE Source_System_ID IN (1, 2, 3, 4, 5, 6, 7, 9, 10, 13, 14, 16, 17, 34)
AND System_Code NOT IN ( 'PREFERRED', 'EDISON')
AND SRC_EMPLOYEE_MAX_ACTIVITY_DATE >= CAST( '2022-09-01' AS DATE)
AND SRC_Employee_Address_Processed_Flag = 'FALSE'
AND Src_Employee_Address IS NOT NULL AND TRIM(Src_Employee_Address) <> ''
AND ((Src_Employee_City IS NOT NULL AND TRIM(Src_Employee_City) <> '' AND Src_Employee_State_Code IS NOT NULL AND TRIM(Src_Employee_State_Code) <> '') OR (Src_Employee_Zip IS NOT NULL AND TRIM(Src_Employee_Zip) <> ''))
ORDER BY System_Code, Employee_Last_Name, Employee_First_Name;
SQL
	or_replace = true 
	is_secure = false 
}

