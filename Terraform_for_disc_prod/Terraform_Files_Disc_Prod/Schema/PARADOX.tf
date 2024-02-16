resource "snowflake_schema" "PARADOX" {
  database = "DISC_DB"
  name     = "PARADOX"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}