resource "snowflake_schema" "NAVISION" {
  database = "DISC_DB"
  name     = "NAVISION"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}