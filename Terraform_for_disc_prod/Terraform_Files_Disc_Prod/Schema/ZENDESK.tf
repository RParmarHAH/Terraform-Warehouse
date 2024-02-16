resource "snowflake_schema" "ZENDESK" {
  database = "DISC_DB"
  name     = "ZENDESK"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}