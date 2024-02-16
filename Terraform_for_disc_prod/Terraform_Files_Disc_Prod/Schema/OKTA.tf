resource "snowflake_schema" "OKTA" {
  database = "DISC_DB"
  name     = "OKTA"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}