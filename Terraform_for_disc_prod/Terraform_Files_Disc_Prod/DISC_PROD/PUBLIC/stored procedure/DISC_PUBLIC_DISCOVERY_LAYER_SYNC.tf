resource "snowflake_procedure" "DISC_PUBLIC_DISCOVERY_LAYER_SYNC" {
	name ="DISCOVERY_LAYER_SYNC"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "JAVASCRIPT"

	arguments {
		name = "MERGE_QUERY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "INSERT_QUERY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "DELETE_QUERY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "RE_CREATE_CURRENT_VIEW"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "END_AUDIT_QUERY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "AUDIT_QUERY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "AUDIT_UPDATE_QUERY"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

   
   
   var etl_statement = AUDIT_QUERY;
   try {
        snowflake.execute (
            {sqlText: etl_statement}
            );
        etl_statement = MERGE_QUERY;
		snowflake.execute (
            {sqlText: etl_statement}
            );
		etl_statement = INSERT_QUERY;
		snowflake.execute (
            {sqlText: etl_statement}
            );
		etl_statement = DELETE_QUERY;
		snowflake.execute (
            {sqlText: etl_statement}
            );
		etl_statement = RE_CREATE_CURRENT_VIEW;
		snowflake.execute (
            {sqlText: etl_statement}
            );
		etl_statement = AUDIT_UPDATE_QUERY;
		snowflake.execute (
            {sqlText: etl_statement}
            );
		etl_statement = "CALL DISC_${var.SF_ENVIRONMENT}.PUBLIC.INSERT_AUDIT_END_TASK ("+END_AUDIT_QUERY+")";
		snowflake.execute (
            {sqlText: etl_statement}
            );
        return "Succeeded.";   // Return a success/error indicator.
        }
    catch (err)  {
        return "Failed: " + err;   // Return a success/error indicator.
        }

 EOT
}

