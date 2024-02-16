resource "snowflake_schema" "USZIPS" {
  database = "DISC_DB"
  name     = "USZIPS"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}