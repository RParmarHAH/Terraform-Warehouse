resource "snowflake_schema" "MATRIXCARE_FULLLOAD" {
  database = "DISC_DB"
  name     = "MATRIXCARE_FULLLOAD"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}