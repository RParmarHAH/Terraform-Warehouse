resource "snowflake_schema" "ASR" {
  database = "DISC_DB"
  name     = "ASR"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}