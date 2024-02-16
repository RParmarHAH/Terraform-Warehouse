resource "snowflake_schema" "TRUSTPOINTDATA_HIST" {
  database = "DISC_DB"
  name     = "TRUSTPOINTDATA_HIST"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}