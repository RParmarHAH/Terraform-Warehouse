CREATE OR REPLACE PROCEDURE DISC_PROD.DATA_CLEANSING.GET_MATRIXCARE_SRC_CLIENT("STR_ETL_TASK_KEY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME:  MATRIXCARE_SRC_CLIENT
--
-- PURPOSE: Creates script for data cleanse for MATRIXCARE source
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 07/25/23     Darshan Gosai           Initial development
--*****************************************************************************************************************************
--

MERGE INTO DISC_PROD.DATA_CLEANSING."CLIENT_SRC_ATTRIBUTES"  AS tgt
USING
(
WITH source_client_addresses
AS
(
WITH CLIENT_PHONENUMBER_LIST AS 
(
SELECT *
	FROM (
		SELECT T.CLPH_ID, T.CLPH_CLIENTID, T.CLPH_PHONETYPE, TRIM(T.CLPH_PHONE) AS CLPH_PHONE,
			ROW_NUMBER() OVER (PARTITION BY T.CLPH_CLIENTID, T.CLPH_PHONETYPE ORDER BY T.CLPH_SEQUENCE DESC) AS RN,
			MAX(T.ETL_LAST_UPDATED_DATE) OVER (PARTITION BY T.CLPH_CLIENTID) AS ETL_LAST_UPDATED_DATE
		FROM DISC_PROD.MATRIXCARE.STVHC_T_CLIENTPHONES T
	) AS L
	WHERE L.RN = 1
), 
CLIENT_PHONENUMBER AS
(
	SELECT L.CLPH_CLIENTID, L.ETL_LAST_UPDATED_DATE,
		FAX.CLPH_PHONE AS CLIENT_FAX_NUMBER,
		HOME.CLPH_PHONE AS CLIENT_HOME_PHONE,
		WORK.CLPH_PHONE AS CLIENT_WORK_PHONE,
		CELL.CLPH_PHONE AS CLIENT_CELL_PHONE
	FROM (
		SELECT DISTINCT CLPH_CLIENTID, ETL_LAST_UPDATED_DATE
		FROM CLIENT_PHONENUMBER_LIST
	) AS L
	LEFT JOIN CLIENT_PHONENUMBER_LIST AS FAX
		ON FAX.CLPH_CLIENTID = L.CLPH_CLIENTID AND FAX.CLPH_PHONETYPE = 1
	LEFT JOIN CLIENT_PHONENUMBER_LIST AS HOME
		ON HOME.CLPH_CLIENTID = L.CLPH_CLIENTID AND HOME.CLPH_PHONETYPE = 2
	LEFT JOIN CLIENT_PHONENUMBER_LIST AS WORK
		ON WORK.CLPH_CLIENTID = L.CLPH_CLIENTID AND WORK.CLPH_PHONETYPE = 3
	LEFT JOIN CLIENT_PHONENUMBER_LIST AS CELL
		ON CELL.CLPH_CLIENTID = L.CLPH_CLIENTID AND CELL.CLPH_PHONETYPE = 4
)
SELECT
7 AS SOURCE_SYSTEM_ID,
''MATRIXCARE'' AS SYSTEM_CODE,
TRIM( CAST( cl.cli_id AS VARCHAR)) AS Client_ID, 
UPPER( TRIM( cl.cli_FirstName)) AS Client_First_Name, 
UPPER( TRIM( cl.cli_LastName)) AS Client_Last_Name,
UPPER( TRIM( IFNULL( TRIM( Cl.cli_ADDRESS1) , '''') ||'' ''|| IFNULL( TRIM( cl.cli_ADDRESS2), ''''))) AS SRC_Client_ADDRESS,
UPPER(TRIM(cl.cli_CITY)) AS SRC_Client_CITY,
UPPER(TRIM(COALESCE(ST1.STATE_ISO_CODE, ST2.STATE_ISO_CODE, Z.STATE_ISO_CODE))) AS SRC_Client_STATE_CODE,
TRIM(cl.Cli_POSTALCODE) AS Src_Client_ZIP,
CAST( NULL AS VARCHAR) AS Src_Client_Zip4,
UPPER( TRIM( cl.cli_SSN)) AS Src_Client_SSN,
CAST(cl.cli_BirthDate AS DATE) AS Src_Client_DOB,
CPH.CLIENT_HOME_PHONE AS Src_Client_Home_Phone,
CPH.CLIENT_CELL_PHONE AS Src_Client_Cell_Phone,
CPH.CLIENT_WORK_PHONE AS Src_Client_Work_Phone,
UPPER( TRIM( cl.cli_Email)) AS Src_Client_Personal_Email,
UPPER( TRIM( cl.cli_Email2)) AS Src_Client_Work_Email,
MIN( IFNULL( CAST( sch.sch_SchedStartTime AS DATE), CAST( ''2040-12-31'' AS DATE))) AS SRC_Client_Min_Activity_Date, 
MAX( IFNULL( CAST( sch.sch_SchedEndTime AS DATE), CAST( ''1900-01-01'' AS DATE))) AS SRC_Client_Max_Activity_Date,
CAST( FALSE AS BOOLEAN) AS SRC_Client_Address_Processed_Flag,
CAST( FALSE AS BOOLEAN) AS SRC_Client_Address_Successfully_Cleansed_Flag
FROM DISC_PROD.MATRIXCARE.STVHC_T_Client cl
LEFT JOIN DISC_PROD.MATRIXCARE.STVHC_T_SCHEDULES AS SCH ON sch.sch_clientID = cl.cli_ID
LEFT JOIN DW_PROD.HAH.DIM_STATE ST1 ON ST1.STATE_ISO_CODE = cl.cli_STATEORPROVINCE 
LEFT JOIN DW_PROD.HAH.DIM_STATE ST2 ON ST1.STATE_ISO_CODE IS NULL AND UPPER(ST2.STATE_NAME) = UPPER(Cl.Cli_STATEORPROVINCE)
LEFT JOIN DW_PROD.HAH.DIM_ZIP_CODE Z ON ST1.STATE_ISO_CODE IS NULL AND ST2.STATE_ISO_CODE IS NULL AND Z.ZIP_CODE = LEFT(TRIM(cl.cli_POSTALCODE), 5)
LEFT JOIN CLIENT_PHONENUMBER CPH ON cl.cli_id = CPH.CLPH_CLIENTID
GROUP BY 1, 2, 3, 4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,21
)
SELECT 
Source_System_ID, 
System_Code, 
Client_ID, 
Client_First_Name, 
Client_Last_Name, 
TRIM( dca.Src_Client_Address) Src_Client_Address, 
TRIM( dca.Src_Client_City) Src_Client_City, 
TRIM( dca.Src_Client_State_Code) Src_Client_State_Code, 
TRIM( dca.Src_Client_Zip) Src_Client_Zip, 
TRIM( dca.Src_Client_Zip4) Src_Client_Zip4,
TRIM( dca.Src_Client_SSN) Src_Client_SSN, 
dca.Src_Client_DOB, 
TRIM( dca.Src_Client_Home_Phone) Src_Client_Home_Phone, 
TRIM( dca.Src_Client_Cell_Phone) Src_Client_Cell_Phone, 
TRIM( dca.Src_Client_Work_Phone) Src_Client_Work_Phone, 
TRIM( dca.Src_Client_Personal_Email) Src_Client_Personal_Email, 
TRIM( dca.Src_Client_Work_Email) Src_Client_Work_Email,
SRC_Client_Min_Activity_Date, 
SRC_Client_Max_Activity_Date,
SRC_Client_Address_Processed_Flag, 
Src_Client_Address_Successfully_Cleansed_Flag,
CAST( FALSE AS BOOLEAN) AS Src_Client_DOB_Successfully_Cleansed_Flag, 
CAST( FALSE AS BOOLEAN) AS Src_Client_SSN_Successfully_Cleansed_Flag, 
CAST( FALSE AS BOOLEAN) AS Src_Client_Home_Phone_Successfully_Cleansed_Flag, 
CAST( FALSE AS BOOLEAN) AS Src_Client_Cell_Phone_Successfully_Cleansed_Flag, 
CAST( FALSE AS BOOLEAN) AS Src_Client_Work_Phone_Successfully_Cleansed_Flag, 
CAST( FALSE AS BOOLEAN) AS Src_Client_Personal_Email_Successfully_Cleansed_Flag, 
CAST( FALSE AS BOOLEAN) AS Src_Client_Work_Email_Successfully_Cleansed_Flag,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
CURRENT_USER as ETL_INSERTED_BY ,
convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
CURRENT_USER as ETL_LAST_UPDATED_BY
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
WHEN MATCHED AND (IFNULL( src.Src_Client_Address, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_Address, ''~!@#$%^&*()+'')
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