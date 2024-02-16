resource "snowflake_schema" "GPSYNCDATA" {
  database = "DISC_DB"
  name     = "GPSYNCDATA"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}