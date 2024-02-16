resource "snowflake_schema" "HEALTH_NAVIGATOR" {
  database = "DISC_DB"
  name     = "HEALTH_NAVIGATOR"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}