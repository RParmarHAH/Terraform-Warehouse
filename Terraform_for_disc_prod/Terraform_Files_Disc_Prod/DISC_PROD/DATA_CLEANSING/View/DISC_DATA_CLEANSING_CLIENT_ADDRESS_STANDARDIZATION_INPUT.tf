resource "snowflake_view" "DISC_DATA_CLEANSING_CLIENT_ADDRESS_STANDARDIZATION_INPUT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	name = "CLIENT_ADDRESS_STANDARDIZATION_INPUT"
	statement = <<-SQL
	 SELECT SOURCE_SYSTEM_ID, SYSTEM_CODE, CLIENT_ID, 
       CLIENT_FIRST_NAME, CLIENT_LAST_NAME, 
       SRC_CLIENT_ADDRESS AS Address, SRC_CLIENT_CITY AS City, SRC_CLIENT_STATE_CODE AS State, TRIM( LEFT( SRC_CLIENT_ZIP, 5)) AS Zip
FROM  Data_Cleansing.Client_Src_Attributes
WHERE 
SRC_CLIENT_MAX_ACTIVITY_DATE >= CAST( '2021-01-01' AS DATE)
 --AND SOURCE_SYSTEM_ID=17
--AND SYSTEM_CODE='PREFERRED'
AND SRC_Client_Address_Processed_Flag = 'FALSE'
AND Src_CLIENT_Address IS NOT NULL 
AND REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(replace(SRC_CLIENT_ADDRESS  ,'(',''),')',''),' ',''),'-',''),'+',''),'.','') <> '' 
AND REGEXP_LIKE(Src_CLIENT_Address ,'[0-9]+') = FALSE
AND 
((
Src_CLIENT_City IS NOT NULL 
AND 
REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(replace(Src_CLIENT_City  ,'(',''),')',''),' ',''),'-',''),'+',''),'.','') <> '' 
AND Src_CLIENT_State_Code IS NOT NULL 
AND REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(replace(Src_CLIENT_State_Code  ,'(',''),')',''),' ',''),'-',''),'+',''),'.','') <> '' 
) 
OR (Src_CLIENT_Zip IS NOT NULL 
AND REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(replace(Src_CLIENT_Zip  ,'(',''),')',''),' ',''),'-',''),'+',''),'.','') <> '' 
AND TRIM(Src_CLIENT_Zip) <> 'None')
)
AND REGEXP_LIKE(Src_CLIENT_Zip ,'[0-9]+') = TRUE
AND CLIENT_ID IS NOT NULL AND CLIENT_ID <> ''
AND CLIENT_FIRST_NAME IS NOT NULL 
AND REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(replace(CLIENT_FIRST_NAME ,'(',''),')',''),' ',''),'-',''),'+',''),'.','') <> ''
AND NOT(CLIENT_FIRST_NAME LIKE '%|%' OR CLIENT_LAST_NAME LIKE '%|%' OR SRC_CLIENT_ADDRESS LIKE '%|%')
AND CLIENT_LAST_NAME IS NOT NULL AND CLIENT_LAST_NAME <> ''
AND client_id NOT IN ('424091','316586')
AND SRC_CLIENT_HOME_PHONE = ''
ORDER BY System_Code, Client_Last_Name;
SQL
	or_replace = true 
	is_secure = false 
}

