resource "snowflake_schema" "FILEPRO" {
  database = "DISC_DB"
  name     = "FILEPRO"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}