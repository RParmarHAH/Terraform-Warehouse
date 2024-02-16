resource "snowflake_view" "DISC_MATRIXCARE_VW_T_CAREGIVER_MARITALSTATUS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "VW_T_CAREGIVER_MARITALSTATUS"
	statement = <<-SQL
	 WITH DEFINITIONS AS (
	SELECT CODES.CAR_MARITALSTATID, DEFINITIONS.MARITAL_STATUS AS MARITALSTATUS_TEXT, 
		ROW_NUMBER() OVER (PARTITION BY CODES.CAR_MARITALSTATID ORDER BY COUNT(*) DESC) AS ROW_NUMBER
	FROM MATRIXCARE.STVHC_T_CAREGIVER AS CODES
	JOIN ADAPTIVENURSINGEXPORT.T_CAREGIVER AS DEFINITIONS
		ON DEFINITIONS.CAR_ID = CODES.CAR_ID 
	WHERE CODES.CAR_MARITALSTATID IS NOT NULL AND DEFINITIONS.MARITAL_STATUS IS NOT NULL
	GROUP BY CODES.CAR_MARITALSTATID, DEFINITIONS.MARITAL_STATUS 
)
	SELECT CAR_MARITALSTATID, MARITALSTATUS_TEXT
	FROM DEFINITIONS
	WHERE ROW_NUMBER = 1;
SQL
	or_replace = true 
	is_secure = false 
}

