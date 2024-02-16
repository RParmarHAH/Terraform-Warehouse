resource "snowflake_schema" "EMPEONEDISON" {
  database = "DISC_DB"
  name     = "EMPEONEDISON"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}