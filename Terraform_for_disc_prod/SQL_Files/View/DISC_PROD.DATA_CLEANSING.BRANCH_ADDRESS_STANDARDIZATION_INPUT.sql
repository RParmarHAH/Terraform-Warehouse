create or replace view DISC_PROD.DATA_CLEANSING.BRANCH_ADDRESS_STANDARDIZATION_INPUT(
	SOURCE_SYSTEM_ID,
	SYSTEM_CODE,
	OFFICE_NUMBER,
	OFFICE_CODE,
	OFFICE_NAME,
	ADDRESS,
	CITY,
	STATE,
	ZIP
) as
SELECT SOURCE_SYSTEM_ID, SYSTEM_CODE, Office_Number, Office_Code, 
       Office_Name,
       SRC_Branch_ADDRESS AS Address, SRC_CITY AS City, SRC_STATE_CODE AS State, TRIM( LEFT( SRC_ZIP, 5)) AS Zip
FROM DISC_Prod.Data_Cleansing.Branch_Src_Attributes
WHERE ((Address IS NOT NULL AND Address <> '' AND City IS NOT NULL AND State IS NOT NULL) OR (Address IS NOT NULL AND Address <> '' AND Zip IS NOT NULL))
AND SRC_Branch_Address_Processed_Flag = 'FALSE'
ORDER BY System_Code, Office_Name;