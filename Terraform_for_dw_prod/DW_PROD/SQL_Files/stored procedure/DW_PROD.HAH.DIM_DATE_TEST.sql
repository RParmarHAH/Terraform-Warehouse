CREATE OR REPLACE PROCEDURE DW_PROD.HAH.DIM_DATE_TEST("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
        var sql = `
    INSERT OVERWRITE INTO HAH.DIM_DATE
WITH CTE_CALENDAR_DATE AS (
    SELECT DATEADD(DAY, SEQ4(), ''1970-01-01'') AS CALENDAR_DATE
      FROM TABLE(GENERATOR(ROWCOUNT=>50000)) 
  )
  SELECT
	  	TO_NUMBER(TO_VARCHAR(CALENDAR_DATE::date, ''yyyymmdd'')) AS DATE_KEY
	    ,TO_DATE( CALENDAR_DATE) AS CALENDAR_DATE
        ,YEAR( CALENDAR_DATE) AS YEAR
        ,TO_DATE( DATE_TRUNC(''YEAR'', CALENDAR_DATE)) AS FIRST_DAY_OF_YEAR
        ,TO_DATE( LAST_DAY( CALENDAR_DATE, ''YEAR'')) AS LAST_DAY_OF_YEAR
        ,TO_DATE( ADD_MONTHS( DATE_TRUNC(''YEAR'', CALENDAR_DATE), -12)) AS PREVIOUS_YEAR_FIRST_DAY
        ,TO_DATE( ADD_MONTHS( LAST_DAY( CALENDAR_DATE, ''YEAR''), -12)) AS PREVIOUS_YEAR_LAST_DAY
        ,QUARTER(CALENDAR_DATE) AS QUARTER
        ,''Q'' || QUARTER(CALENDAR_DATE) ||'', ''||YEAR(CALENDAR_DATE) AS QUARTER_NAME
        ,YEAR(CALENDAR_DATE) ||  QUARTER(CALENDAR_DATE) AS YEAR_QUARTER
        ,TO_DATE( DATE_TRUNC(''QUARTER'', CALENDAR_DATE)) AS FIRST_DAY_OF_QUARTER
        ,TO_DATE( LAST_DAY( CALENDAR_DATE, ''QUARTER'')) AS LAST_DAY_OF_QUARTER
        ,TO_DATE( ADD_MONTHS( DATE_TRUNC(''QUARTER'', CALENDAR_DATE), -3)) AS PREVIOUS_QUARTER_FIRST_DAY
        ,TO_DATE( ADD_MONTHS( LAST_DAY( CALENDAR_DATE, ''QUARTER''), -3)) AS PREVIOUS_QUARTER_LAST_DAY
        ,MONTH(CALENDAR_DATE) AS MONTH
        ,YEAR(CALENDAR_DATE) ||  RIGHT(''00'' || DATE_PART(mm, CALENDAR_DATE),2) AS YEAR_MONTH
        ,CASE   WHEN MONTH(CALENDAR_DATE) = 1 THEN ''January''
                WHEN MONTH(CALENDAR_DATE) = 2 THEN ''February''
                WHEN MONTH(CALENDAR_DATE) = 3 THEN ''March''
                WHEN MONTH(CALENDAR_DATE) = 4 THEN ''April''
                WHEN MONTH(CALENDAR_DATE) = 5 THEN ''May''
                WHEN MONTH(CALENDAR_DATE) = 6 THEN ''June''
                WHEN MONTH(CALENDAR_DATE) = 7 THEN ''July''
                WHEN MONTH(CALENDAR_DATE) = 8 THEN ''August''
                WHEN MONTH(CALENDAR_DATE) = 9 THEN ''September''
                WHEN MONTH(CALENDAR_DATE) = 10 THEN ''October''
                WHEN MONTH(CALENDAR_DATE) = 11 THEN ''November''
                WHEN MONTH(CALENDAR_DATE) = 12 THEN ''December''
                ELSE ''January'' END || '' '' || YEAR(CALENDAR_DATE) AS YEAR_MONTH_DESC
        ,MONTHNAME(CALENDAR_DATE) AS MONTH_NAME
        ,TO_DATE( DATE_TRUNC(''MONTH'', CALENDAR_DATE)) AS FIRST_DAY_OF_MONTH
        ,TO_DATE( LAST_DAY( CALENDAR_DATE, ''MONTH'')) AS LAST_DAY_OF_MONTH
        ,TO_DATE( ADD_MONTHS( DATE_TRUNC(''MONTH'', CALENDAR_DATE), -1)) AS PREVIOUS_MONTH_FIRST_DAY
        ,TO_DATE( ADD_MONTHS( LAST_DAY( CALENDAR_DATE, ''MONTH''), -1)) AS PREVIOUS_MONTH_LAST_DAY
        ,TO_DATE( DATEADD( ''WEEK'', -3, DATE_TRUNC(''WEEK'', CALENDAR_DATE))) AS MOST_RECENT_4_WEEKS_FIRST_DAY
        ,TO_DATE( LAST_DAY( CALENDAR_DATE, ''WEEK'')) AS MOST_RECENT_4_WEEKS_LAST_DAY
        ,TO_DATE( DATEADD( ''WEEK'', -7, DATE_TRUNC(''WEEK'', CALENDAR_DATE))) AS PREVIOUS_4_WEEKS_FIRST_DAY
        ,TO_DATE( DATEADD( ''WEEK'', -4, LAST_DAY( CALENDAR_DATE, ''WEEK''))) AS PREVIOUS_4_WEEKS_LAST_DAY
        ,TO_DATE( DATEADD( ''WEEK'', -4, DATE_TRUNC(''WEEK'', CALENDAR_DATE))) AS PREVIOUS_4th_WEEK_FIRST_DAY
        ,TO_DATE( DATEADD( ''WEEK'', -4, LAST_DAY( CALENDAR_DATE, ''WEEK''))) AS PREVIOUS_4th_WEEK_LAST_DAY
        ,TO_DATE( DATEADD( ''WEEK'', -4, DATE_TRUNC(''WEEK'', CALENDAR_DATE))) AS PREVIOUS_ROLLING_4_WEEKS_FIRST_DAY
        ,TO_DATE( DATEADD( ''WEEK'', -1, LAST_DAY( CALENDAR_DATE, ''WEEK''))) AS PREVIOUS_ROLLING_4_WEEKS_LAST_DAY
        ,WEEKOFYEAR(CALENDAR_DATE) AS WEEK_OF_YEAR
        ,TO_DATE( DATE_TRUNC(''WEEK'', CALENDAR_DATE)) AS HAH_CURRENT_WEEK_FIRST_DAY
        ,TO_DATE( LAST_DAY( CALENDAR_DATE, ''WEEK'')) AS HAH_CURRENT_WEEK_LAST_DAY
        ,TO_DATE( DATEADD( ''WEEK'', -1, DATE_TRUNC(''WEEK'', CALENDAR_DATE))) AS HAH_PREVIOUS_WEEK_FIRST_DAY
        ,TO_DATE( DATEADD( ''WEEK'', -1, LAST_DAY( CALENDAR_DATE, ''WEEK''))) AS HAH_PREVIOUS_WEEK_LAST_DAY
        ,DAYOFYEAR(CALENDAR_DATE) AS DAY_OF_YEAR
        ,DAY(CALENDAR_DATE) AS DAY_OF_MONTH
        ,DAYOFWEEK(CALENDAR_DATE) AS DAY_OF_WEEK
        ,DAYNAME(CALENDAR_DATE) AS DAY_NAME
        ,YEAR(CALENDAR_DATE) ||  RIGHT(''000'' || DAYOFYEAR(CALENDAR_DATE),3) AS YEAR_DAY
        ,CASE WHEN DAYOFWEEK(CALENDAR_DATE) = 0 OR DAYOFWEEK(CALENDAR_DATE) = 6 THEN TRUE ELSE FALSE END AS WEEKEND_FLAG
        ,CAST( ''FALSE'' AS BOOLEAN) AS HOLIDAY_FLAG
        ,YEAROFWEEKISO(CALENDAR_DATE) AS ISO_YEAR
        ,WEEKISO( CALENDAR_DATE) AS ISO_WEEK
        ,DAYOFWEEKISO( CALENDAR_DATE) AS ISO_DAY
		,CASE WHEN DATE_TRUNC(''YEAR'',CALENDAR_DATE) = DATE_TRUNC(''YEAR'',CURRENT_DATE) THEN TRUE ELSE FALSE END AS IS_CURRENT_YEAR
		,CASE WHEN DATE_TRUNC(''MONTH'',CALENDAR_DATE) = DATE_TRUNC(''MONTH'',CURRENT_DATE) THEN TRUE ELSE FALSE END AS IS_CURRENT_MONTH
		,CASE WHEN DATE_TRUNC(''WEEK'',CALENDAR_DATE) = DATE_TRUNC(''WEEK'',CURRENT_DATE) THEN TRUE ELSE FALSE END AS IS_CURRENT_WEEK
		,CASE WHEN DATE_TRUNC(''DAY'',CALENDAR_DATE) = DATE_TRUNC(''DAY'',CURRENT_DATE) THEN TRUE ELSE FALSE END AS IS_TODAY
    FROM CTE_CALENDAR_DATE
`;
         try {
                snowflake.execute (
                    {sqlText: sql}
                    );
               
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                } 
           sql = `UPDATE HAH.DIM_DATE SET Holiday_Flag = CAST( ''TRUE'' AS BOOLEAN)
                        WHERE (MONTH = 1 AND DAY_OF_MONTH = 1)
                        OR (MONTH = 7 AND DAY_OF_MONTH = 4)     
                        OR (MONTH = 11 AND DAY_OF_MONTH = 11)  
                        OR (MONTH = 12 AND DAY_OF_MONTH = 25)`; 
             
                 try {
                snowflake.execute (
                    {sqlText: sql}
                    );
                
                }
            catch (err)  {
                return "Failed: " + err;   // Return a success/error indicator.
                } 
            sql = `UPDATE HAH.DIM_DATE
                    SET Holiday_Flag = CAST( ''TRUE'' AS BOOLEAN)
                    WHERE (MONTH = 1 AND Day_Name = ''Mon'' AND Day_of_Month BETWEEN 15 AND 21)  -- Martin Luther King day
                    OR (MONTH = 2 AND Day_Name = ''Mon'' AND Day_of_Month BETWEEN 15 AND 21)  -- Presidents day
                    OR (MONTH = 5 AND Day_Name = ''Mon'' AND Day_of_Month BETWEEN 25 AND 31)  -- Memorial day
                    OR (MONTH = 9 AND Day_Name = ''Mon'' AND Day_of_Month BETWEEN 1 AND 7)    -- Labor day
                    OR (MONTH = 10 AND Day_Name = ''Mon'' AND Day_of_Month BETWEEN 8 AND 14)  -- Columbus day
                    OR (MONTH = 11 AND Day_Name = ''Thu'' AND Day_of_Month BETWEEN 22 AND 28) -- Thanksgiving day`;
                    
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