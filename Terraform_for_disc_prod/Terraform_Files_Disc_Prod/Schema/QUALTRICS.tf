resource "snowflake_schema" "QUALTRICS" {
  database = "DISC_DB"
  name     = "QUALTRICS"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}