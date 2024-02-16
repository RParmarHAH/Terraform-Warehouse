resource "snowflake_view" "DW_INTEGRATION_VW_DIM_EMPLOYEE_NY" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "VW_DIM_EMPLOYEE_NY"
	statement = <<-SQL
	 SELECT EMPLOYEE_KEY AS ID, EMPLOYEE_FIRST_NAME || EMPLOYEE_LAST_NAME AS NAME,  SYSTEM_CODE,EMPLOYEE_LAST_NAME,EMPLOYEE_FIRST_NAME,EMPLOYEE_PID,EMPLOYEE_DOB,EMPLOYEE_ADDRESS1,EMPLOYEE_CITY,EMPLOYEE_HOME_PHONE,EMPLOYEE_PERSONAL_EMAIL FROM DW_${var.SF_ENVIRONMENT}.HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID = 17 AND SYSTEM_CODE IN ('PREFERRED','EDISON');
SQL
	or_replace = true 
	is_secure = false 
}

