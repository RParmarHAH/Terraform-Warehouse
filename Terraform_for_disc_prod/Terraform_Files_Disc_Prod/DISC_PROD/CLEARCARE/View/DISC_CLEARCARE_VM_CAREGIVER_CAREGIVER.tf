resource "snowflake_view" "DISC_CLEARCARE_VM_CAREGIVER_CAREGIVER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "VM_CAREGIVER_CAREGIVER"
	statement = <<-SQL
	 
SELECT PR.CAREGIVER_ID||PR.AGENCY_ID as ID, PR.CAREGIVER_ID, PR.AGENCY_ID, REGEXP_REPLACE(TRIM(UPPER(PR.FIRST_NAME)), '[^A-Za-z]', '') FIRST_NAME, REGEXP_REPLACE(TRIM(UPPER(PR.LAST_NAME)), '[^A-Za-z]', '') LAST_NAME, CE.DATE_OF_BIRTH AS DOB, TRIM(UPPER(PR.ADDRESS)) AS ADDRESS, TRIM(UPPER(PR.CITY)) AS CITY, COALESCE(PR.HOME_PHONE, PR.MOBILE_PHONE) AS PHONE, TRIM(UPPER(CE.GENDER)) AS GENDER FROM disc_prod.clearcare.profile_patient_agencylocation AS PR 
INNER JOIN disc_prod.clearcare.caregiver_caregiver AS CA ON PR.caregiver_id = CA.id 
INNER JOIN disc_prod.clearcare.caregiver_caregiverskillseducation CE ON CE.caregiver_id = PR.caregiver_id WHERE CA.is_hired = true;
SQL
	or_replace = true 
	is_secure = false 
}

