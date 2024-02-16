resource "snowflake_schema" "GENERATIONSALLIANCE" {
  database = "DISC_DB"
  name     = "GENERATIONSALLIANCE"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}