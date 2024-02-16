resource "snowflake_schema" "PAYOR_CONTRACT_UI_20240502" {
  database = "DISC_DB"
  name     = "PAYOR_CONTRACT_UI_20240502"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}