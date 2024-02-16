resource "snowflake_schema" "HAH_REPORTING" {
  database = "DISC_DB"
  name     = "HAH_REPORTING"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}