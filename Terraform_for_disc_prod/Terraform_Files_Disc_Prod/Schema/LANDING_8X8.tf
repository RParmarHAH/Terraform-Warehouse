resource "snowflake_schema" "LANDING_8X8" {
  database = "DISC_DB"
  name     = "LANDING_8X8"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}