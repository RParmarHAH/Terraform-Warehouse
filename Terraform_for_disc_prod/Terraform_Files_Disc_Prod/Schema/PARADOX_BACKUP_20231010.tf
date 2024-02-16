resource "snowflake_schema" "PARADOX_BACKUP_20231010" {
  database = "DISC_DB"
  name     = "PARADOX_BACKUP_20231010"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}