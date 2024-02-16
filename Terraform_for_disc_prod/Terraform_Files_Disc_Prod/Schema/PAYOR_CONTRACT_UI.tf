resource "snowflake_schema" "PAYOR_CONTRACT_UI" {
  database = "DISC_DB"
  name     = "PAYOR_CONTRACT_UI"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}