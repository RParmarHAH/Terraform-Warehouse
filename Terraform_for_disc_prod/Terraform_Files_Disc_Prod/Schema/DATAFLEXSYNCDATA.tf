resource "snowflake_schema" "DATAFLEXSYNCDATA" {
  database = "DISC_DB"
  name     = "DATAFLEXSYNCDATA"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}