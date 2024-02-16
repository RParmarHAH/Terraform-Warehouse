resource "snowflake_schema" "HAH_APPS" {
  database = "DISC_DB"
  name     = "HAH_APPS"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}