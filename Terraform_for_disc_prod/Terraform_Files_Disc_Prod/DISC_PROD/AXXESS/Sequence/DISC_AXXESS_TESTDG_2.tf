resource "snowflake_sequence" "DISC_AXXESS_TESTDG_2" {
	name ="TESTDG_2"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	start_with = 8659
	increment  = 1
	order  = true
}

