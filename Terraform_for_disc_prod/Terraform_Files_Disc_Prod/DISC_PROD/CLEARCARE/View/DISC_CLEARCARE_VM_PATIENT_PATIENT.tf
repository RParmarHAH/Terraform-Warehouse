resource "snowflake_view" "DISC_CLEARCARE_VM_PATIENT_PATIENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "VM_PATIENT_PATIENT"
	statement = <<-SQL
	 
SELECT PR.PATIENT_ID||PR.AGENCY_ID as ID, PR.PATIENT_ID, PR.AGENCY_ID, REGEXP_REPLACE(TRIM(UPPER(PR.FIRST_NAME)), '[^A-Za-z]', '') FIRST_NAME, REGEXP_REPLACE(TRIM(UPPER(PR.LAST_NAME)), '[^A-Za-z]', '') LAST_NAME,
PP.DATE_OF_BIRTH AS DOB, 
TRIM(UPPER(PR.ADDRESS)) AS ADDRESS, 
TRIM(UPPER(PR.CITY)) AS CITY, COALESCE(PR.HOME_PHONE, PR.MOBILE_PHONE) AS PHONE, TRIM(UPPER(PP.GENDER)) AS GENDER FROM disc_prod.clearcare.profile_patient_agencylocation AS PR
INNER JOIN disc_prod.clearcare.patient_patient AS PA ON PR.patient_id = PA.id LEFT JOIN disc_prod.clearcare.patient_patientplan PP ON PA.id = PP.patient_id WHERE (PA.is_client = true);
SQL
	or_replace = true 
	is_secure = false 
}

