resource "snowflake_schema" "SANDATAIMPORT" {
  database = "DISC_DB"
  name     = "SANDATAIMPORT"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}