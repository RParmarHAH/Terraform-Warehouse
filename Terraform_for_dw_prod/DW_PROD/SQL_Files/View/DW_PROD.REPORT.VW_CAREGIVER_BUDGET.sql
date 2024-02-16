create or replace view DW_PROD.REPORT.VW_CAREGIVER_BUDGET(
	BUDGET_MONTH,
	STATE_CODE,
	BRANCH_KEY,
	BRANCH_NAME,
	BUDGETED_HOURS,
	BUDGETED_CLIENTS,
	HOURS_SERVED_TO_CAREGIVER_RATIO,
	CLIENT_TO_CAREGIVER_RATIO,
	CAREGIVER_BUDGET
) as
SELECT CAST( REPLACE( t.$1, '0:00') AS DATE) AS Budget_Month,
       t.$2 AS State_Code,
       t.$4 AS Branch_Key,
       t.$3 AS Branch_Name,
       CAST( t.$5 AS DECIMAL(10,2)) AS Budgeted_Hours,
       CAST( t.$6 AS INTEGER) AS Budgeted_Clients,
       CAST( t.$7 AS DECIMAL(20,10)) AS Hours_Served_to_Caregiver_Ratio,
       CAST( t.$8 AS DECIMAL(20,10))  AS Client_to_Caregiver_Ratio,
       CAST( t.$9 AS INTEGER) AS Caregiver_Budget
FROM @DISC_PROD.Stage.AWSAZSTAGEPROD/Files/Budget/Caregiver_Budget_20210830 (file_format => DISC_PROD.STAGE.PSV_FORMAT ) AS t;