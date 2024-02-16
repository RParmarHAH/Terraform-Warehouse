resource "snowflake_view" "DISC_CCSI_RAWVRFP" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "RAWVRFP"
	statement = <<-SQL
	 
SELECT * FROM
(SELECT * FROM DISC_${var.SF_ENVIRONMENT}.CCSI.RAWVRFP_LATEST
UNION
SELECT * FROM DISC_${var.SF_ENVIRONMENT}.CCSI.RAWVRFP_ARCHIVED 
) T1;
SQL
	or_replace = true 
	is_secure = false 
}

