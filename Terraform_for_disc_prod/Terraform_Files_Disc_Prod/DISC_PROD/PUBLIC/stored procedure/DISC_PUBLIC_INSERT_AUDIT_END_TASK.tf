resource "snowflake_procedure" "DISC_PUBLIC_INSERT_AUDIT_END_TASK" {
	name ="INSERT_AUDIT_END_TASK"
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	language  = "JAVASCRIPT"

	arguments {
		name = "ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "SCHEMA_NAME"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "DATABASE_NAME"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "TABLE_NAME"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "SOURCETYPE"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

   var EXTRACT = "SELECT COUNT(0) AS EXTRACT_ROW_COUNT FROM " + DATABASE_NAME + "." + SCHEMA_NAME + "." + TABLE_NAME;
	var FINAL = "SELECT COUNT(0) AS TARGET_FINAL_ROW_COUNT FROM " + DATABASE_NAME + "." + SCHEMA_NAME + "." + TABLE_NAME; 
   if (SOURCETYPE  == ''Master'')
   {
        var EXTRACT = "SELECT 0 AS EXTRACT_ROW_COUNT";
        var FINAL = "SELECT 0 AS TARGET_FINAL_ROW_COUNT";
   }
   
   
   if (SOURCETYPE == ''SQLServer'' || SOURCETYPE == ''DiscoveryPostProcessing'' || SOURCETYPE == ''SQLServerOverwrite'')
   {
	
    var MAX_VERSION = "SELECT MAX(SYS_CHANGE_VERSION) AS MAX_CHANGE_VERSION FROM " + DATABASE_NAME + "." + SCHEMA_NAME + "." + TABLE_NAME; 
   }
   else
   {
    var MAX_VERSION = "SELECT 0 AS MAX_CHANGE_VERSION";
   }
   
   var etl_statement = "UPDATE ETL_MANAGEMENT_${var.SF_ENVIRONMENT}.AUDIT.ETL_TASK SET SNOWFLAKE_SESSION_ID = " + ETL_TASK_KEY;
   etl_statement += ", EXECUTION_STOP_DATE = CURRENT_timestamp()::TIMESTAMP_NTZ(9)";
   etl_statement += ", SYS_CHANGE_VERSION_END = COALESCE(ctes.MAX_CHANGE_VERSION, 0)";
   etl_statement += ", EXTRACT_ROW_COUNT = COALESCE(ctes.EXTRACT_ROW_COUNT,0)";
   etl_statement += ", TARGET_FINAL_ROW_COUNT = COALESCE(ctes.TARGET_FINAL_ROW_COUNT,0)";
   etl_statement += ", SUCCESSFUL_PROCESSING_IND = TRUE";
   etl_statement += " FROM (WITH EXTRACT AS ( " + EXTRACT + " ),";
   etl_statement += "FINAL AS ( " + FINAL + " ),";
   etl_statement += "MAX_VERSION AS (" + MAX_VERSION + ")";
   etl_statement += "SELECT EXTRACT_ROW_COUNT,TARGET_FINAL_ROW_COUNT,MAX_CHANGE_VERSION FROM FINAL, EXTRACT, MAX_VERSION) ctes ";
   etl_statement += "WHERE TASK_KEY = " + ETL_TASK_KEY + ";";
   try {
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

