resource "snowflake_schema" "EMPLOYEESETUP" {
  database = "DISC_DB"
  name     = "EMPLOYEESETUP"
 
  is_transient        = false
  is_managed          = false
  data_retention_time_in_days = 1
}