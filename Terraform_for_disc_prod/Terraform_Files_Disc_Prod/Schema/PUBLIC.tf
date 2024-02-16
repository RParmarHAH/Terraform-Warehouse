resource "snowflake_schema" "PUBLIC" {
  database = "DISC_DB"
  name     = "PUBLIC"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}