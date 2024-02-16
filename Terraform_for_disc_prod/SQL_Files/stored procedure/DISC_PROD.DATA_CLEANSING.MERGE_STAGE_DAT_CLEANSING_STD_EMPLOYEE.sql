CREATE OR REPLACE PROCEDURE DISC_PROD.DATA_CLEANSING.MERGE_STAGE_DAT_CLEANSING_STD_EMPLOYEE()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS CALLER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME:  Employee_Std_Attributes
--
-- PURPOSE: Creates script for data cleanse for Employee_Std_Attributes
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/09/23     Darshan Gosai           Initial development
--*****************************************************************************************************************************
--

MERGE INTO DISC_PROD.DATA_CLEANSING.EMPLOYEE_STD_ATTRIBUTES  AS tgt
USING
(
SELECT DISTINCT addr.SOURCE_SYSTEM_ID, addr.SYSTEM_CODE, addr.Employee_ID, addr.Employee_FIRST_NAME, COALESCE (addr.Employee_LAST_NAME,'''') as Employee_LAST_NAME, 
       addr.SRC_Employee_ADDRESS, 
       TRIM( IFNULL( std.ADDRESS_NUMBER,'''')||'' ''||IFNULL( std.STREET, '''')) AS Std_Employee_Address,
       addr.SRC_Employee_CITY, 
       std.MUNICIPALITY AS Std_Employee_City, 
       std.SUB_REGION AS Std_Employee_County,
       addr.SRC_Employee_STATE_CODE, 
       st.State_ISO_Code AS Std_Employee_State_Code,
       std.REGION AS Std_Employee_State_Name, 
       addr.SRC_Employee_ZIP, 
       TRIM( LEFT( CAST( STD.ZIPCODE AS VARCHAR), 8)) AS Std_Employee_Zip,
       CAST( STD.PLUS_FOUR_CODE AS VARCHAR) AS Std_Employee_Zip_Plus_Four, 
       std.COUNTRY_CODE AS Std_Employee_Country_Code,
       std.ADDRESS_NUMBER, std.STREET, std.LABEL,
       std.POINTS, std.LATITUDE, std.LONGITUDE, std.RELEVANCE,
       
       FALSE AS SRC_Employee_ADDRESS_PROCESSED_FLAG, 
       
       FALSE AS SRC_Employee_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG,
       
       addr.SRC_Employee_SSN as SRC_Employee_SSN, 
	   DISC_PROD.DATA_CLEANSING.SSN_VALIDATION(SRC_Employee_SSN) AS Std_Employee_SSN,
       CAST( IFF( Std_Employee_SSN IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Employee_SSN_Successfully_Cleansed_Flag2, 
       addr.SRC_Employee_DOB, 
       CASE WHEN 
	       TRY_CAST( Src_Employee_DOB AS DATE) BETWEEN CAST( ''1900-01-31'' AS DATE) 
		        AND ADD_MONTHS( CURRENT_DATE, (-18 * 12)) THEN TRY_CAST( Src_Employee_DOB AS DATE)
            ELSE NULL
        END AS Std_Employee_DOB,
       CAST( IFF( Std_Employee_DOB IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Employee_DOB_Successfully_Cleansed_Flag2,
       addr.SRC_Employee_HOME_PHONE, 
       DISC_PROD.DATA_CLEANSING.PHONE_NUMBER_VALIDATION(addr.SRC_Employee_HOME_PHONE) AS Std_Employee_Home_Phone,
		CAST( IFF( Std_Employee_Home_Phone IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Employee_Home_Phone_Successfully_Cleansed_Flag2,
       addr.SRC_Employee_CELL_PHONE, 
       DISC_PROD.DATA_CLEANSING.PHONE_NUMBER_VALIDATION( addr.SRC_Employee_Cell_PHONE) AS Std_Employee_Cell_Phone,
	   CAST( IFF( Std_Employee_Cell_Phone IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Employee_Cell_Phone_Successfully_Cleansed_Flag2,
       addr.SRC_Employee_WORK_PHONE, 
       DISC_PROD.DATA_CLEANSING.PHONE_NUMBER_VALIDATION( addr.SRC_Employee_Work_PHONE) AS Std_Employee_Work_Phone,
       CAST( IFF( Std_Employee_Work_Phone IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Employee_Work_Phone_Successfully_Cleansed_Flag2,
       addr.SRC_Employee_PERSONAL_EMAIL, 
       DISC_PROD.DATA_CLEANSING.EMAIL_VALIDATION( addr.SRC_Employee_Personal_Email) AS Std_Employee_Personal_Email,
       CAST( IFF( Std_Employee_Personal_Email IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Employee_Personal_Email_Successfully_Cleansed_Flag2,
       addr.SRC_Employee_WORK_EMAIL,
       DISC_PROD.DATA_CLEANSING.EMAIL_VALIDATION( addr.SRC_Employee_Work_Email) AS Std_Employee_Work_Email,
       CAST( IFF( Std_Employee_Work_Email IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Employee_Work_Email_Successfully_Cleansed_Flag2,
       
       CASE WHEN (std.ADDRESS_NUMBER IS NOT NULL AND std.ADDRESS_NUMBER <> '''' 
       				AND std.STREET IS NOT NULL AND std.STREET <> ''''
       				AND std.COUNTRY_CODE IS NOT NULL AND std.COUNTRY_CODE <> ''''
       				AND std.ZIPCODE IS NOT NULL AND std.ZIPCODE <> ''''
       				AND std.PLUS_FOUR_CODE IS NOT NULL AND std.PLUS_FOUR_CODE <> ''''
       				AND std.REGION IS NOT NULL AND std.REGION <> ''''
       				AND std.SUB_REGION IS NOT NULL AND std.SUB_REGION <> ''''
       				AND std.MUNICIPALITY IS NOT NULL AND std.MUNICIPALITY <> '''') THEN ''LOD_FRM_ADD_TBL'' ELSE NULL END AS METHD_UPD,
       	 
      CASE WHEN (std.ADDRESS_NUMBER IS NOT NULL AND std.ADDRESS_NUMBER <> '''' 
       				AND std.STREET IS NOT NULL AND std.STREET <> ''''
       				AND std.COUNTRY_CODE IS NOT NULL AND std.COUNTRY_CODE <> ''''
       				AND std.ZIPCODE IS NOT NULL AND std.ZIPCODE <> ''''
       				AND std.PLUS_FOUR_CODE IS NOT NULL AND std.PLUS_FOUR_CODE <> ''''
       				AND std.REGION IS NOT NULL AND std.REGION <> ''''
       				AND std.SUB_REGION IS NOT NULL AND std.SUB_REGION <> ''''
       				AND std.MUNICIPALITY IS NOT NULL AND std.MUNICIPALITY <> '''') THEN ''UPD_FRM_ADD_TBL'' ELSE NULL END AS METHD_UPD1,
       
       ''1'' AS ETL_TASK_KEY,
       ''1'' AS ETL_INSERTED_TASK_KEY,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
       CURRENT_USER as ETL_INSERTED_BY ,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
       CURRENT_USER as ETL_LAST_UPDATED_BY
FROM DISC_PROD.DATA_CLEANSING.Employee_Src_Attributes AS addr
LEFT OUTER JOIN
( SELECT  *  FROM DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES 
WHERE 
(source_system_id,system_code,employee_number) NOT IN (
SELECT  source_system_id,system_code,employee_number
FROM 
DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES
WHERE 
(ADDRESS ,CITY,STATE,ZIP )
 IN (SELECT  ADDRESS ,CITY,STATE,ZIP   FROM DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES_INCNSTNT )
 OR  COUNTRY_CODE <> ''USA''
 OR zip <> ZIPCODE
 OR LENGTH (zip) <> 5
 GROUP BY 1,2,3 )  )AS std 
ON std."EMPLOYEE_NUMBER" = addr."EMPLOYEE_ID"
AND std."SOURCE_SYSTEM_ID"  = addr.source_system_id
AND std."SYSTEM_CODE"  = addr.system_code
LEFT OUTER JOIN DW_PROD.HAH.DIM_State AS st ON UPPER( std.Region) = UPPER( st.State_Name)
WHERE ADDR.source_system_id IN (1,2,3,4,5,6,7,8,9,10,13,14,16,17,34,22,12,18,20,36)
AND (addr.Employee_FIRST_NAME IS NOT NULL OR addr.Employee_FIRST_NAME IS NOT  NULL) 
ORDER BY addr.Src_Employee_Address
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
              OR  IFNULL( src.Src_Employee_Work_Email, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_Work_Email, ''~!@#$%^&*()+'')
			  OR  IFNULL( src.Std_Employee_SSN, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_SSN, ''~!@#$%^&*()+'')
              OR  IFNULL( CAST( src.Std_Employee_DOB AS VARCHAR), ''~!@#$%^&*()+'') <> IFNULL( CAST( tgt.Std_Employee_DOB AS VARCHAR), ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Employee_Home_Phone, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_Home_Phone, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Employee_Cell_Phone, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_Cell_Phone, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Employee_Work_Phone, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_Work_Phone, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Employee_Personal_Email, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_Personal_Email, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Employee_Work_Email, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_Work_Email, ''~!@#$%^&*()+'')
			  )
THEN UPDATE SET
				  tgt.Employee_First_Name = src.Employee_First_Name,
                  tgt.Employee_Last_Name = src.Employee_Last_Name,
				  tgt.Src_Employee_SSN = src.Src_Employee_SSN,
                  tgt.Src_Employee_DOB = src.Src_Employee_DOB,
                  tgt.Src_Employee_Home_Phone = src.Src_Employee_Home_Phone,
                  tgt.Src_Employee_Cell_Phone = src.Src_Employee_Cell_Phone,
                  tgt.Src_Employee_Work_Phone = src.Src_Employee_Work_Phone,
                  tgt.Src_Employee_Personal_Email = src.Src_Employee_Personal_Email,
                  tgt.Src_Employee_Work_Email = src.Src_Employee_Work_Email,
				  tgt.Std_Employee_SSN = src.Std_Employee_SSN,
                  tgt.Std_Employee_DOB = src.Std_Employee_DOB,
                  tgt.Std_Employee_Home_Phone = src.Std_Employee_Home_Phone,
                  tgt.Std_Employee_Cell_Phone = src.Std_Employee_Cell_Phone,
                  tgt.Std_Employee_Work_Phone = src.Std_Employee_Work_Phone,
                  tgt.Std_Employee_Personal_Email = src.Std_Employee_Personal_Email,
                  tgt.Std_Employee_Work_Email = src.Std_Employee_Work_Email,
				  tgt.Src_Employee_DOB_Successfully_Cleansed_Flag = src.Src_Employee_DOB_Successfully_Cleansed_Flag2,
                  tgt.Src_Employee_SSN_Successfully_Cleansed_Flag = src.Src_Employee_SSN_Successfully_Cleansed_Flag2,
                  tgt.Src_Employee_Home_Phone_Successfully_Cleansed_Flag = src.Src_Employee_Home_Phone_Successfully_Cleansed_Flag2,
                  tgt.Src_Employee_Cell_Phone_Successfully_Cleansed_Flag = src.Src_Employee_Cell_Phone_Successfully_Cleansed_Flag2,
                  tgt.Src_Employee_Work_Phone_Successfully_Cleansed_Flag = src.Src_Employee_Work_Phone_Successfully_Cleansed_Flag2,
                  tgt.Src_Employee_Personal_Email_Successfully_Cleansed_Flag = src.Src_Employee_Personal_Email_Successfully_Cleansed_Flag2,
                  tgt.Src_Employee_Work_Email_Successfully_Cleansed_Flag = src.Src_Employee_Work_Email_Successfully_Cleansed_Flag2,
				  tgt.ETL_Task_Key = src.ETL_Task_Key,
                  tgt.ETL_Last_Updated_Date = src.ETL_Last_Updated_Date,
                  tgt.ETL_Last_Updated_By = src.ETL_Last_Updated_By             
WHEN MATCHED AND (
				  IFNULL( src.Src_Employee_Address, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_Address, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Employee_City, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_City, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Employee_State_Code, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_State_Code, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Employee_Zip, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Employee_Zip, ''~!@#$%^&*()+'')
			  OR  IFNULL( src.Std_Employee_Address, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_Address, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Employee_City, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_City, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Employee_County, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_County, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Employee_State_Code, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_State_Code, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Employee_State_Name, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_State_Name, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Employee_Zip, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_Zip, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Employee_Zip_Plus_Four, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_Zip_Plus_Four, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Employee_Country_Code, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Employee_Country_Code, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Address_Number, ''~!@#$%^&*()+'') <> IFNULL( tgt.Address_Number, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Street, ''~!@#$%^&*()+'') <> IFNULL( tgt.Street, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Label, ''~!@#$%^&*()+'') <> IFNULL( tgt.Label, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Points, ''~!@#$%^&*()+'') <> IFNULL( tgt.Points, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Latitude, 9876543210) <> IFNULL( tgt.Latitude, 9876543210)
              OR  IFNULL( src.Longitude, 9876543210) <> IFNULL( tgt.Longitude, 9876543210)			   
              )
		AND (tgt.METHD_UPD is null or tgt.METHD_UPD = '''')
 THEN UPDATE SET  
                  tgt.Src_Employee_Address = src.Src_Employee_Address,
                  tgt.Src_Employee_City = src.Src_Employee_City,
                  tgt.Src_Employee_State_Code = src.Src_Employee_State_Code,
                  tgt.Src_Employee_Zip = src.Src_Employee_Zip,                  
                  tgt.Std_Employee_Address = src.Std_Employee_Address,
                  tgt.Std_Employee_City = src.Std_Employee_City,
                  tgt.Std_Employee_County = src.Std_Employee_County,
                  tgt.Std_Employee_State_Code = src.Std_Employee_State_Code,
                  tgt.Std_Employee_State_Name = src.Std_Employee_State_Name,
                  tgt.Std_Employee_Zip = src.Std_Employee_Zip,
                  tgt.Std_Employee_Zip_Plus_Four = src.Std_Employee_Zip_Plus_Four,
                  tgt.Std_Employee_Country_Code = src.Std_Employee_Country_Code,
                  tgt.Address_Number = src.Address_Number,
                  tgt.Street = src.Street,
                  tgt.Label = src.Label,
                  tgt.Points = src.Points,
                  tgt.Latitude = src.Latitude,
                  tgt.Longitude = src.Longitude,                  
                  tgt.Src_Employee_Address_Processed_Flag = src.Src_Employee_Address_Processed_Flag,
                  tgt.Src_Employee_Address_Successfully_Cleansed_Flag = src.Src_Employee_Address_Successfully_Cleansed_Flag,                  
                  tgt.METHD_UPD =  tgt.METHD_UPD||''|''||src.METHD_UPD1,
                  tgt.ETL_Task_Key = src.ETL_Task_Key,
                  tgt.ETL_Last_Updated_Date = src.ETL_Last_Updated_Date,
                  tgt.ETL_Last_Updated_By = src.ETL_Last_Updated_By
WHEN NOT MATCHED THEN INSERT
(Source_System_ID, System_Code, Employee_ID, Employee_First_Name, Employee_Last_Name, 
SRC_Employee_ADDRESS, SRC_Employee_CITY, SRC_Employee_STATE_CODE, SRC_Employee_ZIP, 
Src_Employee_SSN, Src_Employee_DOB, 
Src_Employee_Home_Phone, Src_Employee_Cell_Phone, Src_Employee_Work_Phone, 
Src_Employee_Personal_Email, Src_Employee_Work_Email,
STD_Employee_ADDRESS, STD_Employee_CITY, STD_Employee_COUNTY, STD_Employee_STATE_Code, STD_Employee_STATE_NAME, STD_Employee_ZIP, STD_Employee_ZIP_PLUS_FOUR, STD_Employee_COUNTRY_CODE, 
ADDRESS_NUMBER, STREET, LABEL, POINTS, LATITUDE, LONGITUDE, RELEVANCE, 
SRC_Employee_ADDRESS_PROCESSED_FLAG, SRC_Employee_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Employee_SSN, SRC_Employee_SSN_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Employee_DOB, SRC_Employee_DOB_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Employee_HOME_PHONE, SRC_Employee_HOME_PHONE_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Employee_CELL_PHONE, SRC_Employee_CELL_PHONE_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Employee_WORK_PHONE, SRC_Employee_WORK_PHONE_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Employee_PERSONAL_EMAIL, SRC_Employee_PERSONAL_EMAIL_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Employee_WORK_EMAIL, SRC_Employee_WORK_EMAIL_SUCCESSFULLY_CLEANSED_FLAG,METHD_UPD,
ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY)
VALUES
(src.Source_System_ID, src.System_Code, src.Employee_ID, src.Employee_First_Name, src.Employee_Last_Name, 
src.SRC_Employee_ADDRESS, src.SRC_Employee_CITY, src.SRC_Employee_STATE_CODE, src.SRC_Employee_ZIP, 
src.Src_Employee_SSN, src.Src_Employee_DOB, 
src.Src_Employee_Home_Phone, src.Src_Employee_Cell_Phone, src.Src_Employee_Work_Phone, 
src.Src_Employee_Personal_Email, src.Src_Employee_Work_Email,
STD_Employee_ADDRESS, STD_Employee_CITY, STD_Employee_COUNTY, STD_Employee_STATE_Code, STD_Employee_STATE_NAME, STD_Employee_ZIP, STD_Employee_ZIP_PLUS_FOUR, STD_Employee_COUNTRY_CODE, 
ADDRESS_NUMBER, STREET, LABEL, POINTS, LATITUDE, LONGITUDE, RELEVANCE, 
src.SRC_Employee_ADDRESS_PROCESSED_FLAG, src.SRC_Employee_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG, 
src.STD_Employee_SSN, src.SRC_Employee_SSN_SUCCESSFULLY_CLEANSED_FLAG2, 
src.STD_Employee_DOB, src.SRC_Employee_DOB_SUCCESSFULLY_CLEANSED_FLAG2, 
src.STD_Employee_HOME_PHONE, src.SRC_Employee_HOME_PHONE_SUCCESSFULLY_CLEANSED_FLAG2, 
src.STD_Employee_CELL_PHONE, src.SRC_Employee_CELL_PHONE_SUCCESSFULLY_CLEANSED_FLAG2, 
src.STD_Employee_WORK_PHONE, src.SRC_Employee_WORK_PHONE_SUCCESSFULLY_CLEANSED_FLAG2, 
src.STD_Employee_PERSONAL_EMAIL, src.SRC_Employee_PERSONAL_EMAIL_SUCCESSFULLY_CLEANSED_FLAG2, 
src.STD_Employee_WORK_EMAIL, src.SRC_Employee_WORK_EMAIL_SUCCESSFULLY_CLEANSED_FLAG2,src.METHD_UPD,
src.ETL_TASK_KEY, src.ETL_INSERTED_TASK_KEY, src.ETL_INSERTED_DATE, src.ETL_INSERTED_BY, src.ETL_LAST_UPDATED_DATE, src.ETL_LAST_UPDATED_BY);

 SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;
    ';