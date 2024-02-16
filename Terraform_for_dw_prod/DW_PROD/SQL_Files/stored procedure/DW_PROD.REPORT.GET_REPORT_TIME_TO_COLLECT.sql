CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_TIME_TO_COLLECT("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN
        INSERT OVERWRITE INTO REPORT.TIME_TO_COLLECT
    with inv_init as (
        SELECT  f.BRANCH_KEY,
                f.CLIENT_KEY,
                f.CONTRACT_KEY,
                f.INVOICE_KEY,
                f.SOURCE_SYSTEM_ID ,
                f.ORIGINAL_SOURCE_SYSTEM_ID ,
                COALESCE(i.BILL_REPRESENTATIVE,''Unknown'') AS BILL_REPRESENTATIVE,
                MIN (f.REPORT_DATE) AS SERVICE_DATE,
                MIN (CASE WHEN f.REVENUE_DATE > f.PAYMENT_DATE THEN f.REPORT_DATE ELSE f.REVENUE_DATE END) AS REVENUE_DATE,
                MAX(f.PAYMENT_DATE) AS TRUE_PAYMENT_DATE,
                COALESCE(MAX(f.PAYMENT_DATE), last_day(CURRENT_DATE (), ''month'')) AS PAYMENT_DATE
        FROM INTEGRATION.FACT_REVENUE_MERGED f
        LEFT JOIN HAH.DIM_INVOICE i
            on f.INVOICE_KEY = i.INVOICE_KEY
       -- WHERE f.CLIENT_KEY IN (''23570a6c096ec79d1cd5f7f8ccd82021'')--, ''23570a6c096ec79d1cd5f7f8ccd82021'')
             --CONTRACT_KEY = ''05a56f139b9403a70c8f0a2322ddb4e9''
             --f.INVOICE_KEY = ''0f52916ce544f620b436327e6e2b76f2''
        GROUP BY 1, 2, 3, 4, 5,6,7
    ),
    no_outliers as (
        SELECT  f.BRANCH_KEY,
                f.CLIENT_KEY,
                f.CONTRACT_KEY,
                f.SOURCE_SYSTEM_ID ,
                f.ORIGINAL_SOURCE_SYSTEM_ID ,
                f.INVOICE_KEY,
                f.BILL_REPRESENTATIVE,
                f.SERVICE_DATE,
                f.REVENUE_DATE,
                f.TRUE_PAYMENT_DATE,
                f.PAYMENT_DATE,
                datediff(''day'', SERVICE_DATE, REVENUE_DATE) AS TTI,
                datediff(''day'', REVENUE_DATE, TRUE_PAYMENT_DATE) AS TTC
        from inv_init f
        WHERE ((COALESCE(TTI,-1) BETWEEN 0 AND 500)
          AND (COALESCE(TTC,-1) BETWEEN 0 AND 500)) OR TTC is null
        )
    select last_day(SERVICE_DATE, ''month'') AS REPORT_DATE,
           BRANCH_KEY,
           CLIENT_KEY,
           CONTRACT_KEY,
           SOURCE_SYSTEM_ID ,
           ORIGINAL_SOURCE_SYSTEM_ID ,
           BILL_REPRESENTATIVE,
           AVG(TTI) AS AVERAGE_TIME_SERVICE_TO_INVOICE,
           AVG(TTC) AS AVERAGE_TIME_INVOICE_TO_COLLECT,
           AVERAGE_TIME_SERVICE_TO_INVOICE + AVERAGE_TIME_INVOICE_TO_COLLECT AS AVERAGE_TIME_SERVICE_TO_COLLECT,
		   :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		   :STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
           convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
            CURRENT_USER as ETL_INSERTED_BY ,
            convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
            CURRENT_USER as ETL_LAST_UPDATED_BY,
            0 as ETL_DELETED_FLAG,
            0 as ETL_INFERRED_MEMBER_FLAG
    from no_outliers
    GROUP BY 1,2,3,4,5,6,7;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';