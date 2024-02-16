resource "snowflake_schema" "BI_REPOSITORY" {
  database = "DISC_DB"
  name     = "BI_REPOSITORY"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}