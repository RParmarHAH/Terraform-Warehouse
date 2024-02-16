resource "snowflake_schema" "SANDATAEXCHANGE" {
  database = "DISC_DB"
  name     = "SANDATAEXCHANGE"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}