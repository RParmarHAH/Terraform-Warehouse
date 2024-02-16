resource "snowflake_schema" "AXXESS" {
  database = "DISC_DB"
  name     = "AXXESS"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}