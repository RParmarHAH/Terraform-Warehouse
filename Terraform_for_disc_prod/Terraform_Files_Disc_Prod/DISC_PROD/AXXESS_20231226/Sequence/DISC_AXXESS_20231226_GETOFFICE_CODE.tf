resource "snowflake_sequence" "DISC_AXXESS_20231226_GETOFFICE_CODE" {
	name ="GETOFFICE_CODE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS_20231226"
	start_with = -8
	increment  = -1
	order  = true
}

