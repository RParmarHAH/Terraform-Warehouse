resource "snowflake_schema" "FINANCE" {
  database = "DISC_DB"
  name     = "FINANCE"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}