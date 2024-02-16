resource "snowflake_schema" "APPBASEDATA" {
  database = "DISC_DB"
  name     = "APPBASEDATA"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}