resource "snowflake_schema" "HAHUSERS" {
  database = "DISC_DB"
  name     = "HAHUSERS"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}