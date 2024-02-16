resource "snowflake_schema" "DATA_CLEANSING" {
  database = "DISC_DB"
  name     = "DATA_CLEANSING"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}