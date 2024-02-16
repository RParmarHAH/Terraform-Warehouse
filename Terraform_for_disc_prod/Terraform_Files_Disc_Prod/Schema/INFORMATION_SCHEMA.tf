resource "snowflake_schema" "INFORMATION_SCHEMA" {
  database = "DISC_DB"
  name     = "INFORMATION_SCHEMA"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}