create or replace view DW_PROD.REPORT.VW_EQUIFAX_EMPLOYEE_PAYROLL(
	"EmployeeUniqueIdentifier",
	"EmployerFEIN",
	"DataSource",
	"PayPeriodStartDate",
	"PayPeriodEndDate",
	"IsInvalid",
	"PayDate",
	"CompensationType",
	"PayRate",
	"PayType",
	"PayCycleFrequency",
	"HoursWorked",
	"GrossPay",
	"W2Box1Deductions",
	"JobTitle"
) as 
--SELECT "EmployeeUniqueIdentifier", "EmployerFEIN", "DataSource", "PayPeriodStartDate", "PayPeriodEndDate", "PayDate", COUNT(*) FROM (
--SELECT COUNT(*) FROM (
--SELECT "EmployeeUniqueIdentifier", "EmployerFEIN", "DataSource", "PayPeriodStartDate", "PayPeriodEndDate", "IsInvalid", "PayDate",
SELECT DISTINCT * FROM (
(
SELECT "EmployeeUniqueIdentifier", "EmployerFEIN", "DataSource", "PayPeriodStartDate", "PayPeriodEndDate", "IsInvalid",
	"PayDate", "CompensationType", MIN( "PayRate") AS "PayRate", "PayType", "PayCycleFrequency",
	SUM( CASE WHEN "JobTitle" = 'FIELD' THEN "HoursWorked" ELSE '40' END)  AS "HoursWorked", SUM( "GrossPay") AS "GrossPay", SUM( "W2Box1Deductions") AS "W2Box1Deductions",
	"JobTitle"
FROM (
(-- PA payroll
SELECT DISTINCT 
	MD5( HEX_DECODE_STRING( EMPLOYEE_PID)) AS "EmployeeUniqueIdentifier",
	fein.fein as "EmployerFEIN", 
	pay.system_code AS "DataSource", 
	pay.pay_period_start_date AS "PayPeriodStartDate",
	pay.pay_period_end_date AS "PayPeriodEndDate", 
	'No' AS "IsInvalid", 
	pay.payroll_date AS "PayDate", 
	'' AS "CompensationType", 
	MIN(pay.pay_rate) AS "PayRate", 
	'HY' AS "PayType", 
	'WY' AS "PayCycleFrequency", 
	pay.PAY_hours  AS "HoursWorked", 
	pay.gross_pay_amount AS "GrossPay", 
	pay.OTHER_DEDUCTIONS_AMOUNT AS "W2Box1Deductions", 
	CASE WHEN UPPER(COALESCE (tp.field_worker_flag, sd.fieldstaff)) = 'FALSE' THEN 'ADMIN'
		 WHEN UPPER(COALESCE (tp.field_worker_flag, sd.fieldstaff)) = 'TRUE' THEN 'FIELD' END
		AS "JobTitle"
FROM DW_PROD.HAH.FACT_PAYROLL AS pay
INNER JOIN (SELECT * FROM DW_PROD.HAH.DIM_EMPLOYEE
			WHERE NULLIF( UPPER( TRIM( EMPLOYEE_FIRST_NAME)),'TEST') <> 'TEST' AND NULLIF( UPPER( TRIM( EMPLOYEE_LAST_NAME)),'TEST') <> 'TEST'
				AND NULLIF( UPPER( TRIM( EMPLOYEE_FIRST_NAME)),'PAYSTUB') NOT LIKE '%PAYSTUB%' AND NULLIF( UPPER( TRIM( EMPLOYEE_LAST_NAME)),'PAYSTUB') NOT LIKE '%PAYSTUB%'
				AND NULLIF( EMPLOYEE_HIRE_DATE,'1900-01-01') IS NOT NULL) AS emp
	ON pay.EMPLOYEE_KEY = emp.employee_key
LEFT OUTER JOIN DISC_PROD.TRUSTPOINTDATA.EMPLOYEES AS tp 
	ON tp.employee_number = pay.employee_id
LEFT OUTER JOIN DISC_PROD.SANDATAIMPORT.SANDATA_STAFFS AS sd 
	ON sd.STAFFID = pay.employee_ID
LEFT OUTER JOIN DW_PROD.HAH.DIM_COMPANY_STATE fein
    ON TRIM( PAY.SOURCE_SYSTEM_ID) = TRIM( FEIN.PAYROLL_SOURCE_SYSTEM_ID)
    
WHERE pay.source_system_id IN (6)
AND emp.EMPLOYEE_PID IS NOT NULL

GROUP BY 
	MD5( HEX_DECODE_STRING( EMPLOYEE_PID)) ,
	fein.fein, 
	pay.system_code, 
	pay.pay_period_start_date,
	pay.pay_period_end_date, 
	pay.payroll_date, 
	pay.SERVICE_HOURS,
	pay.PAY_hours, 
	pay.gross_pay_amount, 
	pay.OTHER_DEDUCTIONS_AMOUNT , 
	CASE WHEN UPPER(COALESCE (tp.field_worker_flag, sd.fieldstaff)) = 'FALSE' THEN 'ADMIN'
		 WHEN UPPER(COALESCE (tp.field_worker_flag, sd.fieldstaff)) = 'TRUE' THEN 'FIELD' END
	
  
HAVING 
datediff (DAY,pay.pay_period_start_date,pay.pay_period_end_date) < 100

ORDER BY pay.payroll_date)
)
GROUP BY "EmployeeUniqueIdentifier", "EmployerFEIN", "DataSource", "PayPeriodStartDate", "PayPeriodEndDate", "IsInvalid",
	"PayDate", "CompensationType", "PayType", "PayCycleFrequency", "JobTitle"
)

UNION 

(WITH pid AS (
	SELECT DISTINCT MD5( TRIM( HEX_DECODE_STRING( EMPLOYEE_PID))) AS employee_pid,
		FIRST_VALUE( EMPLOYEE_KEY) IGNORE NULLS 
			OVER( PARTITION BY EMPLOYEE_PID
			ORDER BY NVL( EMPLOYEE_LAST_CHECK_DATE, '1900-01-01') DESC, NVL( EMPLOYEE_BENEFIT_START_DATE, '1900-01-01') DESC, NVL( EMPLOYEE_HIRE_DATE, '1900-01-01') DESC, EMPLOYEE_NUMBER)
			AS EMPLOYEE_KEY
	FROM DW_PROD.HAH.DIM_EMPLOYEE e
	WHERE SOURCE_SYSTEM_ID IN (1,2,4,5)
		AND MD5( TRIM( HEX_DECODE_STRING( EMPLOYEE_PID))) NOT IN ('07eaad40608dee87230752347b2d29f4','bbb8aae57c104cda40c93843ad5e6db8','a19a654c4403b86cb0c437097ff04466',
									 '77c9749b451ab8c713c48037ddfbb2c4','9e4524c2628490392f0db89f7487b3da')
		AND NULLIF( UPPER( TRIM( e.EMPLOYEE_FIRST_NAME)),'TEST') <> 'TEST' AND NULLIF( UPPER( TRIM( e.EMPLOYEE_LAST_NAME)),'TEST') <> 'TEST'
		AND NULLIF( UPPER( TRIM( e.EMPLOYEE_FIRST_NAME)),'PAYSTUB') NOT LIKE '%PAYSTUB%' AND NULLIF( UPPER( TRIM( e.EMPLOYEE_LAST_NAME)),'PAYSTUB') NOT LIKE '%PAYSTUB%'
		AND NULLIF( e.EMPLOYEE_HIRE_DATE,'1900-01-01') IS NOT NULL
	--	AND MD5( TRIM( HEX_DECODE_STRING( EMPLOYEE_PID))) = '7a28e5cece3c60aa73aed6496015df03'
),
CAPayCodes AS 
(
	SELECT DB,PAY_CODE,PAY_CODE_CATEGORY
	FROM DISC_PROD.COSTALSYNCDATA.PAYCODE_CATEGORY
	WHERE PAY_CODE_CATEGORY ='SERVICE_CODE'
),
--HAHPaycodes AS
--(SELECT Paycodes.COMPANY_CODE, Paycodes.PAY_CODE
--  FROM DISC_PROD.GPSYNCDATA.EMPLOYER_EDGE_PAYCODES Paycodes
--  JOIN DISC_PROD.GPSYNCDATA.GPALLPAYCODESBASE PaycodeDescription
--      ON TRIM(PaycodeDescription.DB) = TRIM(Paycodes.COMPANY_CODE) AND TRIM(PaycodeDescription.PAY_CODE) = TRIM(Paycodes.PAY_CODE)
--  WHERE Paycodes.IN_USE = 1 AND Paycodes.COUNT_HOURS = 1 AND Paycodes.TYPE_CODE = 'R'
--      AND UPPER(Paycodes.PAY_CODE) NOT IN ('OCP', 'TTI', 'QTRBON','ADJ', 'OTM1', 'RETADJ', 'RETRO', 'RETU17', 'RTR17', 'RTR19', 'RTR20', 'RTROID', 'SETTLE', 'UNA', 'UNA2',
--			'APP720','APP820','BMP420','BMP520','BMP620','BMP720','DA0420','DA0520','DA0620','DA0720','DW0420','DW0520','DW0620','DW0720','MED','MPP720','MPP820','RFINS','VPP720','VPP820',
--			'NOB','OCP','SOCP','OTBL','ONCE','MIL', 'TTI', 'DFTIL','DCTIL','USVTIL','DDTR',
--			'HOL', 'HOLN', 'HOLT', 'FLT', 'HOL2', 'HOLCCO', 'HOLCJU', 'HOLJJU', 'HOLK', 'HOLKCO', 'HOLKJK', 'HOLKJU', 'HOLLIL', 'HOLLJK',
--			'HOLMJK', 'HOLMJU', 'HOLNIL', 'HOLTIL', 'HOLTJU', 'SHOL', 'HOLC', 'HOLN', 'HOLT', 'HOL1', 'HOL3', 'HOLM', 'HOLKCH', 'HOLLCH',
--			'HOLLJG', 'HOLTCH', 'HOLNCH', 'HOLNJG', 'PTOFLT', 'HOLMJG', 'PERS', 'HOLJCO', 'HOLJIL', 'HOLL', 'HOLLCO', 'HOLLJU', 'HOLNCO',
--			'HOLNJU', 'HOLCIL', 'HOLTCO', 'HOLCJG', 'HOLJJG', 'HOLTJG', 'HOLKJG', 'HOLMCH', 'HOLMCO', 'HOLKIL', 'HOLCCH', 'HOLJ', 'HOLJCH', 'HOLMIL',                             'BON', 'BONUS', 'BONUS1', 'IBO', 'SOB', 'IBO', 'MIN',
--			'CLSD', 'MWDA', 'PDR', 'RD1', 'RD2', 'RD3', 'RD4', 'RD5', 'RD6', 'RD7', 'RD8', 'RD9', 'RS1',
--			'ASM', 'PASS', 'PRES', 'RNS3', 'RNS4', 'RNS7', 'SPRA' )),
  
HAHRates AS
(
	SELECT DISTINCT 
		emp.db, 
		emp.EMPLOYEE_ID, 
		m.PAYDATE, 
		min(dl.RATE) AS rate
	FROM DISC_PROD.GPSYNCDATA.GPALLEMPLOYEESBASE emp 
	LEFT OUTER JOIN DISC_PROD.GPSYNCDATA.PAYSTUB_MASTER m
		ON trim(emp.employee_id) = trim(m.EMPLOYEEID)
		AND trim(emp.db) = trim(m.DB)
	LEFT OUTER JOIN DISC_PROD.GPSYNCDATA.PAYSTUB_DETAILLINE dl 
		ON trim(dl.CHECKID) = trim(m.checkid)
--	LEFT OUTER JOIN HAHPaycodes 
--		ON HAHPaycodes.pay_Code = dl.paycode
--		AND HAHPaycodes.company_code = M.db
	WHERE dl.rate > '0'
	AND dl.paycode NOT IN ('OCP', 'TTI', 'QTRBON','ADJ', 'OTM1', 'RETADJ', 'RETRO', 'RETU17', 'RTR17', 'RTR19', 'RTR20', 'RTROID', 'SETTLE', 'UNA', 'UNA2',
			'APP720','APP820','BMP420','BMP520','BMP620','BMP720','DA0420','DA0520','DA0620','DA0720','DW0420','DW0520','DW0620','DW0720','MED','MPP720','MPP820','RFINS','VPP720','VPP820',
			'NOB','OCP','SOCP','OTBL','ONCE','MIL', 'TTI', 'DFTIL','DCTIL','USVTIL','DDTR', 'TREIMB',
			'HOL', 'HOLN', 'HOLT', 'FLT', 'HOL2', 'HOLCCO', 'HOLCJU', 'HOLJJU', 'HOLK', 'HOLKCO', 'HOLKJK', 'HOLKJU', 'HOLLIL', 'HOLLJK',
			'HOLMJK', 'HOLMJU', 'HOLNIL', 'HOLTIL', 'HOLTJU', 'SHOL', 'HOLC', 'HOLN', 'HOLT', 'HOL1', 'HOL3', 'HOLM', 'HOLKCH', 'HOLLCH',
			'HOLLJG', 'HOLTCH', 'HOLNCH', 'HOLNJG', 'PTOFLT', 'HOLMJG', 'PERS', 'HOLJCO', 'HOLJIL', 'HOLL', 'HOLLCO', 'HOLLJU', 'HOLNCO',
			'HOLNJU', 'HOLCIL', 'HOLTCO', 'HOLCJG', 'HOLJJG', 'HOLTJG', 'HOLKJG', 'HOLMCH', 'HOLMCO', 'HOLKIL', 'HOLCCH', 'HOLJ', 'HOLJCH', 'HOLMIL', 'BON', 'BONUS', 'BONUS1', 'IBO', 'SOB', 'IBO', 'MIN',
			'MWDA', 'PDR', 'RS1','OTM', 'OTBL', 'OTM1', 'OTMCH', 'OTMCO', 'OTMIL', 'OTMJG', 'OTMJK', 'OTMJU', 'SOTM',
			'ASM', 'PASS', 'PRES', 'RNS3', 'RNS4', 'RNS7', 'SPRA', 'Sign','401K','401K','401K.','401K.','401KLN','401KLN',
			'401KLN', 'ACCDNT','ADAMS','ADJ', 'ADV', 'ADV102', 'ADV2', 'ADV3', 'AL', 'ALLEN', 'APP720','APP820','AUB','BACKCK','BARTHO','ADJNTX', 
			'BENTON', 'BHAMOT','BON', 'BONUS', 'BONUS1', 'IBO', 'SOB', 'IBO', 'MIN', 'QTRBON','ADJ', 'OTM1', 'RETADJ','RETRO', 'RETU17', 'RTR17', 
			'RTR19', 'RTR20', 'RTROID', 'SETTLE', 'UNA', 'UNA2', 'SEV','SIGN','VACPO','COVAL', 'DW1220', 'DW1020','DW0420','DW0620','DW1120',
			'DW0520','DW0920','DW0720','DW0720','DW0820','IDAJU','TTI', 'SPRA')
			
		AND dl.isreimbursement = 'FALSE'
		AND m.status = 'A'
		AND dl.ishistory = 'FALSE'
		AND dl.iswage = 'TRUE'
	GROUP BY 1,2,3
	ORDER BY employee_id
),
CARates AS 
(
	SELECT DISTINCT 
		emp.db,
		emp.employeeid, 
		emp.checkdate,
		pcd.CHECKNUMBER, 
		MIN( pcd.rate) AS rate
	FROM DISC_PROD.COSTALSYNCDATA.GPALLPAYCHECKSBASE emp 
	LEFT OUTER JOIN DISC_PROD.COSTALSYNCDATA.GPALLPAYCHECKDETAILSBASE pcd 
		ON TRIM( pcd.DB) = TRIM( emp.DB)
			AND TRIM( pcd.EMPLOYEEID) = TRIM( emp.EMPLOYEEID)
			AND TRIM( pcd.CHECKNUMBER) = TRIM( emp.CHECKNUMBER)
	LEFT OUTER JOIN CAPayCodes 
		ON TRIM( CAPayCodes.pay_code) = TRIM( pcd.paycode)
			AND TRIM( CAPayCodes.DB) = TRIM( pcd.db)
	WHERE pcd.rate > '1'
		AND pcd.paycode <> 'SHO'
	GROUP BY 1,2,3,4
),
CAHoursWorked AS 
(SELECT 
emp.db,
emp.employeeid, 
emp.checkdate,
pcd.CHECKNUMBER, 
sum(pcd.units) AS HoursWorked


FROM DISC_PROD.COSTALSYNCDATA.GPALLPAYCHECKSBASE emp 
LEFT OUTER JOIN DISC_PROD.COSTALSYNCDATA.GPALLPAYCHECKDETAILSBASE pcd 
ON TRIM( pcd.DB) = TRIM( emp.DB)
AND TRIM( pcd.EMPLOYEEID) = TRIM( emp.EMPLOYEEID)
AND TRIM( pcd.CHECKNUMBER) = TRIM( emp.CHECKNUMBER)

LEFT OUTER JOIN DISC_PROD.COSTALSYNCDATA.PAYCODE_CATEGORY pc 
ON pc.DB = pcd.db
AND pc.PAY_CODE = pcd.payCode

WHERE pcd.paycode NOT IN ('TRV','PTOEVB','6ADBON','6EABON', 'PTOEIB')


GROUP BY 
1,2,3,4),

totalpay as
(SELECT DISTINCT 
employee_key,
PAYROLL_DATE,
sum(gross_pay_amount)  GrossPay,
sum(OTHER_DEDUCTIONS_AMOUNT) W2Box1Deductions

FROM DW_PROD.HAH.FACT_PAYROLL 

WHERE payroll_date >= '2016-10-01'

GROUP BY 
1,2),

HAHWorkedHours AS 

(SELECT DISTINCT 
m.DB, 
M.EMPLOYEEID, 
M.PAYDATE, 
SUM(DL.UNITS) AS HoursWorked

FROM DISC_PROD.GPSYNCDATA.GPALLEMPLOYEESBASE emp 
LEFT OUTER JOIN DISC_PROD.GPSYNCDATA.PAYSTUB_MASTER m
	ON trim(emp.employee_id) = trim(m.EMPLOYEEID)
	AND trim(emp.db) = trim(m.DB)
LEFT OUTER JOIN DISC_PROD.GPSYNCDATA.PAYSTUB_DETAILLINE dl 
	ON trim(dl.CHECKID) = trim(m.checkid)
	
WHERE 
dl.paycode NOT IN ('401K','401K',
'401K.','401K.','401KLN','401KLN','401KLN', 'ACCDNT','ADAMS','ADJ', 'ADV', 'ADV102', 'ADV2', 'ADV3', 'AL', 'ALLEN', 'APP720',
'APP820','AUB','BACKCK','BARTHO','ADJNTX', 'BENTON', 'BHAMOT','BON', 'BONUS', 'BONUS1', 'IBO', 'SOB', 'IBO', 'MIN', 'QTRBON',
'ADJ', 'OTM1', 'RETADJ', 'RETRO', 'RETU17', 'RTR17', 'RTR19', 'RTR20', 'RTROID', 'SETTLE', 'UNA', 'UNA2', 'SEV', 'TREIMB',
'SIGN','VACPO','COVAL', 'DW1220', 'DW1020','DW0420','DW0620','DW1120','DW0520','DW0920','DW0720','DW0720','DW0820','IDAJU','TTI', 'SPRA') 

GROUP BY 
1,2,3)

SELECT DISTINCT  	
p.employee_pid AS "EmployeeUniqueIdentifier", 
	CASE WHEN emp.system_code = 'SHC_ALTRUS' THEN '58-1862778' 
		 WHEN emp.system_code = 'SHC_SAVANNAH' THEN '58-2219610'
		 ELSE fein.fein END
		AS "EmployerFEIN",
	emp.system_code AS "DataSource", 
	pay.pay_period_start_date AS "PayPeriodStartDate",
	pay.pay_period_end_date AS "PayPeriodEndDate", 
	'No' AS "IsInvalid", 
	pay.payroll_date AS "PayDate", 
	'' AS "CompensationType",
	MIN( CASE WHEN pay.source_system_id IN (1,2) THEN ca.rate 
		 ELSE hah.rate END)
		AS "PayRate",
	'HY' AS "PayType", 
	'BW' AS "PayCycleFrequency", 
	COALESCE (HHours.HoursWorked, CAHours.HoursWorked) AS "HoursWorked",
	totalpay.GrossPay, 
	totalpay.W2Box1Deductions, 
	CASE WHEN emp.EMPLOYEE_CATEGORY = 'Field' THEN 'FIELD'
		 ELSE 'ADMIN' END
		AS "JobTitle"
FROM pid p
LEFT OUTER JOIN (SELECT * FROM DW_PROD.HAH.dim_employee WHERE source_system_id IN (1,2,5)) AS emp 
	ON MD5( HEX_DECODE_STRING( emp.employee_pid)) = p.employee_pid 
LEFT OUTER JOIN (SELECT * FROM DW_PROD.HAH.FACT_PAYROLL WHERE payroll_date >= '2016-10-01'::DATE) AS pay
	ON pay.EMPLOYEE_KEY = emp.employee_key
LEFT OUTER JOIN HAHRates AS HAH
	ON TRIM( HAH.db) = TRIM( pay.system_code)
		AND TRIM( HAH.employee_id) = TRIM( pay.employee_id)
		AND HAH.paydate = pay.payroll_Date
		
LEFT OUTER JOIN HAHWorkedHours AS HHours
	ON TRIM( HHours.db) = TRIM( pay.system_code)
		AND TRIM( HHours.employeeid) = TRIM( pay.employee_id)
		AND HHours.paydate = pay.payroll_Date	
		
LEFT OUTER JOIN CARates AS CA 
	ON TRIM( ca.checknumber) = TRIM( pay.check_number)
		AND CASE WHEN TRIM( ca.db) = 'ALTRU' THEN 'SHC_ALTRUS'
			 WHEN TRIM( ca.db) = 'SHC' THEN 'SHC_SAVANNAH'
			 ELSE TRIM( ca.db) END
		= TRIM( pay.system_code)
		
LEFT OUTER JOIN CAHoursWorked AS CAHours 
	ON TRIM( CAHours.checknumber) = TRIM( pay.check_number)
		AND CASE WHEN TRIM( CAHours.db) = 'ALTRU' THEN 'SHC_ALTRUS'
			 WHEN TRIM( CAHours.db) = 'SHC' THEN 'SHC_SAVANNAH'
			 ELSE TRIM( CAHours.db) END
		= TRIM( pay.system_code)
LEFT OUTER JOIN DW_PROD.HAH.DIM_COMPANY_STATE fein
	ON TRIM( emp.SYSTEM_CODE) = CASE WHEN emp.SOURCE_SYSTEM_ID = 5 THEN TRIM( fein.PAYROLL_SYSTEM_CODE)
                                     ELSE TRIM( fein.CURRENT_SOURCE_SYSTEM_ID) END
LEFT OUTER JOIN totalpay 
ON totalpay.employee_key = pay.employee_key
AND totalpay.payroll_date = pay.payroll_date

WHERE NVL( ca.rate, hah.rate) IS NOT NULL 
	AND pay.PAY_HOURS > 0 
	AND p.EMPLOYEE_PID IS NOT NULL
	AND pay.payroll_date >= '2016-01-01'


GROUP BY 
p.employee_pid, 
PAY.EMPLOYEE_id,
FEIN.FEIN,
emp.system_code, emp.system_code, 
pay.pay_period_start_date, pay.pay_period_end_date, 
pay.payroll_date, 
COALESCE (HHours.HoursWorked, CAHours.HoursWorked), 
totalpay.GrossPay, 
totalpay.W2Box1Deductions,
emp.EMPLOYEE_CATEGORY

ORDER BY p.employee_pid, pay.payroll_date))

WHERE "EmployeeUniqueIdentifier" IN (SELECT "EmployeeUniqueIdentifier" FROM DW_PROD.REPORT.VW_EQUIFAX_EMPLOYEE)
--	AND "EmployeeUniqueIdentifier" = MD5( '318682545')
;