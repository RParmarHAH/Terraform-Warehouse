resource "snowflake_schema" "OLYMPUS" {
  database = "DISC_DB"
  name     = "OLYMPUS"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}