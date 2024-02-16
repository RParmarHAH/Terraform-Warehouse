resource "snowflake_schema" "HHAEXCHANGEOPENSYSTEMS" {
  database = "DISC_DB"
  name     = "HHAEXCHANGEOPENSYSTEMS"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}