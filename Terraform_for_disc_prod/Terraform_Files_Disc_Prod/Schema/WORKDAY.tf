resource "snowflake_schema" "WORKDAY" {
  database = "DISC_DB"
  name     = "WORKDAY"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}