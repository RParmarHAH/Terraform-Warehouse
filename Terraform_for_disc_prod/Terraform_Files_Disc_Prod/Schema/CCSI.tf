resource "snowflake_schema" "CCSI" {
  database = "DISC_DB"
  name     = "CCSI"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}