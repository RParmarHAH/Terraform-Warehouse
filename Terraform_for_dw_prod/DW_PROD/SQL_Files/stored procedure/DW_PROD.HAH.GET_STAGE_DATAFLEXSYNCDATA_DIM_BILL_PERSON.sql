CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_DATAFLEXSYNCDATA_DIM_BILL_PERSON("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME:  DATAFLEXSYNCDATA_DIM_BILLPERSON
--
-- PURPOSE: Creates one row per Bill Person according to DataflexSnyc
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 01/06/21    Frank Noordover       Initial development hello
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO STAGE.DataFlexSyncData_DIM_Bill_Person
WITH Employees_Not_Found AS
(
SELECT ''05'' AS Bill_Person_Code, ''ANGELA'' AS First_Name, ''COPE'' AS Last_Name, ''ILL'' AS GP_System_Code, ''219900000249'' AS Employee_ID, ''8fabcbcd4ce74eddb02b1292e8e28650'' AS Employee_Key FROM DUAL
UNION
SELECT NULL AS Bill_Person_Code, ''STACY'' AS First_Name, ''CLARK'' AS Last_Name,  ''ILL'' AS GP_System_Code, ''216000105825'' AS Employee_ID, ''a502049dc7a848cdc88ff21c095227d6'' AS Employee_Key FROM DUAL
UNION
SELECT ''18'' AS Bill_Person_Code, ''ANTHONY'' AS First_Name, ''DELEON'' AS Last_Name,  ''HAHIL'' AS GP_System_Code, ''217900000149'' AS Employee_ID, ''9a256e3378387ce0b51bdda7d864948d'' AS Employee_Key FROM DUAL
UNION
SELECT NULL AS Bill_Person_Code, ''CHARLOTTE'' AS First_Name, ''HAM'' AS Last_Name,  ''STW'' AS GP_System_Code, ''214000077830'' AS Employee_ID, ''1bfbf409e98343a51b9e5645e92c67b7'' AS Employee_Key FROM DUAL
UNION
SELECT ''06'' AS Bill_Person_Code, ''TONI'' AS First_Name, ''TAYLOR'' AS Last_Name,  ''HAHIL'' AS GP_System_Code, ''199900000020'' AS Employee_ID, ''fe939837edc3225327a41a8cf06a0e49'' AS Employee_Key FROM DUAL
UNION
SELECT ''21'' AS Bill_Person_Code, ''STEPHANIE'' AS First_Name, ''LASSISTER'' AS Last_Name,  ''HAHIL'' AS GP_System_Code, ''215900000111'' AS Employee_ID, ''fc95c643d1a3696786d2a773fdea0d45'' AS Employee_Key FROM DUAL
UNION
SELECT ''21'' AS Bill_Person_Code, ''STEPHANIE'' AS First_Name, ''LASSITER'' AS Last_Name,  ''HAHIL'' AS GP_System_Code, ''215900000111'' AS Employee_ID, ''fc95c643d1a3696786d2a773fdea0d45'' AS Employee_Key FROM DUAL
),
Find_Contract_Employee_Key AS
(
SELECT DISTINCT 
       3 AS Dataflex_Source_System_ID,
       NVL( pers.DBName, cntrct.DBName) AS Dataflex_System_Code, 
       CASE WHEN UPPER( pers.NAME) = ''MARTRICIA BOWERS'' THEN ''09'' 
            ELSE NVL( pers.Code, cntrct.BillPersonCode) 
       END AS Bill_Person_Code,
       pers.NAME AS Person_Name,
       LENGTH( TRIM( pers.NAME)) AS Length_of_Name,
       CASE WHEN POSITION( ''OFFICE'', TRIM( UPPER( pers.Name))) <> 0 THEN POSITION( ''OFFICE'', TRIM( UPPER( pers.Name))) + 6
            ELSE 0 
       END AS Start_Of_Name,
       POSITION( '' '', pers.NAME, Start_of_Name+1) AS Start_of_Last_Name,
       TRIM( SUBSTRING( pers.NAME, Start_of_Name, (Start_of_Last_Name - Start_of_Name))) AS First_Name,
       TRIM( SUBSTRING( pers.NAME, Start_of_Last_Name, LENGTH( pers.Name))) AS Last_Name,
       NVL( emp.DB, enf.GP_System_COde) AS GP_System_Code,
       NVL( emp.Employee_ID, enf.Employee_ID) AS GP_Employee_ID,
       CASE WHEN emp.Employee_ID IS NOT NULL THEN MD5( CAST( emp.Employee_ID AS VARCHAR)||''-''|| emp.db )
            ELSE enf.Employee_Key
       END AS GP_Employee_Key,
       CASE WHEN emp.InActive = 0 THEN ''TRUE''
            WHEN emp.InActive IS NULL THEN ''UNKNOWN''
            WHEN emp.InActive <> 0 THEN ''FALSE''
       END AS GP_Active_Employee_Flag
FROM Disc_Prod.DATAFLEXSYNCDATA.DFContracts AS cntrct
LEFT OUTER JOIN Disc_Prod.DATAFLEXSYNCDATA.DFBillPersons AS pers ON cntrct.DBName = pers.DBName AND cntrct.BillPersonCode = pers.Code
LEFT OUTER JOIN Disc_Prod.GPSyncdata.GPAllEmployeesBase AS emp ON emp.DB IN (''HAHIL'') AND REPLACE( pers.NAME, '''''''') LIKE ''%'' || emp.First_Name || ''%''  || emp.Last_Name || ''%''
LEFT OUTER JOIN Employees_Not_Found AS enf ON REPLACE( pers.NAME, '''''''') LIKE ''%'' || enf.First_Name || ''%''  || enf.Last_Name || ''%''
WHERE cntrct.BillPersonCode NOT IN ( ''NA'', ''99'')
ORDER BY Dataflex_Source_System_ID, Person_Name, Bill_Person_Code
),
Find_Invoice_Employee_Key AS
(
SELECT DISTINCT 
       3 AS Dataflex_Source_System_ID,
       NVL( pers.DBName, inv.System_Code) AS Dataflex_System_Code, 
       CASE WHEN UPPER( NVL( pers.NAME, inv.Bill_Representative)) = ''MARTRICIA BOWERS'' THEN ''09'' 
            ELSE NVL( pers.Code, enf.Bill_Person_Code) 
       END AS Bill_Person_Code,
       NVL( pers.NAME, inv.Bill_Representative) AS Person_Name,
       LENGTH( TRIM( NVL( pers.NAME, inv.Bill_Representative))) AS Length_of_Name,
       CASE WHEN POSITION( ''OFFICE'', TRIM( UPPER( NVL( pers.NAME, inv.Bill_Representative)))) <> 0 THEN POSITION( ''OFFICE'', TRIM( UPPER( NVL( pers.NAME, inv.Bill_Representative)))) + 6
            ELSE 0 
       END AS Start_Of_Name,
       POSITION( '' '', NVL( pers.NAME, inv.Bill_Representative), Start_of_Name+1) AS Start_of_Last_Name,
       TRIM( SUBSTRING( NVL( pers.NAME, inv.Bill_Representative), Start_of_Name, (Start_of_Last_Name - Start_of_Name))) AS First_Name,
       TRIM( SUBSTRING( NVL( pers.NAME, inv.Bill_Representative), Start_of_Last_Name, LENGTH( NVL( pers.NAME, inv.Bill_Representative)))) AS Last_Name,
       NVL( emp.DB, enf.GP_System_COde) AS GP_System_Code,
       NVL( emp.Employee_ID, enf.Employee_ID) AS GP_Employee_ID,
       CASE WHEN emp.Employee_ID IS NOT NULL THEN MD5( CAST( emp.Employee_ID AS VARCHAR)||''-''|| emp.db )
            ELSE enf.Employee_Key
       END AS GP_Employee_Key,
       CASE WHEN emp.InActive = 0 THEN ''TRUE''
            WHEN emp.InActive IS NULL THEN ''UNKNOWN''
            WHEN emp.InActive <> 0 THEN ''FALSE''
       END AS GP_Active_Employee_Flag
FROM HAH.DIM_Invoice AS inv
LEFT OUTER JOIN Disc_Prod.DATAFLEXSYNCDATA.DFBillPersons AS pers ON inv.System_Code = pers.DBName AND inv.Bill_Representative = pers.Name
LEFT OUTER JOIN Disc_Prod.GPSyncdata.GPAllEmployeesBase AS emp ON emp.DB IN (''HAHIL'') AND REPLACE( NVL( pers.NAME, inv.Bill_Representative), '''''''') LIKE ''%'' || UPPER( emp.First_Name) || ''%''  || UPPER( emp.Last_Name) || ''%''
LEFT OUTER JOIN Employees_Not_Found AS enf ON REPLACE( NVL( pers.NAME, inv.Bill_Representative), '''''''') LIKE ''%'' || enf.First_Name || ''%''  || enf.Last_Name || ''%''
WHERE inv.Source_System_ID = 3
ORDER BY Dataflex_Source_System_ID, Person_Name, Bill_Person_Code
)
SELECT md5( Dataflex_System_Code || ''-'' || NVL( GP_Employee_ID, ''def'') || ''-'' || NVL( Bill_Person_Code, ''ABC'') || ''-'' || ''DATAFLEXSYNCDATA'') AS Bill_Person_KEY,
       Dataflex_Source_System_ID,
       Dataflex_System_Code,
       GP_System_Code,
       GP_Employee_Key,
       GP_Employee_ID,
       GP_Active_Employee_Flag,
       Bill_Person_Code,
       Person_Name,
       First_Name,
       Last_Name,
	   :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	   :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
       CURRENT_USER as ETL_INSERTED_BY ,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
       CURRENT_USER as ETL_LAST_UPDATED_BY,
       0 as ETL_DELETED_FLAG,
       0 AS ETL_INFERRED_MEMBER_FLAG
FROM Find_Contract_Employee_Key
UNION
SELECT md5( Dataflex_System_Code || ''-'' || NVL( GP_Employee_ID, ''def'') || ''-'' || NVL( Bill_Person_Code, ''ABC'') || ''-'' || ''DATAFLEXSYNCDATA'') AS Bill_Person_KEY,
       Dataflex_Source_System_ID,
       Dataflex_System_Code,
       GP_System_Code,
       GP_Employee_Key,
       GP_Employee_ID,
       GP_Active_Employee_Flag,
       Bill_Person_Code,
       Person_Name,
       First_Name,
       Last_Name,
	   :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	   :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
       CURRENT_USER as ETL_INSERTED_BY ,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
       CURRENT_USER as ETL_LAST_UPDATED_BY,
       0 as ETL_DELETED_FLAG,
       0 AS ETL_INFERRED_MEMBER_FLAG
FROM Find_Invoice_Employee_Key
ORDER BY 1, Last_Name, Dataflex_System_Code;
;
    SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    ';