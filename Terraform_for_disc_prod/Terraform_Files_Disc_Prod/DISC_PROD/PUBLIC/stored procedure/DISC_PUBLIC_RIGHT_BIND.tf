resource "snowflake_procedure" "DISC_PUBLIC_RIGHT_BIND" {
	name ="RIGHT_BIND"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "JAVASCRIPT"

	arguments {
		name = "TIMESTAMP_VALUE"
		type = "VARCHAR(16777216)"
}	
	return_type = "BOOLEAN"
	execute_as = "OWNER"
	statement = <<-EOT

var cmd = "SELECT CURRENT_DATE() > TO_TIMESTAMP(:1, ''YYYY-MM-DD HH24:MI:SS'')";

return "true";

 EOT
}

