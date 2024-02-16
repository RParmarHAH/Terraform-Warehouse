resource "snowflake_schema" "DOCEBO" {
  database = "DISC_DB"
  name     = "DOCEBO"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}