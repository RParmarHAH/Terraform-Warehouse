resource "snowflake_sequence" "DISC_AXXESS_20231226_SEQ1" {
	name ="SEQ1"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS_20231226"
	start_with = 1
	increment  = 1
	order  = true
}

