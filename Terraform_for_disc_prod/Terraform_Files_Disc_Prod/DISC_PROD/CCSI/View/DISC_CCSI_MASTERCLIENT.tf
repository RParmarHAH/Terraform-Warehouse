resource "snowflake_view" "DISC_CCSI_MASTERCLIENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "MASTERCLIENT"
	statement = <<-SQL
	 
SELECT * FROM DISC_${var.SF_ENVIRONMENT}.CCSI.MASTERCLIENT_LATEST;
SQL
	or_replace = true 
	is_secure = false 
}

