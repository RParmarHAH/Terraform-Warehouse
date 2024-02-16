resource "snowflake_schema" "STAGE" {
  database = "DISC_DB"
  name     = "STAGE"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}