resource "snowflake_schema" "ACTIVE_DIRECTORY" {
  database = "DISC_DB"
  name     = "ACTIVE_DIRECTORY"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}