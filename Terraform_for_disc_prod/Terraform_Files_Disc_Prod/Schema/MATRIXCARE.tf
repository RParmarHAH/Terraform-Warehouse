resource "snowflake_schema" "MATRIXCARE" {
  database = "DISC_DB"
  name     = "MATRIXCARE"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}