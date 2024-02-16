resource "snowflake_schema" "AMERIHEALTH" {
  database = "DISC_DB"
  name     = "AMERIHEALTH"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}