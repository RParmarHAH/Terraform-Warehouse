resource "snowflake_procedure" "DISC_PUBLIC_OUTPUT_MESSAGE" {
	name ="OUTPUT_MESSAGE"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "SQL"
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE 
	TaskName varchar;
begin
    
    TaskName := ''Mitul'';
    return TaskName;
end;

 EOT
}

