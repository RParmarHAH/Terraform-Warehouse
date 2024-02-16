resource "snowflake_database" "DW_DB" {
	name = "DW_${var.SF_ENVIRONMENT}"
	comment= "Production DW database"
    data_retention_time_in_days = 1
 
}


