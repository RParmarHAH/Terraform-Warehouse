CREATE OR REPLACE PROCEDURE DISC_PROD.PUBLIC.DISCOVERY_LAYER_SYNC("MERGE_QUERY" VARCHAR(16777216), "INSERT_QUERY" VARCHAR(16777216), "DELETE_QUERY" VARCHAR(16777216), "RE_CREATE_CURRENT_VIEW" VARCHAR(16777216), "END_AUDIT_QUERY" VARCHAR(16777216), "AUDIT_QUERY" VARCHAR(16777216), "AUDIT_UPDATE_QUERY" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
   
   
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
		etl_statement = "CALL DISC_PROD.PUBLIC.INSERT_AUDIT_END_TASK ("+END_AUDIT_QUERY+")";
		snowflake.execute (
            {sqlText: etl_statement}
            );
        return "Succeeded.";   // Return a success/error indicator.
        }
    catch (err)  {
        return "Failed: " + err;   // Return a success/error indicator.
        }
';