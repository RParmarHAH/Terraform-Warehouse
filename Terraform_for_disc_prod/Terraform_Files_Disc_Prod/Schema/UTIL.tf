resource "snowflake_schema" "UTIL" {
  database = "DISC_DB"
  name     = "UTIL"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}