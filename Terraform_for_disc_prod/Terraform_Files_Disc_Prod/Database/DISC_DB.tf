resource "snowflake_database" "DISC_DB" {
	name = "DISC_${var.SF_ENVIRONMENT}"
	comment= "Discovery production databases"
    data_retention_time_in_days = 1

}