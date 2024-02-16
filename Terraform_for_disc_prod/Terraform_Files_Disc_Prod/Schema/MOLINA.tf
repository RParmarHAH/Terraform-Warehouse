resource "snowflake_schema" "MOLINA" {
  database = "DISC_DB"
  name     = "MOLINA"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}