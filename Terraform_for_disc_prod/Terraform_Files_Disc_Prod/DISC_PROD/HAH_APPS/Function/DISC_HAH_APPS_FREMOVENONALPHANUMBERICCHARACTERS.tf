resource "snowflake_function" "DISC_HAH_APPS_FREMOVENONALPHANUMBERICCHARACTERS" {
	name = "FREMOVENONALPHANUMBERICCHARACTERS"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HAH_APPS"
	language  = "SQL"

	arguments {
		name = "STRING"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	statement = <<-EOT

				REPLACE(
				REPLACE(
				REPLACE(
				REPLACE(
						STRING, 
					' ', ''),
					'.', ''),
					'_', ''),
					'-', '')
			
 EOT
}

