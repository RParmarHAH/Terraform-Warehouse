resource "snowflake_schema" "VIVENTIUM" {
  database = "DISC_DB"
  name     = "VIVENTIUM"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}