resource "snowflake_schema" "APTITIVE_DEV" {
  database = "DISC_DB"
  name     = "APTITIVE_DEV"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}