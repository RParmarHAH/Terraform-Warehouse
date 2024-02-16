resource "snowflake_schema" "CENTENE" {
  database = "DISC_DB"
  name     = "CENTENE"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}