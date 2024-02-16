resource "snowflake_schema" "ICD" {
  database = "DISC_DB"
  name     = "ICD"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}