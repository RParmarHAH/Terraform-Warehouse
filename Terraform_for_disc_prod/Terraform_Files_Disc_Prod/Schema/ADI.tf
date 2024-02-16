resource "snowflake_schema" "ADI" {
  database = "DISC_DB"
  name     = "ADI"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}