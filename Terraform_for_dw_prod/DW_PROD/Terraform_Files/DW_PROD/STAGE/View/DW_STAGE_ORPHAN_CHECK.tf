resource "snowflake_view" "DW_STAGE_ORPHAN_CHECK" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "ORPHAN_CHECK"
	statement = <<-SQL
	 
select 'MATRIXCARE' AS SORCE, * FROM (
WITH INTAKECONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID = 7),
	INTAKECLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID = 7),
	INTAKEBRANCH  AS (SELECT DISTINCT BRANCH_KEY FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID = 7),
	VISITCONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=7),
	VISITCLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=7),
	VISITBRANCH AS (SELECT DISTINCT BRANCH_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=7),
	VISITEMPLOYEE AS (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=7),
	VISITSUPERVISOR AS (SELECT DISTINCT SUPERVISOR_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=7),
	REVENUEINVOICE AS (SELECT DISTINCT INVOICE_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=7),
	REVENUECLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=7),
	REVENUECONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=7),
	REVENUEBRANCH AS (SELECT DISTINCT BRANCH_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=7),
	REVENUEEMPLOYEE AS (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=7),
	REVENUESUPERVISOR AS (SELECT DISTINCT SUPERVISOR_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=7),
	CONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.DIM_CONTRACT WHERE SOURCE_SYSTEM_ID=7),
	BRANCH AS (SELECT DISTINCT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID=7),
	CLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.DIM_CLIENT WHERE SOURCE_SYSTEM_ID=7),
	INVOICE AS (SELECT DISTINCT INVOICE_KEY FROM HAH.DIM_INVOICE WHERE SOURCE_SYSTEM_ID=7),
	SUPERVISOR AS (SELECT DISTINCT SUPERVISOR_KEY FROM HAH.DIM_SUPERVISOR WHERE SOURCE_SYSTEM_ID=7),
	EMPLOYEE AS (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID=7)
	SELECT 'VISIT' FACT_NAME,'CLIENT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITCLIENT A
	LEFT JOIN CLIENT B ON A.CLIENT_KEY=B.CLIENT_KEY 
	WHERE B.CLIENT_KEY IS NULL
	UNION ALL
	SELECT 'INTAKE' FACT_NAME,'CLIENT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM INTAKECLIENT A
	LEFT JOIN CLIENT B ON A.CLIENT_KEY=B.CLIENT_KEY 
	WHERE B.CLIENT_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'CLIENT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUECLIENT A
	LEFT JOIN CLIENT B ON A.CLIENT_KEY=B.CLIENT_KEY 
	WHERE B.CLIENT_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME,'CONTRACT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITCONTRACT A
	LEFT JOIN CONTRACT B ON A.CONTRACT_KEY=B.CONTRACT_KEY 
	WHERE B.CONTRACT_KEY IS NULL
	UNION ALL
	SELECT 'INTAKE' FACT_NAME,'CONTRACT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM INTAKECONTRACT A
	LEFT JOIN CONTRACT B ON A.CONTRACT_KEY=B.CONTRACT_KEY 
	WHERE B.CONTRACT_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'CONTRACT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUECONTRACT A
	LEFT JOIN CONTRACT B ON A.CONTRACT_KEY=B.CONTRACT_KEY 
	WHERE B.CONTRACT_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME,'BRANCH' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITBRANCH A
	LEFT JOIN BRANCH B ON A.BRANCH_KEY=B.BRANCH_KEY 
	WHERE B.BRANCH_KEY IS NULL
	UNION ALL
	SELECT 'INTAKE' FACT_NAME,'BRANCH' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM INTAKEBRANCH A
	LEFT JOIN BRANCH B ON A.BRANCH_KEY=B.BRANCH_KEY 
	WHERE B.BRANCH_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'BRANCH' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUEBRANCH A
	LEFT JOIN BRANCH B ON A.BRANCH_KEY=B.BRANCH_KEY 
	WHERE B.BRANCH_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME,'EMPLOYEE' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITEMPLOYEE A
	LEFT JOIN EMPLOYEE B ON A.EMPLOYEE_KEY=B.EMPLOYEE_KEY 
	WHERE B.EMPLOYEE_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'EMPLOYEE' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUEEMPLOYEE A
	LEFT JOIN EMPLOYEE B ON A.EMPLOYEE_KEY=B.EMPLOYEE_KEY 
	WHERE B.EMPLOYEE_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME, 'SUPERVISOR' DIMENSION_NAME, COUNT(A.*) AS COUNTS FROM VISITSUPERVISOR A
	LEFT JOIN SUPERVISOR B ON A.SUPERVISOR_KEY=B.SUPERVISOR_KEY
	WHERE B.SUPERVISOR_KEY IS NULL 
	UNION ALL
	SELECT 'REVENUE' FACT_NAME, 'SUPERVISOR' DIMENSION_NAME, COUNT(A.*) AS COUNTS FROM REVENUESUPERVISOR A
	LEFT JOIN SUPERVISOR B ON A.SUPERVISOR_KEY=B.SUPERVISOR_KEY
	WHERE B.SUPERVISOR_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'INVOICE' DIMENSION_NAME, COUNT(A.*) AS COUNTS FROM REVENUEINVOICE A
	LEFT JOIN INVOICE B ON A.INVOICE_KEY=B.INVOICE_KEY
	WHERE B.INVOICE_KEY IS NULL )
   UNION ALL 
--SANDATA        
  select 'SANDATA' AS SORCE, * FROM (
WITH INTAKECONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID = 4),
	INTAKECLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID = 4),
	INTAKEBRANCH  AS (SELECT DISTINCT BRANCH_KEY FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID = 4),
	VISITCONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=4),
	VISITCLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=4),
	VISITBRANCH AS (SELECT DISTINCT BRANCH_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=4),
	VISITEMPLOYEE AS (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=4),
	VISITSUPERVISOR AS (SELECT DISTINCT SUPERVISOR_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=4),
	REVENUEINVOICE AS (SELECT DISTINCT INVOICE_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=4),
	REVENUECLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=4),
	REVENUECONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=4),
	REVENUEBRANCH AS (SELECT DISTINCT BRANCH_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=4),
	REVENUEEMPLOYEE AS (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=4),
	REVENUESUPERVISOR AS (SELECT DISTINCT SUPERVISOR_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=4),
	CONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.DIM_CONTRACT WHERE SOURCE_SYSTEM_ID=4),
	BRANCH AS (SELECT DISTINCT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID=4),
	CLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.DIM_CLIENT WHERE SOURCE_SYSTEM_ID=4),
	INVOICE AS (SELECT DISTINCT INVOICE_KEY FROM HAH.DIM_INVOICE WHERE SOURCE_SYSTEM_ID=4),
	SUPERVISOR AS (SELECT DISTINCT SUPERVISOR_KEY FROM HAH.DIM_SUPERVISOR WHERE SOURCE_SYSTEM_ID=4),
	EMPLOYEE AS (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID=4)
	SELECT 'VISIT' FACT_NAME,'CLIENT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITCLIENT A
	LEFT JOIN CLIENT B ON A.CLIENT_KEY=B.CLIENT_KEY 
	WHERE B.CLIENT_KEY IS NULL
	UNION ALL
	SELECT 'INTAKE' FACT_NAME,'CLIENT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM INTAKECLIENT A
	LEFT JOIN CLIENT B ON A.CLIENT_KEY=B.CLIENT_KEY 
	WHERE B.CLIENT_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'CLIENT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUECLIENT A
	LEFT JOIN CLIENT B ON A.CLIENT_KEY=B.CLIENT_KEY 
	WHERE B.CLIENT_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME,'CONTRACT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITCONTRACT A
	LEFT JOIN CONTRACT B ON A.CONTRACT_KEY=B.CONTRACT_KEY 
	WHERE B.CONTRACT_KEY IS NULL
	UNION ALL
	SELECT 'INTAKE' FACT_NAME,'CONTRACT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM INTAKECONTRACT A
	LEFT JOIN CONTRACT B ON A.CONTRACT_KEY=B.CONTRACT_KEY 
	WHERE B.CONTRACT_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'CONTRACT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUECONTRACT A
	LEFT JOIN CONTRACT B ON A.CONTRACT_KEY=B.CONTRACT_KEY 
	WHERE B.CONTRACT_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME,'BRANCH' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITBRANCH A
	LEFT JOIN BRANCH B ON A.BRANCH_KEY=B.BRANCH_KEY 
	WHERE B.BRANCH_KEY IS NULL
	UNION ALL
	SELECT 'INTAKE' FACT_NAME,'BRANCH' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM INTAKEBRANCH A
	LEFT JOIN BRANCH B ON A.BRANCH_KEY=B.BRANCH_KEY 
	WHERE B.BRANCH_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'BRANCH' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUEBRANCH A
	LEFT JOIN BRANCH B ON A.BRANCH_KEY=B.BRANCH_KEY 
	WHERE B.BRANCH_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME,'EMPLOYEE' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITEMPLOYEE A
	LEFT JOIN EMPLOYEE B ON A.EMPLOYEE_KEY=B.EMPLOYEE_KEY 
	WHERE B.EMPLOYEE_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'EMPLOYEE' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUEEMPLOYEE A
	LEFT JOIN EMPLOYEE B ON A.EMPLOYEE_KEY=B.EMPLOYEE_KEY 
	WHERE B.EMPLOYEE_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME, 'SUPERVISOR' DIMENSION_NAME, COUNT(A.*) AS COUNTS FROM VISITSUPERVISOR A
	LEFT JOIN SUPERVISOR B ON A.SUPERVISOR_KEY=B.SUPERVISOR_KEY
	WHERE B.SUPERVISOR_KEY IS NULL 
	UNION ALL
	SELECT 'REVENUE' FACT_NAME, 'SUPERVISOR' DIMENSION_NAME, COUNT(A.*) AS COUNTS FROM REVENUESUPERVISOR A
	LEFT JOIN SUPERVISOR B ON A.SUPERVISOR_KEY=B.SUPERVISOR_KEY
	WHERE B.SUPERVISOR_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'INVOICE' DIMENSION_NAME, COUNT(A.*) AS COUNTS FROM REVENUEINVOICE A
	LEFT JOIN INVOICE B ON A.INVOICE_KEY=B.INVOICE_KEY
	WHERE B.INVOICE_KEY IS NULL ) 
UNION ALL 
--COSTAL
select 'COSTAL' AS SORCE, * FROM (
WITH INTAKECONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID IN (1,2)),
	INTAKECLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID IN (1,2)),
	INTAKEBRANCH  AS (SELECT DISTINCT BRANCH_KEY FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID IN (1,2)),
	VISITCONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID IN (1,2)),
	VISITCLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID IN (1,2)),
	VISITBRANCH AS (SELECT DISTINCT BRANCH_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID IN (1,2)),
	VISITEMPLOYEE AS (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID IN (1,2)),
	VISITSUPERVISOR AS (SELECT DISTINCT SUPERVISOR_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID IN (1,2)),
	REVENUEINVOICE AS (SELECT DISTINCT INVOICE_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID IN (1,2)),
	REVENUECLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID IN (1,2)),
	REVENUECONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID IN (1,2)),
	REVENUEBRANCH AS (SELECT DISTINCT BRANCH_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID IN (1,2)),
	REVENUEEMPLOYEE AS (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID IN (1,2)),
	REVENUESUPERVISOR AS (SELECT DISTINCT SUPERVISOR_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID IN (1,2)),
	CONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.DIM_CONTRACT WHERE SOURCE_SYSTEM_ID IN (1,2)),
	BRANCH AS (SELECT DISTINCT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID IN (1,2)),
	CLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.DIM_CLIENT WHERE SOURCE_SYSTEM_ID IN (1,2)),
	INVOICE AS (SELECT DISTINCT INVOICE_KEY FROM HAH.DIM_INVOICE WHERE SOURCE_SYSTEM_ID IN (1,2)),
	SUPERVISOR AS (SELECT DISTINCT SUPERVISOR_KEY FROM HAH.DIM_SUPERVISOR WHERE SOURCE_SYSTEM_ID IN (1,2)),
	EMPLOYEE AS (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID IN (1,2))
	SELECT 'VISIT' FACT_NAME,'CLIENT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITCLIENT A
	LEFT JOIN CLIENT B ON A.CLIENT_KEY=B.CLIENT_KEY 
	WHERE B.CLIENT_KEY IS NULL
	UNION ALL
	SELECT 'INTAKE' FACT_NAME,'CLIENT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM INTAKECLIENT A
	LEFT JOIN CLIENT B ON A.CLIENT_KEY=B.CLIENT_KEY 
	WHERE B.CLIENT_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'CLIENT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUECLIENT A
	LEFT JOIN CLIENT B ON A.CLIENT_KEY=B.CLIENT_KEY 
	WHERE B.CLIENT_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME,'CONTRACT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITCONTRACT A
	LEFT JOIN CONTRACT B ON A.CONTRACT_KEY=B.CONTRACT_KEY 
	WHERE B.CONTRACT_KEY IS NULL
	UNION ALL
	SELECT 'INTAKE' FACT_NAME,'CONTRACT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM INTAKECONTRACT A
	LEFT JOIN CONTRACT B ON A.CONTRACT_KEY=B.CONTRACT_KEY 
	WHERE B.CONTRACT_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'CONTRACT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUECONTRACT A
	LEFT JOIN CONTRACT B ON A.CONTRACT_KEY=B.CONTRACT_KEY 
	WHERE B.CONTRACT_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME,'BRANCH' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITBRANCH A
	LEFT JOIN BRANCH B ON A.BRANCH_KEY=B.BRANCH_KEY 
	WHERE B.BRANCH_KEY IS NULL
	UNION ALL
	SELECT 'INTAKE' FACT_NAME,'BRANCH' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM INTAKEBRANCH A
	LEFT JOIN BRANCH B ON A.BRANCH_KEY=B.BRANCH_KEY 
	WHERE B.BRANCH_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'BRANCH' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUEBRANCH A
	LEFT JOIN BRANCH B ON A.BRANCH_KEY=B.BRANCH_KEY 
	WHERE B.BRANCH_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME,'EMPLOYEE' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITEMPLOYEE A
	LEFT JOIN EMPLOYEE B ON A.EMPLOYEE_KEY=B.EMPLOYEE_KEY 
	WHERE B.EMPLOYEE_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'EMPLOYEE' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUEEMPLOYEE A
	LEFT JOIN EMPLOYEE B ON A.EMPLOYEE_KEY=B.EMPLOYEE_KEY 
	WHERE B.EMPLOYEE_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME, 'SUPERVISOR' DIMENSION_NAME, COUNT(A.*) AS COUNTS FROM VISITSUPERVISOR A
	LEFT JOIN SUPERVISOR B ON A.SUPERVISOR_KEY=B.SUPERVISOR_KEY
	WHERE B.SUPERVISOR_KEY IS NULL 
	UNION ALL
	SELECT 'REVENUE' FACT_NAME, 'SUPERVISOR' DIMENSION_NAME, COUNT(A.*) AS COUNTS FROM REVENUESUPERVISOR A
	LEFT JOIN SUPERVISOR B ON A.SUPERVISOR_KEY=B.SUPERVISOR_KEY
	WHERE B.SUPERVISOR_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'INVOICE' DIMENSION_NAME, COUNT(A.*) AS COUNTS FROM REVENUEINVOICE A
	LEFT JOIN INVOICE B ON A.INVOICE_KEY=B.INVOICE_KEY
	WHERE B.INVOICE_KEY IS NULL )
UNION ALL   
 --DATAFLEX
select 'DATAFLEX' AS SORCE, * FROM (
WITH INTAKECONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID = 3),
	INTAKECLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID = 3),
	INTAKEBRANCH  AS (SELECT DISTINCT BRANCH_KEY FROM HAH.FACT_INTAKE WHERE SOURCE_SYSTEM_ID = 3),
	VISITCONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=3),
	VISITCLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=3),
	VISITBRANCH AS (SELECT DISTINCT BRANCH_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=3),
	VISITEMPLOYEE AS (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=3),
	VISITSUPERVISOR AS (SELECT DISTINCT SUPERVISOR_KEY FROM HAH.FACT_VISIT WHERE SOURCE_SYSTEM_ID=3),
	REVENUEINVOICE AS (SELECT DISTINCT INVOICE_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=3),
	REVENUECLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=3),
	REVENUECONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=3),
	REVENUEBRANCH AS (SELECT DISTINCT BRANCH_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=3),
	REVENUEEMPLOYEE AS (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=3),
	REVENUESUPERVISOR AS (SELECT DISTINCT SUPERVISOR_KEY FROM HAH.FACT_REVENUE WHERE SOURCE_SYSTEM_ID=3),
	CONTRACT AS (SELECT DISTINCT CONTRACT_KEY FROM HAH.DIM_CONTRACT WHERE SOURCE_SYSTEM_ID=3),
	BRANCH AS (SELECT DISTINCT BRANCH_KEY FROM HAH.DIM_BRANCH WHERE SOURCE_SYSTEM_ID=3),
	CLIENT AS (SELECT DISTINCT CLIENT_KEY FROM HAH.DIM_CLIENT WHERE SOURCE_SYSTEM_ID=3),
	INVOICE AS (SELECT DISTINCT INVOICE_KEY FROM HAH.DIM_INVOICE WHERE SOURCE_SYSTEM_ID=3),
	SUPERVISOR AS (SELECT DISTINCT SUPERVISOR_KEY FROM HAH.DIM_SUPERVISOR WHERE SOURCE_SYSTEM_ID=3),
	EMPLOYEE AS (SELECT DISTINCT EMPLOYEE_KEY FROM HAH.DIM_EMPLOYEE WHERE SOURCE_SYSTEM_ID=3)
	SELECT 'VISIT' FACT_NAME,'CLIENT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITCLIENT A
	LEFT JOIN CLIENT B ON A.CLIENT_KEY=B.CLIENT_KEY 
	WHERE B.CLIENT_KEY IS NULL
	UNION ALL
	SELECT 'INTAKE' FACT_NAME,'CLIENT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM INTAKECLIENT A
	LEFT JOIN CLIENT B ON A.CLIENT_KEY=B.CLIENT_KEY 
	WHERE B.CLIENT_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'CLIENT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUECLIENT A
	LEFT JOIN CLIENT B ON A.CLIENT_KEY=B.CLIENT_KEY 
	WHERE B.CLIENT_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME,'CONTRACT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITCONTRACT A
	LEFT JOIN CONTRACT B ON A.CONTRACT_KEY=B.CONTRACT_KEY 
	WHERE B.CONTRACT_KEY IS NULL
	UNION ALL
	SELECT 'INTAKE' FACT_NAME,'CONTRACT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM INTAKECONTRACT A
	LEFT JOIN CONTRACT B ON A.CONTRACT_KEY=B.CONTRACT_KEY 
	WHERE B.CONTRACT_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'CONTRACT' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUECONTRACT A
	LEFT JOIN CONTRACT B ON A.CONTRACT_KEY=B.CONTRACT_KEY 
	WHERE B.CONTRACT_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME,'BRANCH' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITBRANCH A
	LEFT JOIN BRANCH B ON A.BRANCH_KEY=B.BRANCH_KEY 
	WHERE B.BRANCH_KEY IS NULL
	UNION ALL
	SELECT 'INTAKE' FACT_NAME,'BRANCH' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM INTAKEBRANCH A
	LEFT JOIN BRANCH B ON A.BRANCH_KEY=B.BRANCH_KEY 
	WHERE B.BRANCH_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'BRANCH' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUEBRANCH A
	LEFT JOIN BRANCH B ON A.BRANCH_KEY=B.BRANCH_KEY 
	WHERE B.BRANCH_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME,'EMPLOYEE' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM VISITEMPLOYEE A
	LEFT JOIN EMPLOYEE B ON A.EMPLOYEE_KEY=B.EMPLOYEE_KEY 
	WHERE B.EMPLOYEE_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'EMPLOYEE' DIMENSION_NAME,COUNT(A.*) AS COUNTS FROM REVENUEEMPLOYEE A
	LEFT JOIN EMPLOYEE B ON A.EMPLOYEE_KEY=B.EMPLOYEE_KEY 
	WHERE B.EMPLOYEE_KEY IS NULL
	UNION ALL
	SELECT 'VISIT' FACT_NAME, 'SUPERVISOR' DIMENSION_NAME, COUNT(A.*) AS COUNTS FROM VISITSUPERVISOR A
	LEFT JOIN SUPERVISOR B ON A.SUPERVISOR_KEY=B.SUPERVISOR_KEY
	WHERE B.SUPERVISOR_KEY IS NULL 
	UNION ALL
	SELECT 'REVENUE' FACT_NAME, 'SUPERVISOR' DIMENSION_NAME, COUNT(A.*) AS COUNTS FROM REVENUESUPERVISOR A
	LEFT JOIN SUPERVISOR B ON A.SUPERVISOR_KEY=B.SUPERVISOR_KEY
	WHERE B.SUPERVISOR_KEY IS NULL
	UNION ALL
	SELECT 'REVENUE' FACT_NAME,'INVOICE' DIMENSION_NAME, COUNT(A.*) AS COUNTS FROM REVENUEINVOICE A
	LEFT JOIN INVOICE B ON A.INVOICE_KEY=B.INVOICE_KEY
	WHERE B.INVOICE_KEY IS NULL );
SQL
	or_replace = true 
	is_secure = false 
}

