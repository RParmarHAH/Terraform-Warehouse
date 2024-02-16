resource "snowflake_sequence" "DISC_AXXESS_20231226_GETOFFCE_NUMBER" {
	name ="GETOFFCE_NUMBER"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS_20231226"
	start_with = 8659
	increment  = 1
	order  = true
}

