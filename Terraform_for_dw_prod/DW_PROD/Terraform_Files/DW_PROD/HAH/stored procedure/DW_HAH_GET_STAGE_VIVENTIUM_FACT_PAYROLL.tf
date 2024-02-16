resource "snowflake_procedure" "DW_HAH_GET_STAGE_VIVENTIUM_FACT_PAYROLL" {
	name ="GET_STAGE_VIVENTIUM_FACT_PAYROLL"
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "HAH"
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


BEGIN

--*****************************************************************************************************************************
-- NAME: VIVENTIUM_FACT_PAYROLL
--
-- PURPOSE: Creates one row for each each PAYROLL according  to Viventium
--
-- DEVELOPMENT LOG:
-- DATE        AUTHOR                NOTES:
-- --------    -------------------   -----------------------------------------------------------------------------------------------        
-- 06/13/23		Meet Dalwadi		 Initial Development
--*****************************************************************************************************************************


INSERT OVERWRITE INTO dw_prod.STAGE.viventium_fact_payroll
WITH MASTER_EMPLOYEES AS (
	SELECT DISTINCT 
		MASTER_ID, EMPLOYEEKEY, COMPANYCODE
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.VIVENTIUM.EMPLOYEE_MASTER_LIST
	UNION 
	SELECT DISTINCT 
		MASTER_ID, ID, COMPANYCODE
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.VIVENTIUM.EMPLOYEE_MATCH_LIST 
	WHERE ID NOT IN (SELECT DISTINCT EMPLOYEEKEY FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.VIVENTIUM.EMPLOYEE_MASTER_LIST)
),
OVERTIME_HOURS as (
select  EU.COMPANYCODE ,EU.EMPLOYEENUMBER,EU.CHECKDATE,EU.CHECKORVOUCHERNUMBER,SUM(IFF(e.value:hours IS NULL,0,e.value:hours))  as OVERTIME_HOURS 
FROM disc_prod.VIVENTIUM.EXPORTCHECKS_UNFLATTEN EU,lateral flatten(input => earnings,outer => True) e 
WHERE e.value:earningCode IN (''OT'',''OVERTIME'')
group by EU.COMPANYCODE ,EU.EMPLOYEENUMBER,EU.CHECKDATE ,EU.CHECKORVOUCHERNUMBER
),
SICK_HOURS AS (
SELECT EU.COMPANYCODE ,EU.EMPLOYEENUMBER,EU.CHECKDATE,EU.CHECKORVOUCHERNUMBER,SUM(e.value:hours)  as SICK_HOURS 
FROM disc_prod.VIVENTIUM.EXPORTCHECKS_UNFLATTEN EU,lateral flatten(input => earnings,outer => True) e 
WHERE e.value:earningCode = ''SK''
group by EU.COMPANYCODE ,EU.EMPLOYEENUMBER,EU.CHECKDATE,EU.CHECKORVOUCHERNUMBER
),
VACATION_HOURS AS (
SELECT EU.COMPANYCODE ,EU.EMPLOYEENUMBER,EU.CHECKDATE,EU.CHECKORVOUCHERNUMBER,SUM(e.value:hours)  as VACATION_HOURS 
FROM disc_prod.VIVENTIUM.EXPORTCHECKS_UNFLATTEN EU,lateral flatten(input => earnings,outer => True) e 
WHERE e.value:earningCode IN (''VA'',''VACATION'')
group by EU.COMPANYCODE ,EU.EMPLOYEENUMBER,EU.CHECKDATE,EU.CHECKORVOUCHERNUMBER
),
OVERTIME_RATE AS(
SELECT EU.COMPANYCODE ,EU.EMPLOYEENUMBER,EU.CHECKDATE,EU.CHECKORVOUCHERNUMBER,AVG(e.value:rate)  as OVERTIME_RATE 
FROM disc_prod.VIVENTIUM.EXPORTCHECKS_UNFLATTEN EU,lateral flatten(input => earnings,outer => True) e 
WHERE e.value:earningCode IN (''OT'',''OVERTIME'')
group by EU.COMPANYCODE ,EU.EMPLOYEENUMBER,EU.CHECKDATE,EU.CHECKORVOUCHERNUMBER	
),
SERVICE_PAY_AMOUNT AS(
SELECT EU.COMPANYCODE ,EU.EMPLOYEENUMBER,EU.CHECKDATE,EU.CHECKORVOUCHERNUMBER,SUM(e.value:amount)  as SERVICE_PAY_AMOUNT 
FROM disc_prod.VIVENTIUM.EXPORTCHECKS_UNFLATTEN EU,lateral flatten(input => earnings,outer => True) e 
WHERE e.value:earningCode IN (''RG'',''REGULAR'')
group by EU.COMPANYCODE ,EU.EMPLOYEENUMBER,EU.CHECKDATE,EU.CHECKORVOUCHERNUMBER
),
OVERTIME_PAY_AMOUNT AS(
SELECT EU.COMPANYCODE ,EU.EMPLOYEENUMBER,EU.CHECKDATE,EU.CHECKORVOUCHERNUMBER,SUM(e.value:amount)  as OVERTIME_PAY_AMOUNT 
FROM disc_prod.VIVENTIUM.EXPORTCHECKS_UNFLATTEN EU,lateral flatten(input => earnings,outer => True) e 
WHERE e.value:earningCode IN (''OT'',''OVERTIME'')
group BY EU.COMPANYCODE , EU.EMPLOYEENUMBER,EU.CHECKDATE,EU.CHECKORVOUCHERNUMBER
),
REINBURSMENT_AMOUNT AS (
SELECT EU.COMPANYCODE ,EU.EMPLOYEENUMBER,EU.CHECKDATE,EU.CHECKORVOUCHERNUMBER,SUM(d.value:amount)  as REINBURSMENT_AMOUNT 
FROM disc_prod.VIVENTIUM.EXPORTCHECKS_UNFLATTEN EU,lateral flatten(input => deductions,outer => True) d 
WHERE d.value:deductionCode IN (''REIM'',''MISC-REIM'')
group by EU.COMPANYCODE ,EU.EMPLOYEENUMBER,EU.CHECKDATE,EU.CHECKORVOUCHERNUMBER
)
SELECT DISTINCT 
MD5(EC.COMPANYCODE  || ''-''|| EC.CHECKDATE || ''-''||  EC.CHECKKEY::VARCHAR || ''-'' || trim(ME.MASTER_ID)::VARCHAR ||  ''-'' || ''VIVENTIUM'') AS PAYROLL_KEY,
EC.checkDate AS REPORT_DATE,
MD5(EC.COMPANYCODE ||''-'' ||trim(ME.MASTER_ID) || ''-'' ||''VIVENTIUM'') AS EMPLOYEE_KEY,
MD5( BR.SYSTEM_CODE || ''-'' || BR.OFFICE_NAME || ''-'' || ''VIVENTIUM'')  AS BRANCH_KEY,
34 AS SOURCE_SYSTEM_ID,
EC.checkDate AS PAYROLL_DATE,
EC.EMPLOYEENUMBER AS EMPLOYEE_ID,
BR.OFFICE_NAME AS BRANCH_NAME,
EC.COMPANYCODE AS SYSTEM_CODE,
EC.periodBeginDate AS PAY_PERIOD_START_DATE,
EC.periodEndDate AS PAY_PERIOD_END_DATE,
EC.checkOrVoucherNumber AS CHECK_NUMBER,
EC.totalHours AS PAY_HOURS,
EC.totalWorkedHours AS SERVICE_HOURS,
OH.OVERTIME_HOURS AS OVERTIME_HOURS,
NULL AS NON_SERVICE_UNITS,
SH.SICK_HOURS AS SICK_HOURS ,
VH.VACATION_HOURS AS VACATION_HOURS ,
round(div0(EC.totalGross,EC.totalWorkedHours),2) AS PAY_RATE,
OVR.OVERTIME_RATE AS OVERTIME_RATE,
EC.totalGross AS GROSS_PAY_AMOUNT,
SPA.SERVICE_PAY_AMOUNT AS SERVICE_PAY_AMOUNT,
OPA.OVERTIME_PAY_AMOUNT AS OVERTIME_PAY_AMOUNT,
NULL AS NON_SERVICE_PAY_AMOUNT,
EC.totalTaxes AS TAX_AMOUNT,
EC.totalNet AS NET_PAY_AMOUNT,
EC.totalDeductions AS OTHER_DEDUCTIONS_AMOUNT,
NULL AS UNION_DUES_AMOUNT,
RA.REINBURSMENT_AMOUNT AS REINBURSMENT_AMOUNT,
:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
			:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
			CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
	CURRENT_USER AS ETL_INSERTED_BY ,
	CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
	CURRENT_USER AS ETL_LAST_UPDATED_BY,
	0 AS ETL_DELETED_FLAG,
	0 AS ETL_INFERRED_MEMBER_FLAG
from disc_prod.viventium.EXPORTCHECKS_UNFLATTEN EC 
LEFT OUTER JOIN MASTER_EMPLOYEES ME ON EC.COMPANYCODE = ME.COMPANYCODE AND EC.EMPLOYEEKEY = ME.EMPLOYEEKEY
left join dw_prod.hah.dim_branch BR on EC.COMPANYCODE  = BR.SYSTEM_CODE 
LEFT OUTER join OVERTIME_HOURS OH ON EC.EMPLOYEENUMBER = OH.EMPLOYEENUMBER AND EC.CHECKDATE = OH.CHECKDATE AND EC.CHECKORVOUCHERNUMBER = OH.CHECKORVOUCHERNUMBER
LEFT OUTER join SICK_HOURS SH ON EC.EMPLOYEENUMBER = SH.EMPLOYEENUMBER AND EC.CHECKDATE = SH.CHECKDATE AND EC.CHECKORVOUCHERNUMBER = SH.CHECKORVOUCHERNUMBER
LEFT OUTER join VACATION_HOURS VH ON EC.EMPLOYEENUMBER = VH.EMPLOYEENUMBER AND EC.CHECKDATE = VH.CHECKDATE AND EC.CHECKORVOUCHERNUMBER = VH.CHECKORVOUCHERNUMBER
LEFT OUTER join OVERTIME_RATE OVR ON EC.EMPLOYEENUMBER = OVR.EMPLOYEENUMBER AND EC.CHECKDATE = OVR.CHECKDATE AND EC.CHECKORVOUCHERNUMBER = OVR.CHECKORVOUCHERNUMBER
LEFT OUTER JOIN SERVICE_PAY_AMOUNT SPA ON EC.EMPLOYEENUMBER = SPA.EMPLOYEENUMBER AND EC.CHECKDATE = SPA.CHECKDATE AND EC.CHECKORVOUCHERNUMBER = SPA.CHECKORVOUCHERNUMBER
LEFT OUTER JOIN OVERTIME_PAY_AMOUNT OPA ON EC.EMPLOYEENUMBER = OPA.EMPLOYEENUMBER AND EC.CHECKDATE = OPA.CHECKDATE AND EC.CHECKORVOUCHERNUMBER = OPA.CHECKORVOUCHERNUMBER
LEFT OUTER JOIN  REINBURSMENT_AMOUNT RA ON EC.EMPLOYEENUMBER = RA.EMPLOYEENUMBER AND EC.CHECKDATE = RA.CHECKDATE AND EC.CHECKORVOUCHERNUMBER = RA.CHECKORVOUCHERNUMBER;

RETURN ''Success'';

END;

 EOT
}

