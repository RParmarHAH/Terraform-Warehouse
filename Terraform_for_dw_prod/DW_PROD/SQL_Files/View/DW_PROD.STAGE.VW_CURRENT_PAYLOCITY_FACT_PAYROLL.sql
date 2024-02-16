create or replace view DW_PROD.STAGE.VW_CURRENT_PAYLOCITY_FACT_PAYROLL(
	PAYROLL_KEY
) as (
SELECT 
	MD5(PSS.TRANSACTIONNUMBER || TRIM(PSS.EMPLOYEEID) || PSS.COMPANYID ||'PAYLOCITY') AS PAYROLL_KEY
FROM DISC_PROD.PAYLOCITY.PAY_STATEMENT_SUMMARY PSS 
);