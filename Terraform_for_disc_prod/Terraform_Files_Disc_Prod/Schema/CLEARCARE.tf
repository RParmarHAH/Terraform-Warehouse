resource "snowflake_schema" "1UP_CLEARCAREISON" {
  database = "DISC_DB"
  name     = "CLEARCARE"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}