resource "snowflake_schema" "QUALTRICS_SURVEYS" {
  database = "DISC_DB"
  name     = "QUALTRICS_SURVEYS"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}