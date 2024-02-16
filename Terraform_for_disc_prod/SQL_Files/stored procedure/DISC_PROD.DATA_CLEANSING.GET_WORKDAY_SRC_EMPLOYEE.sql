CREATE OR REPLACE PROCEDURE DISC_PROD.DATA_CLEANSING.GET_WORKDAY_SRC_EMPLOYEE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME:  WORKDAY_SRC_Employee
--
-- PURPOSE: Creates script for data cleanse for WORKDAY source
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 07/25/23     Darshan Gosai           Initial development
-- 10/30/23     Pooja Bagane		    Added logic to get WORKDAY DATA
--*****************************************************************************************************************************
--
MERGE INTO DISC_PROD.DATA_CLEANSING.EMPLOYEE_SRC_ATTRIBUTES  AS tgt
USING
(
WITH source_Employee_addresses
AS
(
WITH IAD AS (
	SELECT
		EMPLOYEE_ID,
		ID
	FROM
		DISC_PROD.WORKDAY.WORKER_IDENTIFICATION_DATA
	WHERE ID_TYPE = ''USA-SSN''
	GROUP BY EMPLOYEE_ID, ID
)
,NAME_DETAIL AS (
	SELECT
		EMPLOYEE_ID,
		NULLIF(TRIM(UPPER(FIRST_NAME)),'''') AS FIRST_NAME,
		NULLIF(TRIM(UPPER(LAST_NAME)),'''') AS LAST_NAME
	FROM
		DISC_PROD.WORKDAY.WORKER_NAME_DATA
	WHERE NAME_TYPE = ''Legal''
	GROUP BY
		EMPLOYEE_ID,FIRST_NAME,LAST_NAME
)
,HOME_ADDRESS_DATA AS (
	SELECT
		HAD.EMPLOYEE_ID,
		NULLIF(UPPER(TRIM(HAD.ADDRESS_LINE_DATA)),'''')  AS ADDRESS_LINE_1,
		NULLIF(UPPER(TRIM(HAD.ADDRESS_LINE_DATA_2)),'''') AS ADDRESS_LINE_2,
		NULLIF(UPPER(TRIM(HAD.MUNICIPALITY)),'''') AS CITY,
		NULLIF(UPPER(TRIM(HAD.REGION)),'''') AS STATE,
		NULLIF(UPPER(TRIM(HAD.POSTAL_CODE)),'''') AS ZIP
	FROM
		DISC_PROD.WORKDAY.WORKER_ADDRESS_DATA HAD
	WHERE HAD.ADDRESS_TYPE = ''HOME'' --AND WAD.IS_PRIMARY = TRUE
	GROUP BY
		HAD.EMPLOYEE_ID, HAD.ADDRESS_LINE_DATA, HAD.ADDRESS_LINE_DATA_2, HAD.MUNICIPALITY, HAD.REGION, HAD.POSTAL_CODE
)
,PHONE_DETAIL AS (
	SELECT
		EMPLOYEE_ID,
		MAX(CASE WHEN PHONE_TYPE = ''HOME'' THEN PHONE_TYPE END) AS HOME_PHONE_TYPE,
		MAX(CASE WHEN PHONE_TYPE = ''HOME'' THEN PHONE_DEVICE_TYPE END) AS HOME_PHONE_DEVICE_TYPE,
		MAX(CASE WHEN PHONE_TYPE = ''HOME'' THEN PHONE_AREA_CODE END) AS HOME_PHONE_AREA_CODE,
		MAX(CASE WHEN PHONE_TYPE = ''HOME'' THEN PHONE_NUMBER END) AS HOME_PHONE_NUMBER,
		MAX(CASE WHEN PHONE_TYPE = ''WORK'' THEN PHONE_TYPE END) AS WORK_PHONE_TYPE,
		MAX(CASE WHEN PHONE_TYPE = ''WORK'' THEN PHONE_DEVICE_TYPE END) AS WORK_PHONE_DEVICE_TYPE,
		MAX(CASE WHEN PHONE_TYPE = ''WORK'' THEN PHONE_AREA_CODE END) AS WORK_PHONE_AREA_CODE,
		MAX(CASE WHEN PHONE_TYPE = ''WORK'' THEN PHONE_NUMBER END) AS WORK_PHONE_NUMBER
	FROM
		(
			SELECT 
				EMPLOYEE_ID,
				NULLIF(UPPER(TRIM(PHONE_TYPE)),'''') AS PHONE_TYPE,
				NULLIF(UPPER(TRIM(PHONE_DEVICE_TYPE)),'''') AS PHONE_DEVICE_TYPE,
				NULLIF(TRIM(PHONE_AREA_CODE),'''') AS PHONE_AREA_CODE,
				NULLIF(TRIM(PHONE_NUMBER),'''') AS PHONE_NUMBER
			FROM DISC_PROD.WORKDAY.WORKER_PHONE_DATA
			WHERE IS_PRIMARY = TRUE
		)
	GROUP BY EMPLOYEE_ID
)
, EMAIL_DETAIL AS (
	SELECT
		EMPLOYEE_ID,
		MAX(CASE WHEN EMAIL_TYPE = ''HOME'' THEN EMAIL_ADDRESS END) AS HOME_EMAIL_ADDRESS,
		MAX(CASE WHEN EMAIL_TYPE = ''WORK'' THEN EMAIL_ADDRESS END) AS WORK_EMAIL_ADDRESS,
		MAX(ETL_LAST_UPDATED_DATE) AS ETL_LAST_UPDATED_DATE
	FROM
		(
			SELECT 
				EMPLOYEE_ID,
				NULLIF(UPPER(TRIM(EMAIL_TYPE)),'''') AS EMAIL_TYPE,
				NULLIF(UPPER(TRIM(EMAIL_ADDRESS)),'''') AS EMAIL_ADDRESS,
				ETL_LAST_UPDATED_DATE
			FROM DISC_PROD.WORKDAY.WORKER_EMAIL_DATA
			WHERE IS_PRIMARY = TRUE
		)
	GROUP BY 
		EMPLOYEE_ID
)
SELECT
 36 AS SOURCE_SYSTEM_ID
,''Workday'' AS SYSTEM_CODE
,TRIM( CAST(IAD.EMPLOYEE_ID AS VARCHAR)) AS EMPLOYEE_ID
,UPPER( TRIM( ND.FIRST_NAME)) AS EMPLOYEE_FIRST_NAME
,UPPER(TRIM( ND.LAST_NAME)) AS EMPLOYEE_LAST_NAME
,UPPER (TRIM(IFNULL( TRIM( HOME_AD.ADDRESS_LINE_1) , ''''))) || '' - '' || TRIM(IFNULL( TRIM( HOME_AD.ADDRESS_LINE_2) , '''')) AS Src_Employee_Address
,UPPER(TRIM( HOME_AD.CITY)) AS Src_Employee_City
,UPPER(TRIM( HOME_AD.STATE)) AS Src_Employee_State_Code
,UPPER(TRIM( HOME_AD.ZIP)) AS Src_Employee_Zip
,CAST( NULL AS VARCHAR) AS Src_Employee_Zip4
,TRIM( IAD.ID) AS Src_Employee_SSN
,CAST( WP.BIRTH_DATE  AS DATE) AS Src_Employee_DOB
,CASE
		WHEN PED.HOME_PHONE_DEVICE_TYPE = ''LANDLINE'' 
			THEN NVL(CONCAT(PED.HOME_PHONE_AREA_CODE, PED.HOME_PHONE_NUMBER),PED.HOME_PHONE_NUMBER)
	END AS Src_Employee_Home_Phone,
	CASE
		WHEN PED.HOME_PHONE_DEVICE_TYPE = ''MOBILE'' OR PED.WORK_PHONE_DEVICE_TYPE = ''Mobile'' 
			THEN NVL(
					NVL(CONCAT(PED.HOME_PHONE_AREA_CODE ,PED.HOME_PHONE_NUMBER),PED.HOME_PHONE_NUMBER),
					NVL(CONCAT(PED.WORK_PHONE_AREA_CODE ,PED.WORK_PHONE_NUMBER),PED.WORK_PHONE_NUMBER)
					)
	END AS Src_Employee_Cell_Phone
,CASE
		WHEN PED.WORK_PHONE_TYPE IS NOT NULL
			THEN NVL(CONCAT(PED.WORK_PHONE_AREA_CODE, PED.WORK_PHONE_NUMBER),PED.WORK_PHONE_NUMBER)
	END AS Src_Employee_Work_Phone
,ED.HOME_EMAIL_ADDRESS AS Src_Employee_Personal_Email
,ED.WORK_EMAIL_ADDRESS AS Src_Employee_Work_Email
,MIN(WRS.LANDING_INSERTED_DATE ) AS  Src_Employee_Min_Activity_Date
,MAX( WRS.LANDING_INSERTED_DATE ) AS Src_Employee_Max_Activity_Date
,CAST( FALSE AS BOOLEAN) AS SRC_Employee_Address_Processed_Flag
,CAST( FALSE AS BOOLEAN) AS SRC_Employee_Address_Successfully_Cleansed_Flag
FROM DISC_PROD.WORKDAY.WORKER_SUMMARY WS
LEFT JOIN IAD ON WS.EMPLOYEE_ID= IAD.EMPLOYEE_ID
LEFT JOIN NAME_DETAIL ND ON WS.EMPLOYEE_ID =ND.EMPLOYEE_ID
LEFT JOIN HOME_ADDRESS_DATA HOME_AD
ON WS.EMPLOYEE_ID =HOME_AD.EMPLOYEE_ID
LEFT JOIN DISC_PROD.WORKDAY.WORKER_PERSONAL WP
ON WS.EMPLOYEE_ID =WP.EMPLOYEE_ID 
LEFT JOIN PHONE_DETAIL PED ON WS.EMPLOYEE_ID =PED.EMPLOYEE_ID
LEFT JOIN EMAIL_DETAIL ED ON WS.EMPLOYEE_ID =ED.EMPLOYEE_ID
LEFT JOIN DISC_PROD.WORKDAY.WORKER_STATUS WRS ON WS.EMPLOYEE_ID =WRS.EMPLOYEE_ID
WHERE IAD.EMPLOYEE_ID IS NOT NULL
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,21
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