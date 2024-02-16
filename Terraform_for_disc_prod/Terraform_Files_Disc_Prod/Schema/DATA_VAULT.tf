resource "snowflake_schema" "DATA_VAULT" {
  database = "DISC_DB"
  name     = "DATA_VAULT"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}