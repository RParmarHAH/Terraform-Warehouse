resource "snowflake_procedure" "DISC_DATA_CLEANSING_GET_ZENDESK_SRC_EMPLOYEE" {
	name ="GET_ZENDESK_SRC_EMPLOYEE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME: ZENDESK_Employee
--
-- PURPOSE: Creates script for data cleanse for ZENDESK  source
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/08/23     Darshan Gosai           Initial development
--*****************************************************************************************************************************
--


MERGE INTO DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_SRC_ATTRIBUTES AS tgt
USING
(SELECT *  FROM  DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_SRC_ZENDESK_ATTRIBUTES) AS src
ON src.Source_System_ID = tgt.Source_System_ID
AND src.System_Code = tgt.System_Code
AND src.Employee_ID = tgt.Employee_ID
WHEN MATCHED AND (IFNULL( src.Employee_First_Name, ''~!@#$%^&*()+'') <> IFNULL( tgt.Employee_First_Name, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Employee_Last_Name, ''~!@#$%^&*()+'') <> IFNULL( tgt.Employee_Last_Name, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Employee_SSN, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_SSN, ''~!@#$%^&*()+'')
              OR  IFNULL( CAST( src.Src_Employee_DOB AS VARCHAR), ''~!@#$%^&*()+'') <> IFNULL( CAST( tgt.Src_Employee_DOB AS VARCHAR), ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Employee_Home_Phone, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_Home_Phone, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Employee_Cell_Phone, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_Cell_Phone, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Employee_Work_Phone, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_Work_Phone, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Employee_Personal_Email, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_Personal_Email, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Employee_Work_Email, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_Work_Email, ''~!@#$%^&*()+''))
 THEN UPDATE SET  tgt.Employee_First_Name = src.Employee_First_Name,
                  tgt.Employee_Last_Name = src.Employee_Last_Name,
                  tgt.Src_Employee_SSN = src.Src_Employee_SSN,
                  tgt.Src_Employee_DOB = src.Src_Employee_DOB,
                  tgt.Src_Employee_Home_Phone = src.Src_Employee_Home_Phone,
                  tgt.Src_Employee_Cell_Phone = src.Src_Employee_Cell_Phone,
                  tgt.Src_Employee_Work_Phone = src.Src_Employee_Work_Phone,
                  tgt.Src_Employee_Personal_Email = src.Src_Employee_Personal_Email,
                  tgt.Src_Employee_Work_Email = src.Src_Employee_Work_Email,
                  tgt.Src_Employee_Min_Activity_Date = src.Src_Employee_Min_Activity_Date,
                  tgt.Src_Employee_Max_Activity_Date = src.Src_Employee_Max_Activity_Date,
                  tgt.Src_Employee_DOB_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Employee_SSN_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Employee_Home_Phone_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Employee_Cell_Phone_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Employee_Work_Phone_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Employee_Personal_Email_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Employee_Work_Email_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.ETL_Task_Key = src.ETL_Task_Key,
                  tgt.ETL_Last_Updated_Date = src.ETL_Last_Updated_Date,
                  tgt.ETL_Last_Updated_By = src.ETL_Last_Updated_By
WHEN MATCHED AND( IFNULL( src.Src_Employee_Address, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_Address, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Employee_City, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_City, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Employee_State_Code, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_State_Code, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Employee_Zip, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_Zip, ''~!@#$%^&*()+''))
  THEN UPDATE SET tgt.Src_Employee_Address = src.Src_Employee_Address,
                  tgt.Src_Employee_City = src.Src_Employee_City,
                  tgt.Src_Employee_State_Code = src.Src_Employee_State_Code,
                  tgt.Src_Employee_Zip = src.Src_Employee_Zip,
                  tgt.Src_Employee_Address_Processed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Employee_Address_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN)
WHEN MATCHED AND (IFNULL( src.Src_Employee_Min_Activity_Date, ''1000-01-01'') <> IFNULL( tgt.Src_Employee_Min_Activity_Date, ''1000-01-01'')
              OR  IFNULL( src.Src_Employee_Max_Activity_Date, ''1000-01-01'') <> IFNULL( tgt.Src_Employee_Max_Activity_Date, ''1000-01-01''))
 THEN UPDATE SET  tgt.Src_Employee_Min_Activity_Date = src.Src_Employee_Min_Activity_Date,
                  tgt.Src_Employee_Max_Activity_Date = src.Src_Employee_Max_Activity_Date,
                  tgt.ETL_Task_Key = src.ETL_Task_Key,
                  tgt.ETL_Last_Updated_Date = src.ETL_Last_Updated_Date,
                  tgt.ETL_Last_Updated_By = src.ETL_Last_Updated_By
WHEN NOT MATCHED THEN INSERT
(Source_System_ID, System_Code, Employee_ID, Employee_First_Name, Employee_Last_Name, 
SRC_Employee_ADDRESS, SRC_Employee_CITY, SRC_Employee_STATE_CODE, SRC_Employee_ZIP, 
Src_Employee_SSN, Src_Employee_DOB, 
Src_Employee_Home_Phone, Src_Employee_Cell_Phone, Src_Employee_Work_Phone, Src_Employee_Personal_Email, Src_Employee_Work_Email,
SRC_Employee_MIN_ACTIVITY_DATE, SRC_Employee_MAX_ACTIVITY_DATE, 
SRC_Employee_ADDRESS_PROCESSED_FLAG, SRC_Employee_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG, 
Src_Employee_DOB_Successfully_Cleansed_Flag, Src_Employee_SSN_Successfully_Cleansed_Flag, 
Src_Employee_Home_Phone_Successfully_Cleansed_Flag, Src_Employee_Cell_Phone_Successfully_Cleansed_Flag, Src_Employee_Work_Phone_Successfully_Cleansed_Flag, 
Src_Employee_Personal_Email_Successfully_Cleansed_Flag, Src_Employee_Work_Email_Successfully_Cleansed_Flag,
ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY)
VALUES
(src.Source_System_ID, src.System_Code, src.Employee_ID, src.Employee_First_Name, src.Employee_Last_Name, 
src.SRC_Employee_ADDRESS, src.SRC_Employee_CITY, src.SRC_Employee_STATE_CODE, src.SRC_Employee_ZIP, 
src.Src_Employee_SSN, src.Src_Employee_DOB, 
src.Src_Employee_Home_Phone, src.Src_Employee_Cell_Phone, src.Src_Employee_Work_Phone, 
src.Src_Employee_Personal_Email, src.Src_Employee_Work_Email,
src.SRC_Employee_MIN_ACTIVITY_DATE, src.SRC_Employee_MAX_ACTIVITY_DATE, 
src.SRC_Employee_ADDRESS_PROCESSED_FLAG, src.SRC_Employee_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG, 
src.Src_Employee_DOB_Successfully_Cleansed_Flag, src.Src_Employee_SSN_Successfully_Cleansed_Flag, 
src.Src_Employee_Home_Phone_Successfully_Cleansed_Flag, src.Src_Employee_Cell_Phone_Successfully_Cleansed_Flag, src.Src_Employee_Work_Phone_Successfully_Cleansed_Flag, 
src.Src_Employee_Personal_Email_Successfully_Cleansed_Flag, src.Src_Employee_Work_Email_Successfully_Cleansed_Flag,
src.ETL_TASK_KEY, src.ETL_INSERTED_TASK_KEY, src.ETL_INSERTED_DATE, src.ETL_INSERTED_BY, src.ETL_LAST_UPDATED_DATE, src.ETL_LAST_UPDATED_BY);



 SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    
 EOT
}

