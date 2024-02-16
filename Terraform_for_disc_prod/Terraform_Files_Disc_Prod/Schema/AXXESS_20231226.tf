resource "snowflake_schema" "AXXESS_20231226" {
  database = "DISC_DB"
  name     = "AXXESS_20231226"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}