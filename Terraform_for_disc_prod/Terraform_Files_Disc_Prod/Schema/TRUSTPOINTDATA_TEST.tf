resource "snowflake_schema" "TRUSTPOINTDATA_TEST" {
  database = "DISC_DB"
  name     = "TRUSTPOINTDATA_TEST"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}