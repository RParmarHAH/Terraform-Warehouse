resource "snowflake_view" "DISC_DATA_CLEANSING_VW_BRANCH_ADDRESS_STANDARDIZATION_INPUT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	name = "VW_BRANCH_ADDRESS_STANDARDIZATION_INPUT"
	statement = <<-SQL
	 SELECT SOURCE_SYSTEM_ID, SYSTEM_CODE, Office_Number, Office_Code, 
       Office_Name,
       SRC_Branch_ADDRESS AS Address, SRC_CITY AS City, SRC_STATE_CODE AS State, TRIM( LEFT( SRC_ZIP, 5)) AS Zip
FROM DISC_Prod.Data_Cleansing.Branch_Src_Attributes
WHERE ((Address IS NOT NULL AND Address <> '' AND City IS NOT NULL AND State IS NOT NULL) OR (Address IS NOT NULL AND Address <> '' AND Zip IS NOT NULL))
AND SRC_Branch_Address_Processed_Flag = 'FALSE'
ORDER BY System_Code, Office_Name;
SQL
	or_replace = true 
	is_secure = false 
}

