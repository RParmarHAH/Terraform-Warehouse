resource "snowflake_schema" "HHAEXCHANGEOSHAH" {
  database = "DISC_DB"
  name     = "HHAEXCHANGEOSHAH"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}