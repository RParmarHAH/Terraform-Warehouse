resource "snowflake_schema" "DEVERO" {
  database = "DISC_DB"
  name     = "DEVERO"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}