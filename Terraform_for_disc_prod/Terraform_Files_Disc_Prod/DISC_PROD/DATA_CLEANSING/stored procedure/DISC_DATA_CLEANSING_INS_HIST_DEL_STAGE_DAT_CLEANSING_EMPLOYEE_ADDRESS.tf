resource "snowflake_procedure" "DISC_DATA_CLEANSING_INS_HIST_DEL_STAGE_DAT_CLEANSING_EMPLOYEE_ADDRESS" {
	name ="INS_HIST_DEL_STAGE_DAT_CLEANSING_EMPLOYEE_ADDRESS"
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
-- NAME: Address Historical data loading and staging data deletion 
--
-- PURPOSE: Creates script for data cleanse for ADPALLIANCE source
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 08/07/23     Darshan Gosai           Initial development
--*****************************************************************************************************************************
--

/* Address storing in historical table */

INSERT INTO DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_HISTRY_STANDARDIZED_ADDRESSES
SELECT * FROM DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_STG_STANDARDIZED_ADDRESSES  ;

/* Data removing from staging table */

DELETE FROM DISC_${var.SF_ENVIRONMENT}.DATA_CLEANSING.EMPLOYEE_STG_STANDARDIZED_ADDRESSES ;
				

RETURN ''SUCCESS'';
    END;

 EOT
}

