CREATE OR REPLACE PROCEDURE DISC_PROD.DATA_CLEANSING.GET_AXXESS_SRC_EMPLOYEE("STR_ETL_TASK_KEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS ' 
DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME:  AXXESS_SRC_Employee
--
-- PURPOSE: Creates script for data cleanse for AXXESS source
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 07/25/23     Darshan Gosai           Initial development
--*****************************************************************************************************************************
--

MERGE INTO DISC_PROD.DATA_CLEANSING.EMPLOYEE_SRC_ATTRIBUTES AS tgt
USING
(
WITH source_Employee_addresses
AS
(
SELECT DISTINCT
14 AS SOURCE_SYSTEM_ID 
,''PRIME'' AS SYSTEM_CODE,
TRIM( CAST( EI.SYSTEM_EMPLOYEE_ID AS VARCHAR)) AS Employee_ID,
UPPER( TRIM(EI.FIRST_NAME)) AS Employee_First_Name, 
UPPER( TRIM(EI.LAST_NAME)) AS Employee_Last_Name,
UPPER(TRIM(EI.ADDRESS_LINE_1)) AS Src_Employee_Address
,NVL(TRIM(EI.ADDRESS_CITY),GEO.CITY_PRIMARY_NAME) AS Src_Employee_City
,UPPER(TRIM(EI.ADDRESS_STATECODE))  Src_Employee_STATE_CODE
,UPPER( TRIM( EI.ADDRESS_ZIPCODE)) AS Src_Employee_Zip
,CAST( NULL AS VARCHAR) AS Src_Employee_Zip4
,UPPER( TRIM(EI.SSN)) AS Src_Employee_SSN
,CAST(EI.DATE_OF_BIRTH AS DATE) AS Src_Employee_DOB
--,TRY_TO_DATE(TRIM(EI.DATE_OF_BIRTH),''MM/DD/YYYY HH12:MI:SS AM'') AS Src_Employee_DOB
,CAST( NULL AS VARCHAR) AS Src_Employee_Home_Phone
,CAST( NULL AS VARCHAR) AS Src_Employee_Cell_Phone
,CAST( NULL AS VARCHAR) AS Src_Employee_Work_Phone
,CAST( NULL AS VARCHAR) AS Src_Employee_Personal_Email
,CAST( NULL AS VARCHAR) AS Src_Employee_Work_Email
,MIN( IFNULL( TD.VISIT_START, CAST( ''2040-12-31'' AS DATE))) AS Src_Employee_Min_Activity_Date,
MAX( IFNULL( TD.VISIT_START, CAST( ''1900-01-01'' AS DATE))) AS Src_Employee_Max_Activity_Date
,CAST( FALSE AS BOOLEAN) AS SRC_Employee_Address_Processed_Flag
,CAST( FALSE AS BOOLEAN) AS SRC_Employee_Address_Successfully_Cleansed_Flag
FROM DISC_PROD.AXXESS.AXXESS_HH_EMPLOYEEINFO EI
--FROM DISC_PROD.AXXESS.AXXESS_EMPLOYEEINFO EI
LEFT JOIN DW_PROD.HAH.DIM_GEOGRAPHY GEO ON EI.ADDRESS_ZIPCODE = GEO.ZIP_CODE 
LEFT JOIN 
(
SELECT SCHEDULED_TASK_ID, CAREPERIOD_CASEMANAGER_NAME, CLINICIAN_ID, CLINICIAN_NAME , count(1)
FROM DISC_PROD.AXXESS.AXXESS_VISITFINANCIALS 
GROUP BY SCHEDULED_TASK_ID, CAREPERIOD_CASEMANAGER_NAME, CLINICIAN_ID,CLINICIAN_NAME
)VF   ON EI.EMPLOYEE_ID = VF.CLINICIAN_ID 
LEFT JOIN DISC_PROD.AXXESS.AXXESS_TASKDETAILS TD
ON nvl(TD.SCHEDULED_TASK_ID,'''') = nvl(VF.SCHEDULED_TASK_ID,'''')
GROUP BY 1, 2, 3, 4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,21

UNION 

SELECT DISTINCT
14 AS SOURCE_SYSTEM_ID 
,''PRIME'' AS SYSTEM_CODE,
TRIM( CAST( WD.SYSTEM_EMPLOYEE_ID AS VARCHAR)) AS Employee_ID,
UPPER( TRIM(WD.WORKER_FIRSTNAME)) AS Employee_First_Name, 
UPPER( TRIM(WD.WORKER_LASTNAME)) AS Employee_Last_Name,
CAST( NULL AS VARCHAR)  AS Src_Employee_Address
,CAST( NULL AS VARCHAR)  AS Src_Employee_City
,CAST( NULL AS VARCHAR)   Src_Employee_STATE_CODE
,CAST( NULL AS VARCHAR)  AS Src_Employee_Zip
,CAST( NULL AS VARCHAR) AS Src_Employee_Zip4
,NULL AS Src_Employee_SSN
,NULL AS Src_Employee_DOB
,CAST( NULL AS VARCHAR) AS Src_Employee_Home_Phone
,CAST( NULL AS VARCHAR) AS Src_Employee_Cell_Phone
,UPPER( TRIM( WD.PRIMARY_PHONE_NUMBER)) AS Src_Employee_Work_Phone
,CAST( NULL AS VARCHAR) AS Src_Employee_Personal_Email
,CAST( NULL AS VARCHAR) AS Src_Employee_WORK_Email
--UPPER( TRIM( WD.USER_EMAIL)) AS Src_Employee_Work_Email
,MIN( IFNULL( TD.VISIT_START, CAST( ''2040-12-31'' AS DATE))) AS Src_Employee_Min_Activity_Date,
MAX( IFNULL( TD.VISIT_START, CAST( ''1900-01-01'' AS DATE))) AS Src_Employee_Max_Activity_Date
,CAST( FALSE AS BOOLEAN) AS SRC_Employee_Address_Processed_Flag
,CAST( FALSE AS BOOLEAN) AS SRC_Employee_Address_Successfully_Cleansed_Flag
FROM DISC_PROD.AXXESS.AXXESS_HC_EMPLOYEEINFO WD 
--FROM DISC_PROD.AXXESS.AXXESS_WORKERDETAILS WD
LEFT JOIN 
(
SELECT SCHEDULED_TASK_ID, CAREPERIOD_CASEMANAGER_NAME, CLINICIAN_ID, CLINICIAN_NAME , count(1)
FROM DISC_PROD.AXXESS.AXXESS_VISITFINANCIALS 
GROUP BY SCHEDULED_TASK_ID, CAREPERIOD_CASEMANAGER_NAME, CLINICIAN_ID,CLINICIAN_NAME
)VF   ON WD.EMPLOYEE_ID = VF.CLINICIAN_ID 
LEFT JOIN DISC_PROD.AXXESS.AXXESS_TASKDETAILS TD
ON nvl(TD.SCHEDULED_TASK_ID,'''') = nvl(VF.SCHEDULED_TASK_ID,'''')
GROUP BY 1, 2, 3, 4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,21
)
SELECT 
Source_System_ID 
,System_Code
,Employee_ID
,Employee_First_Name 
,Employee_Last_Name 
,TRIM( dca.Src_Employee_Address) Src_Employee_Address
,TRIM( dca.Src_Employee_City) Src_Employee_City
,TRIM( dca.Src_Employee_State_Code) Src_Employee_State_Code
,TRIM( dca.Src_Employee_Zip) Src_Employee_Zip
,TRIM( dca.Src_Employee_Zip4) Src_Employee_Zip4
,TRIM( dca.Src_Employee_SSN) Src_Employee_SSN
,dca.Src_Employee_DOB
,TRIM( dca.Src_Employee_Home_Phone) Src_Employee_Home_Phone
,TRIM( dca.Src_Employee_Cell_Phone) Src_Employee_Cell_Phone
,TRIM( dca.Src_Employee_Work_Phone) Src_Employee_Work_Phone 
,TRIM( dca.Src_Employee_Personal_Email) Src_Employee_Personal_Email
,TRIM( dca.Src_Employee_Work_Email) Src_Employee_Work_Email
,SRC_Employee_Min_Activity_Date
,SRC_Employee_Max_Activity_Date
,SRC_Employee_Address_Processed_Flag
,Src_Employee_Address_Successfully_Cleansed_Flag
,CAST( FALSE AS BOOLEAN) AS Src_Employee_DOB_Successfully_Cleansed_Flag
,CAST( FALSE AS BOOLEAN) AS Src_Employee_SSN_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Employee_Home_Phone_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Employee_Cell_Phone_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Employee_Work_Phone_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Employee_Personal_Email_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Employee_Work_Email_Successfully_Cleansed_Flag
,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY 
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
FROM source_Employee_addresses AS dca
ORDER BY 1
) AS src
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
    ';