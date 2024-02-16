resource "snowflake_schema" "ADAPTIVENURSINGEXPORT" {
  database = "DISC_DB"
  name     = "ADAPTIVENURSINGEXPORT"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}