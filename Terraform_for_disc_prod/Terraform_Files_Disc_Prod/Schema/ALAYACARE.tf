resource "snowflake_schema" "ALAYACARE" {
  database = "DISC_DB"
  name     = "ALAYACARE"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}