resource "snowflake_schema" "HHAEXCHANGEEDISON" {
  database = "DISC_DB"
  name     = "HHAEXCHANGEEDISON"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}