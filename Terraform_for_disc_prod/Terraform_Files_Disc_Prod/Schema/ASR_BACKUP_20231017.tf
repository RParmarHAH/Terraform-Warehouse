resource "snowflake_schema" "ASR_BACKUP_20231017" {
  database = "DISC_DB"
  name     = "ASR_BACKUP_20231017"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}