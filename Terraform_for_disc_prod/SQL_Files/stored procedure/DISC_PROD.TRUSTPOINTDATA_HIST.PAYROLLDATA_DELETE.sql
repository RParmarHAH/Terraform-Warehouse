CREATE OR REPLACE PROCEDURE DISC_PROD.TRUSTPOINTDATA_HIST.PAYROLLDATA_DELETE("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
        var sql = `
   delete from "DISC_PROD"."TRUSTPOINTDATA"."PAYROLL" where REGEXP_LIKE(EMPLOYEE_ID, ''[a-zA-Z].*'') =''TRUE'' AND COMPANY = ''EXCEL'';
`;
          try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                return "Succeeded.";   // Return a success/error indicator.
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                }  
          ';