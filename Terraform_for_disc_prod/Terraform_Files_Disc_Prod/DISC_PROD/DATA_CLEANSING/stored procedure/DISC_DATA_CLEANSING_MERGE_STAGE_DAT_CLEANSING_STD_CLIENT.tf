resource "snowflake_procedure" "DISC_DATA_CLEANSING_MERGE_STAGE_DAT_CLEANSING_STD_CLIENT" {
	name ="MERGE_STAGE_DAT_CLEANSING_STD_CLIENT"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "CALLER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME:  Client_Std_Attributes
--
-- PURPOSE: Creates script for data cleanse for Client_Std_Attributes
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 10/04/23     Darshan Gosai           Initial development
--*****************************************************************************************************************************
--

MERGE INTO DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.CLIENT_STD_ATTRIBUTES AS tgt
USING
(
SELECT DISTINCT addr.SOURCE_SYSTEM_ID, addr.SYSTEM_CODE, addr.CLIENT_ID, addr.CLIENT_FIRST_NAME, addr.CLIENT_LAST_NAME, 
       addr.SRC_CLIENT_ADDRESS, 
       TRIM( IFNULL( std.ADDRESS_NUMBER,'''')||'' ''||IFNULL( std.STREET, '''')) AS STD_CLIENT_ADDRESS,
       addr.SRC_CLIENT_CITY, 
       std.MUNICIPALITY AS STD_CLIENT_CITY, 
       std.SUB_REGION AS STD_CLIENT_COUNTY,
       addr.SRC_CLIENT_STATE_CODE, 
       st.State_ISO_Code AS Std_Client_State_Code,
       std.REGION AS Std_Client_State_Name, 
       addr.SRC_CLIENT_ZIP, 
       TRIM( LEFT( CAST( STD.ZIPCODE AS VARCHAR), 8)) AS Std_Client_Zip,
       CAST( STD.PLUS_FOUR_CODE AS VARCHAR) AS Std_Client_Zip_Plus_Four, 
       std.COUNTRY_CODE AS Std_Client_Country_Code,
       std.ADDRESS_NUMBER, std.STREET, std.LABEL,
       std.POINTS, std.LATITUDE, std.LONGITUDE, std.RELEVANCE,
       
	   FALSE  AS SRC_Client_ADDRESS_PROCESSED_FLAG, 

	   FALSE AS  SRC_Client_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG,
       
	   addr.SRC_Client_SSN AS SRC_CLIENT_SSN, 
       DISC_${var.SF_ENVIRONMENT}.Data_Cleansing.SSN_Validation( SRC_Client_SSN) AS Std_Client_SSN,
       CAST( IFF( Std_Client_SSN IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Client_SSN_Successfully_Cleansed_Flag2, 
       addr.SRC_Client_DOB, 
       CASE WHEN 
          TRY_CAST( Src_Client_DOB AS DATE) BETWEEN CAST( ''1900-01-31'' AS DATE)
                       AND ADD_MONTHS( CURRENT_DATE, (-18 * 12)) THEN TRY_CAST( Src_Client_DOB AS DATE)
            ELSE NULL
        END AS Std_Client_DOB,
       CAST( IFF( Std_Client_DOB IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Client_DOB_Successfully_Cleansed_Flag2,
       addr.SRC_Client_HOME_PHONE, 
       DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.PHONE_NUMBER_VALIDATION( addr.SRC_Client_HOME_PHONE) AS Std_Client_Home_Phone,
       CAST( IFF( Std_Client_Home_Phone IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Client_Home_Phone_Successfully_Cleansed_Flag2,
       addr.SRC_Client_CELL_PHONE, 
       DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.PHONE_NUMBER_VALIDATION( addr.SRC_Client_Cell_PHONE) AS Std_Client_Cell_Phone,
       CAST( IFF( Std_Client_Cell_Phone IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Client_Cell_Phone_Successfully_Cleansed_Flag2,
       addr.SRC_Client_WORK_PHONE, 
       DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.PHONE_NUMBER_VALIDATION( addr.SRC_Client_Work_PHONE) AS Std_Client_Work_Phone,
       CAST( IFF( Std_Client_Work_Phone IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Client_Work_Phone_Successfully_Cleansed_Flag2,
       addr.SRC_Client_PERSONAL_EMAIL, 
       DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMAIL_VALIDATION( addr.SRC_Client_Personal_Email) AS Std_Client_Personal_Email,
       CAST( IFF( Std_Client_Personal_Email IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Client_Personal_Email_Successfully_Cleansed_Flag2,
       addr.SRC_Client_WORK_EMAIL,
       DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMAIL_VALIDATION( addr.SRC_Client_Work_Email) AS Std_Client_Work_Email,
       CAST( IFF( Std_Client_Work_Email IS NOT NULL, TRUE, FALSE) AS BOOLEAN) AS Src_Client_Work_Email_Successfully_Cleansed_Flag2,
	   
	   CASE WHEN (std.ADDRESS_NUMBER IS NOT NULL AND std.ADDRESS_NUMBER <> '' 
       				AND std.STREET IS NOT NULL AND std.STREET <> ''
       				AND std.COUNTRY_CODE IS NOT NULL AND std.COUNTRY_CODE <> ''
       				AND std.ZIPCODE IS NOT NULL AND std.ZIPCODE <> ''
       				AND std.PLUS_FOUR_CODE IS NOT NULL AND std.PLUS_FOUR_CODE <> ''
       				AND std.REGION IS NOT NULL AND std.REGION <> ''
       				AND std.SUB_REGION IS NOT NULL AND std.SUB_REGION <> ''
       				AND std.MUNICIPALITY IS NOT NULL AND std.MUNICIPALITY <> '') THEN ''LOD_FRM_ADD_TBL'' ELSE NULL END AS METHD_UPD,
       	 
      CASE WHEN (std.ADDRESS_NUMBER IS NOT NULL AND std.ADDRESS_NUMBER <> '' 
       				AND std.STREET IS NOT NULL AND std.STREET <> ''
       				AND std.COUNTRY_CODE IS NOT NULL AND std.COUNTRY_CODE <> ''
       				AND std.ZIPCODE IS NOT NULL AND std.ZIPCODE <> ''
       				AND std.PLUS_FOUR_CODE IS NOT NULL AND std.PLUS_FOUR_CODE <> ''
       				AND std.REGION IS NOT NULL AND std.REGION <> ''
       				AND std.SUB_REGION IS NOT NULL AND std.SUB_REGION <> ''
       				AND std.MUNICIPALITY IS NOT NULL AND std.MUNICIPALITY <> '') THEN ''UPD_FRM_ADD_TBL'' ELSE NULL END AS METHD_UPD1,
       
       ''1'' AS ETL_TASK_KEY,
       ''1'' AS ETL_INSERTED_TASK_KEY,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
       CURRENT_USER as ETL_INSERTED_BY ,
       convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
       CURRENT_USER as ETL_LAST_UPDATED_BY
FROM DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.CLIENT_SRC_ATTRIBUTES AS addr
LEFT OUTER JOIN 
( SELECT  *  FROM DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.CLIENT_STANDARDIZED_ADDRESSES 
WHERE 
(source_system_id,system_code,client_number) NOT IN (
SELECT  source_system_id,system_code,client_number
FROM 
DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.CLIENT_STANDARDIZED_ADDRESSES
WHERE 
(ADDRESS ,CITY,STATE,ZIP )
 IN (SELECT  ADDRESS ,CITY,STATE,ZIP   FROM DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.CLIENT_STANDARDIZED_ADDRESSES_INCNSTNT )
 OR  COUNTRY_CODE <> ''USA''
 OR zip <> ZIPCODE
 OR LENGTH (zip) <> 5
 GROUP BY 1,2,3 )  )AS std 
ON std."CLIENT_NUMBER" = addr."CLIENT_ID"
AND std."SOURCE_SYSTEM_ID"  = addr.source_system_id
AND std."SYSTEM_CODE"  = addr.system_code

LEFT OUTER JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_State AS st ON UPPER( std.Region) = UPPER( st.State_Name)
WHERE  (addr.Client_FIRST_NAME IS NOT NULL OR addr.Client_FIRST_NAME IS NOT  NULL) 
ORDER BY addr.Src_Client_Address
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
              OR  IFNULL( src.Src_Client_Work_Email, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_Work_Email, ''~!@#$%^&*()+'')
			  OR  IFNULL( src.Std_Client_SSN, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_SSN, ''~!@#$%^&*()+'')
              OR  IFNULL( CAST( src.Std_Client_DOB AS VARCHAR), ''~!@#$%^&*()+'') <> IFNULL( CAST( tgt.Std_Client_DOB AS VARCHAR), ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Client_Home_Phone, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_Home_Phone, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Client_Cell_Phone, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_Cell_Phone, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Client_Work_Phone, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_Work_Phone, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Client_Personal_Email, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_Personal_Email, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Client_Work_Email, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_Work_Email, ''~!@#$%^&*()+'')
			  )
THEN UPDATE SET
                  tgt.Client_First_Name = src.Client_First_Name,
                  tgt.Client_Last_Name = src.Client_Last_Name,
				  tgt.Src_Client_SSN = src.Src_Client_SSN,
                  tgt.Src_Client_DOB = src.Src_Client_DOB,
                  tgt.Src_Client_Home_Phone = src.Src_Client_Home_Phone,
                  tgt.Src_Client_Cell_Phone = src.Src_Client_Cell_Phone,
                  tgt.Src_Client_Work_Phone = src.Src_Client_Work_Phone,
                  tgt.Src_Client_Personal_Email = src.Src_Client_Personal_Email,
                  tgt.Src_Client_Work_Email = src.Src_Client_Work_Email,
				  tgt.Std_Client_SSN = src.Std_Client_SSN,
                  tgt.Std_Client_DOB = src.Std_Client_DOB,
                  tgt.Std_Client_Home_Phone = src.Std_Client_Home_Phone,
                  tgt.Std_Client_Cell_Phone = src.Std_Client_Cell_Phone,
                  tgt.Std_Client_Work_Phone = src.Std_Client_Work_Phone,
                  tgt.Std_Client_Personal_Email = src.Std_Client_Personal_Email,
                  tgt.Std_Client_Work_Email = src.Std_Client_Work_Email,
				  tgt.Src_Client_DOB_Successfully_Cleansed_Flag = src.Src_Client_DOB_Successfully_Cleansed_Flag2,
                  tgt.Src_Client_SSN_Successfully_Cleansed_Flag = src.Src_Client_SSN_Successfully_Cleansed_Flag2,
                  tgt.Src_Client_Home_Phone_Successfully_Cleansed_Flag = src.Src_Client_Home_Phone_Successfully_Cleansed_Flag2,
                  tgt.Src_Client_Cell_Phone_Successfully_Cleansed_Flag = src.Src_Client_Cell_Phone_Successfully_Cleansed_Flag2,
                  tgt.Src_Client_Work_Phone_Successfully_Cleansed_Flag = src.Src_Client_Work_Phone_Successfully_Cleansed_Flag2,
                  tgt.Src_Client_Personal_Email_Successfully_Cleansed_Flag = src.Src_Client_Personal_Email_Successfully_Cleansed_Flag2,
                  tgt.Src_Client_Work_Email_Successfully_Cleansed_Flag = src.Src_Client_Work_Email_Successfully_Cleansed_Flag2,
				  tgt.ETL_Task_Key = src.ETL_Task_Key,
                  tgt.ETL_Last_Updated_Date = src.ETL_Last_Updated_Date,
                  tgt.ETL_Last_Updated_By = src.ETL_Last_Updated_By             
WHEN MATCHED AND (
                  IFNULL( src.Src_Client_Address, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_Address, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Client_City, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_City, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Client_State_Code, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_State_Code, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Src_Client_Zip, ''~!@#$%^&*()+'') <> IFNULL( tgt.Src_Client_Zip, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Client_Address, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_Address, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Client_City, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_City, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Client_County, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_County, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Client_State_Code, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_State_Code, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Client_State_Name, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_State_Name, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Client_Zip, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_Zip, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Client_Zip_Plus_Four, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_Zip_Plus_Four, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Std_Client_Country_Code, ''~!@#$%^&*()+'') <> IFNULL( tgt.Std_Client_Country_Code, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Address_Number, ''~!@#$%^&*()+'') <> IFNULL( tgt.Address_Number, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Street, ''~!@#$%^&*()+'') <> IFNULL( tgt.Street, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Label, ''~!@#$%^&*()+'') <> IFNULL( tgt.Label, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Points, ''~!@#$%^&*()+'') <> IFNULL( tgt.Points, ''~!@#$%^&*()+'')
              OR  IFNULL( src.Latitude, 9876543210) <> IFNULL( tgt.Latitude, 9876543210)
              OR  IFNULL( src.Longitude, 9876543210) <> IFNULL( tgt.Longitude, 9876543210)			   
              )
		AND (tgt.METHD_UPD is null or tgt.METHD_UPD = '''')
 THEN UPDATE SET  
                  tgt.Src_Client_Address = src.Src_Client_Address,
                  tgt.Src_Client_City = src.Src_Client_City,
                  tgt.Src_Client_State_Code = src.Src_Client_State_Code,
                  tgt.Src_Client_Zip = src.Src_Client_Zip,                  
                  tgt.Std_Client_Address = src.Std_Client_Address,
                  tgt.Std_Client_City = src.Std_Client_City,
                  tgt.Std_Client_County = src.Std_Client_County,
                  tgt.Std_Client_State_Code = src.Std_Client_State_Code,
                  tgt.Std_Client_State_Name = src.Std_Client_State_Name,
                  tgt.Std_Client_Zip = src.Std_Client_Zip,
                  tgt.Std_Client_Zip_Plus_Four = src.Std_Client_Zip_Plus_Four,
                  tgt.Std_Client_Country_Code = src.Std_Client_Country_Code,
                  tgt.Address_Number = src.Address_Number,
                  tgt.Street = src.Street,
                  tgt.Label = src.Label,
                  tgt.Points = src.Points,
                  tgt.Latitude = src.Latitude,
                  tgt.Longitude = src.Longitude,                  
                  tgt.Src_Client_Address_Processed_Flag = src.Src_Client_Address_Processed_Flag,
                  tgt.Src_Client_Address_Successfully_Cleansed_Flag = src.Src_Client_Address_Successfully_Cleansed_Flag,                  
                  tgt.METHD_UPD =  tgt.METHD_UPD||''|''||src.METHD_UPD1,
                  tgt.ETL_Task_Key = src.ETL_Task_Key,
                  tgt.ETL_Last_Updated_Date = src.ETL_Last_Updated_Date,
                  tgt.ETL_Last_Updated_By = src.ETL_Last_Updated_By
WHEN NOT MATCHED THEN INSERT
(Source_System_ID, System_Code, Client_ID, Client_First_Name, Client_Last_Name, 
SRC_Client_ADDRESS, SRC_Client_CITY, SRC_Client_STATE_CODE, SRC_Client_ZIP, 
Src_Client_SSN, Src_Client_DOB, 
Src_Client_Home_Phone, Src_Client_Cell_Phone, Src_Client_Work_Phone, 
Src_Client_Personal_Email, Src_Client_Work_Email,
STD_Client_ADDRESS, STD_Client_CITY, STD_Client_COUNTY, STD_Client_STATE_Code, STD_Client_STATE_NAME, STD_Client_ZIP, STD_Client_ZIP_PLUS_FOUR, STD_Client_COUNTRY_CODE, 
ADDRESS_NUMBER, STREET, LABEL, POINTS, LATITUDE, LONGITUDE, RELEVANCE, 
SRC_Client_ADDRESS_PROCESSED_FLAG, SRC_Client_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Client_SSN, SRC_Client_SSN_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Client_DOB, SRC_Client_DOB_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Client_HOME_PHONE, SRC_Client_HOME_PHONE_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Client_CELL_PHONE, SRC_Client_CELL_PHONE_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Client_WORK_PHONE, SRC_Client_WORK_PHONE_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Client_PERSONAL_EMAIL, SRC_Client_PERSONAL_EMAIL_SUCCESSFULLY_CLEANSED_FLAG, 
STD_Client_WORK_EMAIL, SRC_Client_WORK_EMAIL_SUCCESSFULLY_CLEANSED_FLAG,METHD_UPD,
ETL_TASK_KEY, ETL_INSERTED_TASK_KEY, ETL_INSERTED_DATE, ETL_INSERTED_BY, ETL_LAST_UPDATED_DATE, ETL_LAST_UPDATED_BY)
VALUES
(src.Source_System_ID, src.System_Code, src.Client_ID, src.Client_First_Name, src.Client_Last_Name, 
src.SRC_Client_ADDRESS, src.SRC_Client_CITY, src.SRC_Client_STATE_CODE, src.SRC_Client_ZIP, 
src.Src_Client_SSN, src.Src_Client_DOB, 
src.Src_Client_Home_Phone, src.Src_Client_Cell_Phone, src.Src_Client_Work_Phone, 
src.Src_Client_Personal_Email, src.Src_Client_Work_Email,
STD_Client_ADDRESS, STD_Client_CITY, STD_Client_COUNTY, STD_Client_STATE_Code, STD_Client_STATE_NAME, STD_Client_ZIP, STD_Client_ZIP_PLUS_FOUR, STD_Client_COUNTRY_CODE, 
ADDRESS_NUMBER, STREET, LABEL, POINTS, LATITUDE, LONGITUDE, RELEVANCE, 
src.SRC_Client_ADDRESS_PROCESSED_FLAG, src.SRC_Client_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG, 
src.STD_Client_SSN, src.SRC_Client_SSN_SUCCESSFULLY_CLEANSED_FLAG2, 
src.STD_Client_DOB, src.SRC_Client_DOB_SUCCESSFULLY_CLEANSED_FLAG2, 
src.STD_Client_HOME_PHONE, src.SRC_Client_HOME_PHONE_SUCCESSFULLY_CLEANSED_FLAG2, 
src.STD_Client_CELL_PHONE, src.SRC_Client_CELL_PHONE_SUCCESSFULLY_CLEANSED_FLAG2, 
src.STD_Client_WORK_PHONE, src.SRC_Client_WORK_PHONE_SUCCESSFULLY_CLEANSED_FLAG2, 
src.STD_Client_PERSONAL_EMAIL, src.SRC_Client_PERSONAL_EMAIL_SUCCESSFULLY_CLEANSED_FLAG2, 
src.STD_Client_WORK_EMAIL, src.SRC_Client_WORK_EMAIL_SUCCESSFULLY_CLEANSED_FLAG2,src.METHD_UPD,
src.ETL_TASK_KEY, src.ETL_INSERTED_TASK_KEY, src.ETL_INSERTED_DATE, src.ETL_INSERTED_BY, src.ETL_LAST_UPDATED_DATE, src.ETL_LAST_UPDATED_BY);

 SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

    return return_result;
END;

 EOT
}

