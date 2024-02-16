CREATE OR REPLACE PROCEDURE DISC_PROD.DATA_CLEANSING.GET_AXXESS_SRC_CLIENT("STR_ETL_TASK_KEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME:  AXXESS_SRC_CLIENT
--
-- PURPOSE: Creates script for data cleanse for AXXESS source
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 07/25/23     Darshan Gosai           Initial development
--*****************************************************************************************************************************
--


MERGE INTO DISC_PROD.DATA_CLEANSING.Client_SRC_ATTRIBUTES AS tgt
USING
(
WITH source_client_addresses
AS
(
SELECT 
SOURCE_SYSTEM_ID
,SYSTEM_CODE
,Client_ID
,Client_First_Name
,Client_Last_Name,
SRC_Client_ADDRESS ,
SRC_Client_CITY,
SRC_Client_STATE_CODE,
SRC_Client_ZIP,
Src_Client_Zip4 ,
Src_Client_SSN ,
Src_Client_DOB,
Src_Client_Home_Phone,
Src_Client_Cell_Phone,
Src_Client_Work_Phone,
Src_Client_Personal_Email,
Src_Client_Work_Email,
SRC_Client_Min_Activity_Date,
SRC_Client_Max_Activity_Date,
SRC_Client_Address_Processed_Flag,
SRC_Client_Address_Successfully_Cleansed_Flag
FROM (	
select ROW_NUMBER() OVER (PARTITION BY Client_ID ORDER BY MEDICAL_RECORD_NUMBER  DESC) AS RANK,*  from (SELECT
14 AS SOURCE_SYSTEM_ID
,''PRIME'' AS SYSTEM_CODE
,TRIM( CAST( cust.Patient_ID AS VARCHAR)) AS Client_ID
,cust.MEDICAL_RECORD_NUMBER
,UPPER( TRIM( cust.First_Name)) AS Client_First_Name
,UPPER( TRIM( cust.Last_Name)) AS Client_Last_Name
,UPPER( TRIM( IFNULL( TRIM(cust.Address) , ''''))) AS SRC_Client_ADDRESS 
,UPPER( TRIM( cust.CITY)) AS SRC_Client_CITY
,UPPER( TRIM( cust.STATE)) AS SRC_Client_STATE_CODE
,UPPER( TRIM( LEFT(cust.Zip_Code,5)))  AS SRC_Client_ZIP  
,CAST( NULL AS VARCHAR) AS Src_Client_Zip4
,UPPER( TRIM( cust.SSN)) AS Src_Client_SSN
,CAST( cust.Date_of_Birth AS DATE) AS Src_Client_DOB
,UPPER( TRIM( cust.EMERGENCY_CONTACT_PHONE)) AS Src_Client_Home_Phone
,UPPER( TRIM( cust.PHONE)) AS Src_Client_Cell_Phone
,CAST( NULL AS VARCHAR) AS Src_Client_Work_Phone
,UPPER( TRIM( PE.EMAIL_ADDRESS)) AS Src_Client_Personal_Email
,CAST( NULL AS VARCHAR) AS Src_Client_Work_Email
,MIN( COALESCE( TRY_CAST( LEFT( VI.VISIT_Date, 10) AS DATE), TRY_CAST( LEFT( VI.Start_Date,10) AS DATE))) AS SRC_Client_Min_Activity_Date
,MAX( COALESCE( TRY_CAST( LEFT( VI.VISIT_Date, 10) AS DATE), TRY_CAST( LEFT( VI.Start_Date,10) AS DATE))) AS SRC_Client_Max_Activity_Date
,CAST( FALSE AS BOOLEAN) AS SRC_Client_Address_Processed_Flag
,CAST( FALSE AS BOOLEAN) AS SRC_Client_Address_Successfully_Cleansed_Flag
FROM DISC_PROD.Axxess.Axxess_PatientInfo AS cust
LEFT JOIN (SELECT DISTINCT PATIENT_ID ,EMAIL_ADDRESS FROM DISC_PROD.AXXESS.AXXESS_EPISODESNAPSHOTS) PE ON CUST.PATIENT_ID = PE.PATIENT_ID
LEFT JOIN DISC_PROD.Axxess.Axxess_VisitInfo VI ON VI.Patient_ID = cust.Patient_ID
WHERE cust.PATIENT_ID IS NOT NULL
GROUP BY 1, 2, 3, 4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,21,22

UNION ALL 
SELECT DISTINCT  
14 AS SOURCE_SYSTEM_ID
,''PRIME'' AS SYSTEM_CODE
,TRIM( CAST( CA.CLIENT_ID AS VARCHAR)) AS Client_ID 
,ca.MRN AS MEDICAL_RECORD_NUMBER
,UPPER( TRIM( CA.CLIENT_FIRST_NAME)) AS Client_First_Name
,UPPER( TRIM( CA.CLIENT_LAST_NAME)) AS Client_Last_Name
,UPPER( TRIM( IFNULL( TRIM(CA.CLIENT_ADDRESS1) , '''') ||'' ''|| IFNULL( TRIM(CA.CLIENT_ADDRESS2), ''''))) AS SRC_Client_ADDRESS 
,UPPER( TRIM( CA.CLIENT_CITY)) AS SRC_Client_CITY
,UPPER( TRIM( CA.CLIENT_STATE)) AS SRC_Client_STATE_CODE
,UPPER( TRIM( CA.CLIENT_ZIP))  AS SRC_Client_ZIP
,CAST( NULL AS VARCHAR) AS Src_Client_Zip4
,NULL AS Src_Client_SSN
,CAST( CA.CLIENT_DOB AS DATE) AS Src_Client_DOB
,CAST( NULL AS VARCHAR) AS Src_Client_Home_Phone
,CAST( NULL AS VARCHAR) AS Src_Client_Cell_Phone
,CAST( NULL AS VARCHAR) AS Src_Client_Work_Phone
,UPPER( TRIM( PE.EMAIL_ADDRESS)) AS Src_Client_Personal_Email
,CAST( NULL AS VARCHAR) AS Src_Client_Work_Email
,MIN( COALESCE( TRY_CAST( LEFT( V.VISIT_Date, 10) AS DATE), TRY_CAST( LEFT( V.Start_Date,10) AS DATE))) AS SRC_Client_Min_Activity_Date
,MAX( COALESCE( TRY_CAST( LEFT( V.VISIT_Date, 10) AS DATE), TRY_CAST( LEFT( V.Start_Date,10) AS DATE))) AS SRC_Client_Max_Activity_Date
,CAST( FALSE AS BOOLEAN) AS SRC_Client_Address_Processed_Flag
,CAST( FALSE AS BOOLEAN) AS SRC_Client_Address_Successfully_Cleansed_Flag
FROM DISC_PROD.AXXESS.AXXESS_CAREPERIODS CA
LEFT JOIN (SELECT DISTINCT PATIENT_ID ,EMAIL_ADDRESS FROM DISC_PROD.AXXESS.AXXESS_EPISODESNAPSHOTS) PE ON CA.CLIENT_ID = PE.PATIENT_ID
LEFT JOIN DISC_PROD.Axxess.Axxess_VisitInfo V ON V.Patient_ID = CA.CLIENT_ID
WHERE CA.CLIENT_ID IS NOT NULL
GROUP BY 1, 2, 3, 4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,21,22) 
) QUALIFY RANK = 1 
)
SELECT  
Source_System_ID 
,System_Code
,Client_ID
,Client_First_Name 
,Client_Last_Name 
,TRIM( dca.Src_Client_Address) Src_Client_Address 
,TRIM( dca.Src_Client_City) Src_Client_City
,TRIM( dca.Src_Client_State_Code) Src_Client_State_Code 
,TRIM( dca.Src_Client_Zip) Src_Client_Zip
,TRIM( dca.Src_Client_Zip4) Src_Client_Zip4
,TRIM( dca.Src_Client_SSN) Src_Client_SSN
,dca.Src_Client_DOB
,TRIM( dca.Src_Client_Home_Phone) Src_Client_Home_Phone
,TRIM( dca.Src_Client_Cell_Phone) Src_Client_Cell_Phone
,TRIM( dca.Src_Client_Work_Phone) Src_Client_Work_Phone
,TRIM( dca.Src_Client_Personal_Email) Src_Client_Personal_Email
,TRIM( dca.Src_Client_Work_Email) Src_Client_Work_Email
,SRC_Client_Min_Activity_Date, SRC_Client_Max_Activity_Date
,SRC_Client_Address_Processed_Flag, Src_Client_Address_Successfully_Cleansed_Flag
,CAST( FALSE AS BOOLEAN) AS Src_Client_DOB_Successfully_Cleansed_Flag
,CAST( FALSE AS BOOLEAN) AS Src_Client_SSN_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Client_Home_Phone_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Client_Cell_Phone_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Client_Work_Phone_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Client_Personal_Email_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Client_Work_Email_Successfully_Cleansed_Flag
,:STR_ETL_TASK_KEY AS ETL_TASK_KEY
,:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY 
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
FROM source_client_addresses AS dca
ORDER BY 1
) AS src
ON src.Source_System_ID = tgt.Source_System_ID
AND src.System_Code = tgt.System_Code
AND src.Client_ID = tgt.Client_ID
WHEN MATCHED AND (IFNULL( src.Client_First_Name, ''~!@#$%^&*()+'') <> IFNULL( tgt.Client_First_Name, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Client_Last_Name, ''~!@#$%^&*()+'') <> IFNULL( tgt.Client_Last_Name, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Client_SSN, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_SSN, ''~!@#$%^&*()+'')
              OR  IFNULL( CAST( src.Src_Client_DOB AS VARCHAR), ''~!@#$%^&*()+'') <> IFNULL( CAST( tgt.Src_Client_DOB AS VARCHAR), ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Client_Home_Phone, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_Home_Phone, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Client_Cell_Phone, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_Cell_Phone, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Client_Work_Phone, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_Work_Phone, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Client_Personal_Email, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_Personal_Email, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Client_Work_Email, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_Work_Email, ''~!@#$%^&*()+''))
 THEN UPDATE SET  tgt.Client_First_Name = src.Client_First_Name,
                  tgt.Client_Last_Name = src.Client_Last_Name,                  
                  tgt.Src_Client_SSN = src.Src_Client_SSN,
                  tgt.Src_Client_DOB = src.Src_Client_DOB,
                  tgt.Src_Client_Home_Phone = src.Src_Client_Home_Phone,
                  tgt.Src_Client_Cell_Phone = src.Src_Client_Cell_Phone,
                  tgt.Src_Client_Work_Phone = src.Src_Client_Work_Phone,
                  tgt.Src_Client_Personal_Email = src.Src_Client_Personal_Email,
                  tgt.Src_Client_Work_Email = src.Src_Client_Work_Email,
                  tgt.Src_Client_Min_Activity_Date = src.Src_Client_Min_Activity_Date,
                  tgt.Src_Client_Max_Activity_Date = src.Src_Client_Max_Activity_Date,                  
                  tgt.Src_Client_DOB_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Client_SSN_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Client_Home_Phone_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Client_Cell_Phone_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Client_Work_Phone_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Client_Personal_Email_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Client_Work_Email_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.ETL_Task_Key = src.ETL_Task_Key,
                  tgt.ETL_Last_Updated_Date = src.ETL_Last_Updated_Date,
                  tgt.ETL_Last_Updated_By = src.ETL_Last_Updated_By
WHEN MATCHED AND (
                  IFNULL( src.Src_Client_Address, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_Address, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Client_City, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_City, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Client_State_Code, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_State_Code, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Client_Zip, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_Zip, ''~!@#$%^&*()+'')    
)
THEN UPDATE SET 
                  tgt.Src_Client_Address = src.Src_Client_Address,
                  tgt.Src_Client_City = src.Src_Client_City,
                  tgt.Src_Client_State_Code = src.Src_Client_State_Code,
                  tgt.Src_Client_Zip = src.Src_Client_Zip,
                  tgt.Src_Client_Address_Processed_Flag = CAST( FALSE AS BOOLEAN),
                  tgt.Src_Client_Address_Successfully_Cleansed_Flag = CAST( FALSE AS BOOLEAN)
WHEN MATCHED AND (IFNULL( src.Src_Client_Min_Activity_Date, ''1000-01-01'') <> IFNULL( tgt.Src_Client_Min_Activity_Date, ''1000-01-01'')
              OR  IFNULL( src.Src_Client_Max_Activity_Date, ''1000-01-01'') <> IFNULL( tgt.Src_Client_Max_Activity_Date, ''1000-01-01''))
 THEN UPDATE SET  tgt.Src_Client_Min_Activity_Date = src.Src_Client_Min_Activity_Date,
                  tgt.Src_Client_Max_Activity_Date = src.Src_Client_Max_Activity_Date,
                  tgt.ETL_Task_Key = src.ETL_Task_Key,
                  tgt.ETL_Last_Updated_Date = src.ETL_Last_Updated_Date,
                  tgt.ETL_Last_Updated_By = src.ETL_Last_Updated_By
WHEN NOT MATCHED THEN INSERT
(Source_System_ID, System_Code, Client_ID, Client_First_Name, Client_Last_Name, 
SRC_Client_ADDRESS, SRC_Client_CITY, SRC_Client_STATE_CODE, SRC_Client_ZIP, 
Src_Client_SSN, Src_Client_DOB, 
Src_Client_Home_Phone, Src_Client_Cell_Phone, Src_Client_Work_Phone, Src_Client_Personal_Email, Src_Client_Work_Email,
SRC_Client_MIN_ACTIVITY_DATE, SRC_Client_MAX_ACTIVITY_DATE, 
SRC_Client_ADDRESS_PROCESSED_FLAG, SRC_Client_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG, 
Src_Client_DOB_Successfully_Cleansed_Flag, Src_Client_SSN_Successfully_Cleansed_Flag, 
Src_Client_Home_Phone_Successfully_Cleansed_Flag, Src_Client_Cell_Phone_Successfully_Cleansed_Flag, Src_Client_Work_Phone_Successfully_Cleansed_Flag, 
Src_Client_Personal_Email_Successfully_Cleansed_Flag, Src_Client_Work_Email_Successfully_Cleansed_Flag,
ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY)
VALUES
(src.Source_System_ID, src.System_Code, src.Client_ID, src.Client_First_Name, src.Client_Last_Name, 
src.SRC_Client_ADDRESS, src.SRC_Client_CITY, src.SRC_Client_STATE_CODE, src.SRC_Client_ZIP, 
src.Src_Client_SSN, src.Src_Client_DOB, 
src.Src_Client_Home_Phone, src.Src_Client_Cell_Phone, src.Src_Client_Work_Phone, 
src.Src_Client_Personal_Email, src.Src_Client_Work_Email,
src.SRC_Client_MIN_ACTIVITY_DATE, src.SRC_Client_MAX_ACTIVITY_DATE, 
src.SRC_Client_ADDRESS_PROCESSED_FLAG, src.SRC_Client_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG, 
src.Src_Client_DOB_Successfully_Cleansed_Flag, src.Src_Client_SSN_Successfully_Cleansed_Flag, 
src.Src_Client_Home_Phone_Successfully_Cleansed_Flag, src.Src_Client_Cell_Phone_Successfully_Cleansed_Flag, src.Src_Client_Work_Phone_Successfully_Cleansed_Flag, 
src.Src_Client_Personal_Email_Successfully_Cleansed_Flag, src.Src_Client_Work_Email_Successfully_Cleansed_Flag,
src.ETL_TASK_KEY, src.ETL_INSERTED_TASK_KEY, src.ETL_INSERTED_DATE, src.ETL_INSERTED_BY, src.ETL_LAST_UPDATED_DATE, src.ETL_LAST_UPDATED_BY);

 SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    ';