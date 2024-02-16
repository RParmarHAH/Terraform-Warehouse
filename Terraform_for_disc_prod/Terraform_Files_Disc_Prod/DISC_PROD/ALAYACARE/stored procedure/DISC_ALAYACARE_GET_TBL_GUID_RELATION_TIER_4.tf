resource "snowflake_procedure" "DISC_ALAYACARE_GET_TBL_GUID_RELATION_TIER_4" {
	name ="GET_TBL_GUID_RELATION_TIER_4"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
--*****************************************************************************************************************************
-- NAME:  GET_TBL_GUID_RELATION_TIER_4 
--
-- PURPOSE: USING THIS SP FOR DISCOVERY TABLE LOAD
--
-- DEVELOPMENT LOG:
-- DATE        		AUTHOR                	NOTES:
-- ----------  		-------------------   	-----------------------------------------------------------------------------------------------
-- 2021-11-11		UNKNOWN					INITIAL DEVELOPMENT
-- 2023-09-05  		RAVI SUTHAR            	MIGRATED JavaScript to SQL
--*****************************************************************************************************************************
    return_result varchar(1000);
BEGIN
	
    INSERT OVERWRITE INTO ALAYACARE.TBL_GUID_RELATION_TIER_4  
	SELECT ID,GUID_ONE,GUID_TWO,
	PROPERTIES[''Op'']::VARCHAR(100) AS OP,
	PROPERTIES[''idmethod'']::VARCHAR(100) AS IDMETHOD,
	PROPERTIES[''idrelation'']::VARCHAR(100) AS IDRELATION,
	PROPERTIES[''rating'']::VARCHAR(100) AS RATING,
    PROPERTIES[''id'']::VARCHAR(100) AS OP,
	PROPERTIES[''guid_one'']::VARCHAR(100) AS IDMETHOD,
	PROPERTIES[''guid_two'']::VARCHAR(100) AS IDRELATION,
    PROPERTIES[''Op'']::VARCHAR(100) AS OP,
	PROPERTIES[''idmethod'']::VARCHAR(100) AS IDMETHOD,
	PROPERTIES[''idrelation'']::VARCHAR(100) AS IDRELATION,
	PROPERTIES[''rating'']::VARCHAR(100) AS RATING,
    PROPERTIES TEXT
	FROM  ALAYACARE_${var.SF_ENVIRONMENT}UCTION."5C3EE5FE-45A5-4DA7-A35B-BD7CDAFE3548".SHARED_TBL_GUID_RELATION_TIER_4;

	SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
	return return_result;
END;

 EOT
}

