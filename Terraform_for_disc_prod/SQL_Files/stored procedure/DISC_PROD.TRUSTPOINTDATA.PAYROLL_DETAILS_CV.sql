CREATE OR REPLACE PROCEDURE DISC_PROD.TRUSTPOINTDATA.PAYROLL_DETAILS_CV("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
CREATE OR REPLACE TABLE DISC_PROD.TRUSTPOINTDATA.Payroll_Details as WITH curr_v AS ( 
  SELECT COMPANY, RECORD_TYPE, PAYROLL_DATE, CHECK_NUMBER, PAY_CODE, MAX(ETL_LAST_UPDATED_DATE) AS MAX_LAST_UPDATED_DATE   
  FROM DISC_PROD.TRUSTPOINTDATA.HIST_Payroll_Details GROUP BY COMPANY, RECORD_TYPE, PAYROLL_DATE, CHECK_NUMBER, PAY_CODE)  
  SELECT t.* FROM DISC_PROD.TRUSTPOINTDATA.HIST_Payroll_Details t   INNER JOIN curr_v v ON t.COMPANY = v.COMPANY   
  AND t.RECORD_TYPE = v.RECORD_TYPE AND t.PAYROLL_DATE = v.PAYROLL_DATE   AND t.CHECK_NUMBER = v.CHECK_NUMBER AND t.PAY_CODE = v.PAY_CODE  
  AND t.ETL_DELETED_FLAG = FALSE   AND t.ETL_LAST_UPDATED_DATE = v.MAX_LAST_UPDATED_DATE;
   ';