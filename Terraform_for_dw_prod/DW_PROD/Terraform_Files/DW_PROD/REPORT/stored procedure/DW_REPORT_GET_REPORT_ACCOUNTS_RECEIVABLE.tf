resource "snowflake_procedure" "DW_REPORT_GET_REPORT_ACCOUNTS_RECEIVABLE" {
	name ="GET_REPORT_ACCOUNTS_RECEIVABLE"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	language  = "SQL"

	arguments {
		name = "STR_ETL_TASK_KEY"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_START"
		type = "VARCHAR(16777216)"
}	

	arguments {
		name = "STR_CDC_END"
		type = "VARCHAR(16777216)"
}	
	return_type = "VARCHAR(16777216)"
	execute_as = "OWNER"
	statement = <<-EOT

DECLARE
    return_result VARCHAR;
BEGIN

    INSERT OVERWRITE INTO REPORT.ACCOUNTS_RECEIVABLE
    WITH sn_date as
        (
            SELECT DISTINCT last_day(CALENDAR_DATE, ''month'') AS REPORT_DATE,
                            ((YEAR(CALENDAR_DATE) - 2) || ''-01-01'')::date AS AR_Range
            FROM HAH.DIM_DATE
            WHERE CALENDAR_DATE >= ''2019-01-01'' AND CALENDAR_DATE < DATEADD(month,-1,CURRENT_DATE())
        ),
    report_keys as (
        select DISTINCT
               d.REPORT_DATE,
               d.AR_Range,
               f.BRANCH_KEY,
               f.CLIENT_KEY,
               f.CONTRACT_KEY,
               coalesce(i.BILL_REPRESENTATIVE,''Unknown'') AS BILL_REPRESENTATIVE
        from sn_date d
        LEFT join HAH.FACT_INVOICE_CREDITS f
            ON f.REPORT_DATE >= d.AR_Range
                AND f.REPORT_DATE <= d.REPORT_DATE
                AND f.CREDIT_TYPE NOT IN (''Write Off'', ''Co-Pay Payment'') --AND f.INVOICE_TYPE = ''Lump Sum''
        LEFT JOIN HAH.DIM_INVOICE i
            on f.INVOICE_KEY = i.INVOICE_KEY
        ) ,
    agg as (
        SELECT ic.REPORT_DATE, --Service Date
               ic.BRANCH_KEY,
               ic.CLIENT_KEY,
               ic.CONTRACT_KEY,
               coalesce(i.BILL_REPRESENTATIVE,''Unknown'') AS BILL_REPRESENTATIVE,
               NVL(i.AMOUNT_BILLED * ic.IC_RATIO, 0) AS AMOUNT_BILLED,
               NVL(IC.CREDIT_AMOUNT, 0) AS AMOUNT_COLLECTED,
               NVL(i.AMOUNT_OUTSTANDING * ic.IC_RATIO, 0) AS AMOUNT_OUTSTANDING
        FROM (
        	SELECT INVOICE_KEY, LAST_DAY(REPORT_DATE, MONTH) AS REPORT_DATE, BRANCH_KEY, CLIENT_KEY, CONTRACT_KEY,
        		SUM(CREDIT_AMOUNT) AS CREDIT_AMOUNT,
        		IFF(SUM(SUM(CREDIT_AMOUNT)) OVER (PARTITION BY INVOICE_KEY) = 0, 0, 
        			SUM(CREDIT_AMOUNT) / SUM(SUM(CREDIT_AMOUNT)) OVER (PARTITION BY INVOICE_KEY)) AS IC_RATIO
        	FROM HAH.FACT_INVOICE_CREDITS
        	WHERE CREDIT_TYPE NOT IN (''Write Off'', ''Co-Pay Payment'') --AND INVOICE_TYPE = ''Lump Sum''
        	GROUP BY INVOICE_KEY, LAST_DAY(REPORT_DATE, MONTH), BRANCH_KEY, CLIENT_KEY, CONTRACT_KEY
        ) ic
        LEFT JOIN HAH.DIM_INVOICE i
            on i.INVOICE_KEY = ic.INVOICE_KEY
    ),
    final as (
    SELECT d.REPORT_DATE, --Uses service date
           d.BRANCH_KEY,
           d.CLIENT_KEY,
           d.CONTRACT_KEY,
           d.BILL_REPRESENTATIVE,
           SUM(COALESCE(f.AMOUNT_BILLED,0)) AS AMOUNT_BILLED,
           SUM(COALESCE(f.AMOUNT_COLLECTED,0)) AS AMOUNT_COLLECTED,
           SUM(COALESCE(f.AMOUNT_OUTSTANDING,0)) AS AMOUNT_OUTSTANDING
    FROM report_keys d
    LEFT join agg f
          on d.BRANCH_KEY = f.BRANCH_KEY
            and d.CONTRACT_KEY = f.CONTRACT_KEY
            and d.CLIENT_KEY = f.CLIENT_KEY
            and d.BILL_REPRESENTATIVE = f.BILL_REPRESENTATIVE
            and f.REPORT_DATE >= d.AR_Range AND f.REPORT_DATE <= d.REPORT_DATE
    GROUP BY 1,2,3,4,5
    )
    select d.REPORT_DATE,
		--f.REPORT_DATE as prev,
		d.BRANCH_KEY,
		d.CLIENT_KEY,
		d.CONTRACT_KEY,
		d.BILL_REPRESENTATIVE,
		d.AMOUNT_OUTSTANDING AS MONTHLY_AMOUNT_OUTSTANDING,
		d.AMOUNT_OUTSTANDING AS ACCOUNTS_RECEIVABLE,
		d.AMOUNT_BILLED AS MONTHLY_AMOUNT_BILLED,
		d.AMOUNT_COLLECTED AS MONTHLY_AMOUNT_COLLECTED,
		d.AMOUNT_OUTSTANDING AS CURRENT_ACCOUNT_RECEIVABLE,
		--f.AMOUNT_BILLED,
		--dte.day_cnt,
		COALESCE(f.AMOUNT_BILLED,0) / dte.day_cnt AS CURRENT_REVENUE_PER_DAY,
		CURRENT_ACCOUNT_RECEIVABLE / NULLIF(CURRENT_REVENUE_PER_DAY, 0) AS ROW_LEVEL_DSO,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
		CURRENT_USER as ETL_INSERTED_BY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
		CURRENT_USER as ETL_LAST_UPDATED_BY,
		0 as ETL_DELETED_FLAG,
		0 as ETL_INFERRED_MEMBER_FLAG
    from final d
    LEFT join agg f
          on d.BRANCH_KEY = f.BRANCH_KEY
            and d.CONTRACT_KEY = f.CONTRACT_KEY
            and d.CLIENT_KEY = f.CLIENT_KEY
            and d.BILL_REPRESENTATIVE = f.BILL_REPRESENTATIVE
            and d.REPORT_DATE = last_day(DATEADD(''month'',1, f.REPORT_DATE))
     LEFT JOIN (SELECT last_day(CALENDAR_DATE, ''month'') AS CALENDAR_DATE, count(1) as day_cnt
                FROM HAH.DIM_DATE
                GROUP BY 1) dte
               on d.REPORT_DATE = dte.CALENDAR_DATE;
               

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;


 EOT
}

