resource "snowflake_schema" "ADP" {
  database = "DISC_DB"
  name     = "ADP"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}