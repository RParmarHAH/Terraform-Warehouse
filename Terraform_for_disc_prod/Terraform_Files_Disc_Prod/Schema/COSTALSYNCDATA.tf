resource "snowflake_schema" "COSTALSYNCDATA" {
  database = "DISC_DB"
  name     = "COSTALSYNCDATA"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}