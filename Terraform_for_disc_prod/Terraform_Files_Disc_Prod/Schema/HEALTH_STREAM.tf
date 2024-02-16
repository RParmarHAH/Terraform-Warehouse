resource "snowflake_schema" "HEALTH_STREAM" {
  database = "DISC_DB"
  name     = "HEALTH_STREAM"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}