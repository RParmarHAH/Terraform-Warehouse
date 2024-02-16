resource "snowflake_schema" "1UP_HEALTH" {
  database = "DISC_DB"
  name     = "1UP_HEALTH"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}