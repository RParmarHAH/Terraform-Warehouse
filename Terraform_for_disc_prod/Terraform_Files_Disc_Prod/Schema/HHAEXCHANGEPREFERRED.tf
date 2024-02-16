resource "snowflake_schema" "HHAEXCHANGEPREFERRED" {
  database = "DISC_DB"
  name     = "HHAEXCHANGEPREFERRED"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}