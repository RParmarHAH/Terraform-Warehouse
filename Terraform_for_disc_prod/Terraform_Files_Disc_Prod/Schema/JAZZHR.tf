resource "snowflake_schema" "JAZZHR" {
  database = "DISC_DB"
  name     = "JAZZHR"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}