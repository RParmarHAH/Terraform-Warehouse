CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_ACCOUNTS_RECEIVABLE_AGING("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN

    INSERT OVERWRITE INTO REPORT.ACCOUNTS_RECEIVABLE_AGING
with inv as (
           SELECT f.BRANCH_KEY,
           		f.ORIGINAL_BRANCH_KEY ,
           		f.ORIGINAL_CLIENT_KEY ,
           		f.CLIENT_KEY,
           		 f.CONTRACT_KEY,
                  f.SOURCE_SYSTEM_ID ,
                  f.ORIGINAL_SOURCE_SYSTEM_ID ,
                  coalesce(i.BILL_REPRESENTATIVE, ''Unknown'') AS BILL_REPRESENTATIVE,
                  f.INVOICE_KEY,
                  datediff(''day'', MIN(REVENUE_DATE), CURRENT_DATE()) AS INVOICE_AGE,
                    CASE
                        WHEN INVOICE_AGE <= 30 THEN ''0-30''
                        WHEN INVOICE_AGE > 30 AND INVOICE_AGE <= 60 THEN ''31-60''
                        WHEN INVOICE_AGE > 60 AND INVOICE_AGE <= 90 THEN ''61-90''
                        WHEN INVOICE_AGE > 90 AND INVOICE_AGE <= 120 THEN ''91-120''
                        WHEN INVOICE_AGE > 120 AND INVOICE_AGE <= 150 THEN ''121-150''
                        WHEN INVOICE_AGE > 150 AND INVOICE_AGE <= 180 THEN ''151-180''
                        WHEN INVOICE_AGE > 180 THEN ''180+''
                    ELSE NULL END AS AR_AGING_BUCKET,
                    CASE
                        WHEN INVOICE_AGE <= 30 THEN 1
                        WHEN INVOICE_AGE > 30 AND INVOICE_AGE <= 60 THEN 2
                        WHEN INVOICE_AGE > 60 AND INVOICE_AGE <= 90 THEN 3
                        WHEN INVOICE_AGE > 90 AND INVOICE_AGE <= 120 THEN 4
                        WHEN INVOICE_AGE > 120 AND INVOICE_AGE <= 150 THEN 5
                        WHEN INVOICE_AGE > 150 AND INVOICE_AGE <= 180 THEN 6
                        WHEN INVOICE_AGE > 180 THEN 7
                       ELSE NULL END AS AR_AGING_BUCKET_SORT,
                  SUM(f.AMOUNT_BILLED) AS AMOUNT_BILLED,
                  SUM(f.AMOUNT_COLLECTED) AS AMOUNT_COLLECTED
           FROM INTEGRATION.FACT_REVENUE_MERGED f
            LEFT JOIN HAH.DIM_INVOICE i
                      on f.INVOICE_KEY = i.INVOICE_KEY
           LEFT JOIN INTEGRATION.DIM_BRANCH_MERGED b
            ON f.BRANCH_KEY = b.BRANCH_KEY
           WHERE REVENUE_DATE BETWEEN ((YEAR(CURRENT_DATE) - 2) || ''-01-01'')::date AND last_day(DATEADD(month, -1, CURRENT_DATE()), ''month'')
           --where  OFFICE_STATE_CODE = ''IL''
           GROUP BY 1, 2, 3, 4, 5,6,7,8 ,9 
)
  SELECT    last_day(DATEADD(month, -1, CURRENT_DATE()), ''month'') as REPORT_DATE,
            i.BRANCH_KEY,
            i.CLIENT_KEY,
            i.SOURCE_SYSTEM_ID ,
            i.ORIGINAL_SOURCE_SYSTEM_ID ,
            i.CONTRACT_KEY,
            BILL_REPRESENTATIVE,
            AR_AGING_BUCKET,
            AR_AGING_BUCKET_SORT,
            SUM(AMOUNT_BILLED) AS BUCKET_AMOUNT_BILLED,
            SUM(AMOUNT_COLLECTED) AS BUCKET_AMOUNT_COLLECTED,
            BUCKET_AMOUNT_BILLED - BUCKET_AMOUNT_COLLECTED AS BUCKET_AMOUNT_OUTSTANDING,
            :STR_ETL_TASK_KEY AS ETL_TASK_KEY,
			:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
			convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
            CURRENT_USER as ETL_INSERTED_BY ,
            convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
            CURRENT_USER as ETL_LAST_UPDATED_BY,
            0 as ETL_DELETED_FLAG,
            0 as ETL_INFERRED_MEMBER_FLAG
        FROM inv i
        group by 1,2,3,4,5,6,7,8,9;

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';