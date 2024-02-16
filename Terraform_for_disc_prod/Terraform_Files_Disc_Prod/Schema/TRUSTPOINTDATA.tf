resource "snowflake_schema" "TRUSTPOINTDATA" {
  database = "DISC_DB"
  name     = "TRUSTPOINTDATA"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}