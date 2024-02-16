resource "snowflake_schema" "RISKONNECT" {
  database = "DISC_DB"
  name     = "RISKONNECT"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}