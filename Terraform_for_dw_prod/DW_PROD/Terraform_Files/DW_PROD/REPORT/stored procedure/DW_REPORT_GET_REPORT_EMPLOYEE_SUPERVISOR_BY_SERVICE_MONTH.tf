resource "snowflake_procedure" "DW_REPORT_GET_REPORT_EMPLOYEE_SUPERVISOR_BY_SERVICE_MONTH" {
	name ="GET_REPORT_EMPLOYEE_SUPERVISOR_BY_SERVICE_MONTH"
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
-- NAME:  Employee_Supervisor_By_Service_Month
--
-- PURPOSE: Creates a record for each employee-supervisor combination for each service month
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 03/03/21    Frank Noordover       Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO Report.Employee_Supervisor_By_Service_Month
SELECT DISTINCT DATE_TRUNC( ''MONTH'', vis.Service_Date) AS Service_Month, 
       vis.Employee_Key,
       emp.Primary_Branch_Key AS Branch_Key,
       emp.Primary_Branch_State AS Branch_State,
       emp.Primary_Branch_Name AS Branch_Name,
       emp.System_Code AS Employee_System_Code,
       emp.Employee_Id,
       emp.Employee_Last_Name,
       emp.Employee_Category,
       vis.Supervisor_Key,
       sup.System_Code AS Supervisor_System_Code,
       sup.Supervisor_Code,
       sup.Supervisor_Name,
       :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
       :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
       CURRENT_USER as ETL_INSERTED_BY ,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
       CURRENT_USER as ETL_LAST_UPDATED_BY,
       0 as ETL_DELETED_FLAG
FROM HAH.Fact_Visit AS vis
LEFT OUTER JOIN HAH.DIM_Employee AS emp ON emp.Employee_Key = vis.Employee_Key
LEFT OUTER JOIN HAH.DIM_Supervisor AS sup ON sup.Supervisor_Key = vis.Supervisor_Key
WHERE SERVICE_DATE BETWEEN CAST( ''1950-01-01'' AS DATE) AND DATEADD( ''MONTH'', 1, CURRENT_DATE)
ORDER BY 1, 2;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

