resource "snowflake_schema" "ADMINPAYROLL" {
  database = "DISC_DB"
  name     = "ADMINPAYROLL"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}