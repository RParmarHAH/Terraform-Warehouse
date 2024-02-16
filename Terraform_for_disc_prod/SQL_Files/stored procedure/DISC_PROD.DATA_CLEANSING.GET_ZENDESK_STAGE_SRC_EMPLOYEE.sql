CREATE OR REPLACE PROCEDURE DISC_PROD.DATA_CLEANSING.GET_ZENDESK_STAGE_SRC_EMPLOYEE("STR_ETL_TASK_KEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
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


INSERT OVERWRITE INTO  DISC_PROD.DATA_CLEANSING.EMPLOYEE_SRC_ZENDESK_ATTRIBUTES
WITH source_Employee_addresses
AS
(
WITH FOR_NULL_NAMES AS 
(SELECT ID, NAME,SPLIT_PART(NAME,'' '',1) AS FIRST_NAME,
        CASE WHEN REGEXP_COUNT(NAME, '' '') > 1 
             THEN SPLIT_PART(NAME,'' '',2) -- if number of spaces are more than one then taking second word as middle name
        END AS MIDDLE_NAME,
        CASE WHEN REGEXP_COUNT(NAME, '' '') >=2 
             THEN SUBSTR(NAME, LENGTH(SUBSTR(NAME, 1, POSITION('' '', NAME, POSITION('' '', NAME) + 1) - 1)) + 1)
             WHEN REGEXP_COUNT(NAME, '' '') = 1 
             THEN SPLIT_PART(NAME,'' '',-1)
        END AS LAST_NAME
FROM DISC_PROD.ZENDESK."USER"
WHERE name NOT LIKE ''%@%''
  AND name NOT REGEXP ''^[0-9]{3}-[0-9]{3}''
  AND name NOT REGEXP ''^[0-9]{2}-[0-9]{4}''
  AND NOT (name  ILIKE ANY (''+1%'',''+2%'',''+8%'',''CALLER%'',''REPLY+%'',''EMAILCUSTOMER%'',''???%''))
AND NOT (NAME REGEXP ''^[0-9-]+$'')
AND USER_FIELDS_FIRST_NAME IS NULL
AND LEN("NAME") <> 64 -- some keys are coming of length 64, excluding those
AND LEN(COALESCE(FIRST_NAME,'''')) <= 50
AND LEN(COALESCE(MIDDLE_NAME,'''')) <= 50
AND LEN(COALESCE(LAST_NAME,'''')) <= 50
)

SELECT  
      25 AS SOURCE_SYSTEM_ID 
     ,CASE Z.SOURCE WHEN ''Payroll'' THEN ''ZENDESK_PAYROLL''
                  WHEN ''AMS'' THEN ''ZENDESK_AMS'' 
                  END AS SYSTEM_CODE 
     ,Z.Employee_ID  
      ,UPPER( TRIM(COALESCE ( Z.USER_FIELDS_FIRST_NAME,NN.FIRST_NAME))) AS Employee_First_Name
     ,UPPER( TRIM( COALESCE (Z.USER_FIELDS_LAST_NAME,NN.LAST_NAME))) AS Employee_Last_Name
     ,CAST( NULL AS VARCHAR) AS Src_Employee_Address
     ,CAST( NULL AS VARCHAR) AS  SRC_Employee_CITY
     ,UPPER( S.STATE_ISO_CODE) AS SRC_Employee_STATE_CODE
     ,CAST( NULL AS VARCHAR) AS Src_Employee_Zip
     ,CAST( NULL AS VARCHAR) AS Src_Employee_Zip4
    , CAST( NULL AS VARCHAR)  AS Src_Employee_SSN
    ,CAST( NULL AS VARCHAR)  AS SRC_EMPLOYEE_DOB
     ,UPPER( TRIM( Z.USER_FIELDS_HOME_PHONE)) AS Src_Employee_Home_Phone
     ,UPPER( TRIM( Z.USER_FIELDS_CELL_PHONE)) AS Src_Employee_Cell_Phone
    ,UPPER( TRIM( Z.PHONE)) AS Src_Employee_Work_Phone
    ,UPPER( TRIM( Z.USER_FIELDS_PERSONAL_EMAIL)) AS Src_Employee_Personal_Email
    ,UPPER( TRIM(CASE WHEN EMAIL ILIKE ''%gmartinkus@prod.exchangelabs.com%'' 
    THEN ''gmartinkus@prod.exchangelabs.com'' 
    ELSE EMAIL 
    END)) AS Src_Employee_Work_Email
    ,CAST( ''2040-12-31'' AS DATE) AS SRC_Employee_Min_Activity_Date
    ,CAST( ''1900-01-01'' AS DATE) AS SRC_Employee_Max_Activity_Date
    ,CAST( FALSE AS BOOLEAN) AS SRC_Employee_Address_Processed_Flag
    ,CAST( FALSE AS BOOLEAN) AS SRC_Employee_Address_Successfully_Cleansed_Flag

FROM (SELECT Id::VARCHAR(50) AS Employee_ID, * FROM  DISC_PROD.ZENDESK.USER) Z 
LEFT JOIN FOR_NULL_NAMES NN 
    ON NN.ID = Z.ID
LEFT JOIN DW_PROD.HAH.DIM_STATE S
ON REPLACE(UPPER(TRIM(Z.USER_FIELDS_STATE)),''_'','' '') = UPPER(TRIM(S.STATE_NAME))
WHERE Z.ID IS NOT NULL
GROUP BY ALL
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
,SRC_Employee_Min_Activity_Date
,SRC_Employee_Max_Activity_Date
,SRC_Employee_Address_Processed_Flag
,Src_Employee_Address_Successfully_Cleansed_Flag
,TRIM( dca.Src_Employee_SSN) Src_Employee_SSN
,dca.Src_Employee_DOB
,TRIM( dca.Src_Employee_Home_Phone) Src_Employee_Home_Phone
,TRIM( dca.Src_Employee_Cell_Phone) Src_Employee_Cell_Phone
,TRIM( dca.Src_Employee_Work_Phone) Src_Employee_Work_Phone 
,TRIM( dca.Src_Employee_Personal_Email) Src_Employee_Personal_Email
,TRIM( dca.Src_Employee_Work_Email) Src_Employee_Work_Email
,CAST( FALSE AS BOOLEAN) AS Src_Employee_SSN_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Employee_DOB_Successfully_Cleansed_Flag
,CAST( FALSE AS BOOLEAN) AS Src_Employee_Home_Phone_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Employee_Cell_Phone_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Employee_Work_Phone_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Employee_Personal_Email_Successfully_Cleansed_Flag 
,CAST( FALSE AS BOOLEAN) AS Src_Employee_Work_Email_Successfully_Cleansed_Flag
,''1'' AS ETL_TASK_KEY
,''1'' AS ETL_INSERTED_TASK_KEY
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE
,CURRENT_USER as ETL_INSERTED_BY 
,convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE
,CURRENT_USER as ETL_LAST_UPDATED_BY
FROM source_Employee_addresses AS dca
ORDER BY 1;



 SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    ';