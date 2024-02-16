CREATE OR REPLACE PROCEDURE DW_PROD.REPORT.GET_REPORT_OVERTIME("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
DECLARE
    return_result VARCHAR;
BEGIN

    --*****************************************************************************************************************************
-- NAME:  Report_Overtime
--
-- PURPOSE: Creates overtime data set in the reporting layer for operations dashboard
--
-- NOTE: This logic removes admin personnel and excludes Community Living (CLS) and Behavior Health (BH)
--       Data is currently limited to 11/1/2019 and forward
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------
-- 02/18/20    Mohd		               Initial development
-- 03/05/20    Frank Noordover       Revised logic to remove admin personnel and exclude CLS and BH
-- 04/20/20   Rachel Stewart         Added date filter for service > DEC 2019 and formatted select
-- 06/19/20   Devansh Patel          Revised logic to divide payroll service hours by service month based on visit hours served ratio
-- 01/24/23    Mohit Vaghadiya       Wrapped the Employee Category condition w/ UPPER
--*****************************************************************************************************************************
--
INSERT OVERWRITE INTO REPORT.OVERTIME
WITH master_emp AS (
    SELECT otr.EMPLOYEE_KEY AS otr_employee_key, gp.*
    FROM HAH.DIM_EMPLOYEE gp
    LEFT JOIN HAH.DIM_EMPLOYEE otr ON gp.EMPLOYEE_PID = otr.EMPLOYEE_PID
        AND otr.SOURCE_SYSTEM_ID <> 5
    WHERE gp.SOURCE_SYSTEM_ID = 5
    -- AND gp.Field_Worker_Flag = ''TRUE''
    AND UPPER(gp.EMPLOYEE_CATEGORY) = ''FIELD''
    )
SELECT DISTINCT emp.EMPLOYEE_LAST_NAME
     , emp.EMPLOYEE_FIRST_NAME
     , emp.EMPLOYEE_KEY
     , emp.PRIMARY_BRANCH_NAME
     , pay.PAYROLL_DATE
     , pay.PAY_HOURS as payroll_hours
     , DIV0(pay.SERVICE_HOURS , (SUM(vis.HOURS_SERVED) OVER (PARTITION BY vis.CLIENT_NUMBER,vis.BRANCH_NAME,date_trunc(''month'',pay.PAYROLL_DATE)))  
     * (SUM(vis.HOURS_SERVED) OVER (PARTITION BY vis.SUPERVISOR_KEY,vis.SUPERVISOR_CODE
        , vis.CLIENT_NUMBER, vis.BRANCH_NAME, vis.CONTRACT_CODE, CHECK_NUMBER, date_trunc(''month'', vis.SERVICE_DATE)))) as payroll_service_hours
     , pay.OVERTIME_HOURS as payroll_overtime_hours
     , pay.NON_SERVICE_UNITS as payroll_non_service_units
     , pay.PAY_RATE
     , pay.PAY_PERIOD_START_DATE
     , pay.PAY_PERIOD_END_DATE
     , pay.CHECK_NUMBER
     , vis.SUPERVISOR_KEY
     ,vis.SUPERVISOR_CODE
     , vis.CLIENT_NUMBER
     , vis.BRANCH_NAME
     , vis.contract_key
     , date_trunc(''month'', vis.SERVICE_DATE) as service_month
     , SUM(vis.HOURS_SERVED) OVER (PARTITION BY vis.SUPERVISOR_KEY,vis.SUPERVISOR_CODE, vis.CLIENT_NUMBER
         , vis.BRANCH_NAME, vis.CONTRACT_CODE, CHECK_NUMBER, date_trunc(''month'', vis.SERVICE_DATE)) AS hours_served
     , IFF(pay.SERVICE_HOURS > 0, (SUM(vis.HOURS_SERVED) OVER (PARTITION BY vis.SUPERVISOR_KEY,vis.SUPERVISOR_CODE
            , vis.CLIENT_NUMBER, vis.BRANCH_NAME, vis.CONTRACT_CODE, CHECK_NUMBER, date_trunc(''month'', vis.SERVICE_DATE)
         )) / pay.SERVICE_HOURS , 0) as overtime_ratio
     , IFF(pay.SERVICE_HOURS > 0, (SUM(vis.HOURS_SERVED) OVER (PARTITION BY vis.SUPERVISOR_KEY,vis.SUPERVISOR_CODE
            , vis.CLIENT_NUMBER, vis.BRANCH_NAME, vis.CONTRACT_CODE, CHECK_NUMBER, date_trunc(''month'', vis.SERVICE_DATE)
         )) / pay.SERVICE_HOURS * pay.OVERTIME_HOURS, 0) as overtime_hours
    , emp.otr_employee_key
    ,vis.BRANCH_KEY,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_INSERTED_DATE,
    CURRENT_USER as ETL_INSERTED_BY ,
    convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz as ETL_LAST_UPDATED_DATE,
    CURRENT_USER as ETL_LAST_UPDATED_BY,
    0 as ETL_DELETED_FLAG,
    0 as ETL_INFERRED_MEMBER_FLAG
FROM master_emp emp
 JOIN HAH.FACT_PAYROLL pay ON emp.EMPLOYEE_KEY = pay.EMPLOYEE_KEY
 JOIN HAH.FACT_VISIT vis ON emp.otr_employee_key = vis.EMPLOYEE_KEY
    AND vis.SERVICE_DATE >= pay.PAY_PERIOD_START_DATE
    AND vis.SERVICE_DATE <= pay.PAY_PERIOD_END_DATE
 JOIN HAH.DIM_CONTRACT ctrct ON ctrct.Contract_Key = vis.Contract_Key
    AND IFNULL( ctrct.REVENUE_CATEGORY, ''DummyValue'') <> ''CLS'' AND IFNULL( ctrct.PAYOR_CODE, ''DummyValue'') <> ''BH''
    WHERE service_date >= ''2019-12-01'';

SELECT CONCAT(''Message : '',"number of rows inserted",'' Rows Inserted.'') into :return_result FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));

return return_result;
END;

';