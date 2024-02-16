CREATE OR REPLACE PROCEDURE DISC_PROD.DATA_CLEANSING.UPD_STAGE_ZIP_DAT_CLEANSING_EMPLOYEE_ADDRESS()
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
    --*****************************************************************************************************************************
-- NAME: ADPALLIANCE_SRC_Employee
--
-- PURPOSE: Creates script for data cleanse for ADPALLIANCE source
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/07/23     Darshan Gosai           Initial development
--*****************************************************************************************************************************
--

/* To Update .0 zip with correct value  */

UPDATE DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES
FROM 
(
SELECT  
source_system_id,
system_code,
EMPLOYEE_NUMBER,
SPLIT_PART(zip,''.'',1)  AS  zip
FROM 
DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES
WHERE LENGTH(zip) = 7 
AND zip LIKE ''%.0'' GROUP BY 1,2,3,4
)x 
SET 
zip  = x.zip
WHERE 
DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES.source_system_id = X.source_system_id
AND DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES.system_code = X.system_code
AND DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES.EMPLOYEE_NUMBER = X.EMPLOYEE_NUMBER;

/* To Update Four diigt length zip with proper value  */

UPDATE DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES
FROM 
(
SELECT  
source_system_id,
system_code,
EMPLOYEE_NUMBER,
''0''||zip AS  zip
FROM 
DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES
WHERE LENGTH(zip) = 4 
GROUP BY 1,2,3,4
)x 
SET 
zip  = x.zip
WHERE 
DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES.source_system_id = X.source_system_id
AND DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES.system_code = X.system_code
AND DISC_PROD.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES.EMPLOYEE_NUMBER = X.EMPLOYEE_NUMBER;
				
 
 RETURN ''SUCCESS'';
    END;
';