resource "snowflake_procedure" "DISC_DATA_CLEANSING_UPD_STAGE_ZIP_DAT_CLEANSING_EMPLOYEE_ADDRESS" {
	name ="UPD_STAGE_ZIP_DAT_CLEANSING_EMPLOYEE_ADDRESS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

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

UPDATE DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES
FROM 
(
SELECT  
source_system_id,
system_code,
EMPLOYEE_NUMBER,
SPLIT_PART(zip,''.'',1)  AS  zip
FROM 
DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES
WHERE LENGTH(zip) = 7 
AND zip LIKE ''%.0'' GROUP BY 1,2,3,4
)x 
SET 
zip  = x.zip
WHERE 
DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES.source_system_id = X.source_system_id
AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES.system_code = X.system_code
AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES.EMPLOYEE_NUMBER = X.EMPLOYEE_NUMBER;

/* To Update Four diigt length zip with proper value  */

UPDATE DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES
FROM 
(
SELECT  
source_system_id,
system_code,
EMPLOYEE_NUMBER,
''0''||zip AS  zip
FROM 
DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES
WHERE LENGTH(zip) = 4 
GROUP BY 1,2,3,4
)x 
SET 
zip  = x.zip
WHERE 
DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES.source_system_id = X.source_system_id
AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES.system_code = X.system_code
AND DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_STANDARDIZED_ADDRESSES.EMPLOYEE_NUMBER = X.EMPLOYEE_NUMBER;
				
 
 RETURN ''SUCCESS'';
    END;

 EOT
}

