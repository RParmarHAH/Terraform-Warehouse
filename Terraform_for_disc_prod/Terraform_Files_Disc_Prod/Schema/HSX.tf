resource "snowflake_schema" "HSX" {
  database = "DISC_DB"
  name     = "HSX"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}