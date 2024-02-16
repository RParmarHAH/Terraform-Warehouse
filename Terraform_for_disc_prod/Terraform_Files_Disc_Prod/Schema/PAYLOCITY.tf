resource "snowflake_schema" "PAYLOCITY" {
  database = "DISC_DB"
  name     = "PAYLOCITY"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}