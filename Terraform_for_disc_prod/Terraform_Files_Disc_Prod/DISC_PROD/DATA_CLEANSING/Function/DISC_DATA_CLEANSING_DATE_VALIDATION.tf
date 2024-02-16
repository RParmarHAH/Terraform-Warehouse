resource "snowflake_function" "DISC_DATA_CLEANSING_DATE_VALIDATION" {
	name = "DATE_VALIDATION"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	language  = "SQL"

	arguments {
		name = "Date"
		type = "DATE"
}	
	return_type = "DATE"
	statement = <<-EOT

    CASE
        WHEN DATE IS NULL THEN 
        NULL 
        WHEN REGEXP_LIKE(('2022/01/30'),'(((19|20)([2468][048]|[13579][26]|0[48])|2000)[/-]02[/-]29|((19|20)[0-9]{2}[/-](0[4678]|1[02])[/](0[1-9]|[12][0-9]|30)|(19|20)[0-9]{2}[/-](0[1359]|11)[/-](0[1-9]|[12][0-9]|3[01])|(19|20)[0-9]{2}[/-]02[/-](0[1-9]|1[0-9]|2[0-8])))') THEN
        DATE
        END

 EOT
}

