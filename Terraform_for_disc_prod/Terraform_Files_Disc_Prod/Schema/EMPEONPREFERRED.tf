resource "snowflake_schema" "EMPEONPREFERRED" {
  database = "DISC_DB"
  name     = "EMPEONPREFERRED"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}