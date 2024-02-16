CREATE OR REPLACE PROCEDURE DW_PROD.HAH.GET_STAGE_NAVISION_FACT_PAYROLL("STR_ETL_TASK_KEY" VARCHAR(16777216), "STR_CDC_START" VARCHAR(16777216), "STR_CDC_END" VARCHAR(16777216))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
EXECUTE AS OWNER
AS '
BEGIN

--*****************************************************************************************************************************
-- NAME: NAVISION_FACT_PAYROLL
--
-- PURPOSE: Creates one row per PAYROLL as per Navision
--
-- DEVELOPMENT LOG:
	
-- DATE        AUTHOR                				NOTES:
-- --------    -------------------------------   	--------------------------------------------------------------------------
-- 10/12/22    Aditya Shukla / Jigar Prajapati      Initial development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.NAVISION_FACT_PAYROLL

WITH EMPLOYEE AS (
	SELECT DISTINCT 
		MASTER_ID, NO_ AS ID,
		MD5(''NAVISION'' || ''-'' || MASTER_ID || ''-'' || ''NAVISION'') AS EMPLOYEE_KEY
	FROM DISC_DEDUPE_PROD.NAVISION.EMPLOYEE_MASTER_LIST
	UNION
	SELECT DISTINCT 
		MASTER_ID, NO_ AS ID,
		MD5(''NAVISION'' || ''-'' || MASTER_ID || ''-'' || ''NAVISION'') AS EMPLOYEE_KEY
	FROM DISC_DEDUPE_PROD.NAVISION.EMPLOYEE_MATCH_LIST
	WHERE NO_ NOT IN (SELECT DISTINCT NO_ FROM DISC_DEDUPE_PROD.NAVISION.EMPLOYEE_MASTER_LIST)
), 
GROSS_PAY AS (
	SELECT DISTINCT EMPLOYEE_NO_, CHECK_NO_, SUM(AMOUNT_ON_PAY_CHECK) AS GROSS_AMT
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	WHERE PLE.AMOUNT_ON_PAY_CHECK NOT LIKE ''-%'' AND UPPER(PLE.PAYROLL_CONTROL_NAME) NOT LIKE ''%REIMB%''
	GROUP BY 1, 2
),
TAX_AMT AS (
	SELECT DISTINCT EMPLOYEE_NO_, CHECK_NO_, SUM(AMOUNT_ON_PAY_CHECK) AS TAX_AMT
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	WHERE UPPER(PLE.PAYROLL_CONTROL_NAME) LIKE ''%TAX%''
	GROUP BY 1, 2
),
SERVICE_PAY AS (
	SELECT DISTINCT EMPLOYEE_NO_, CHECK_NO_, SUM(AMOUNT_ON_PAY_CHECK) AS SERV_AMT
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	WHERE PAYROLL_CONTROL_NAME LIKE ''Regular%'' OR PAYROLL_CONTROL_NAME LIKE ''Salary''
	GROUP BY 1, 2
),
NON_SERVICE_PAY AS (
	SELECT DISTINCT EMPLOYEE_NO_, CHECK_NO_, SUM(AMOUNT_ON_PAY_CHECK) AS NON_SERV_AMT
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	WHERE UPPER(PAYROLL_CONTROL_NAME) NOT LIKE ''%OVERTIME%'' AND UPPER(PAYROLL_CONTROL_NAME) NOT LIKE ''%REGULAR%'' AND UPPER(PAYROLL_CONTROL_NAME) NOT LIKE ''%SALARY%'' AND AMOUNT_ON_PAY_CHECK NOT LIKE ''-%'' AND UPPER(PLE.PAYROLL_CONTROL_NAME) NOT LIKE ''%REIMB%''
	GROUP BY 1, 2
),
OVERTIME_PAY AS (
	SELECT DISTINCT EMPLOYEE_NO_, CHECK_NO_, SUM(AMOUNT_ON_PAY_CHECK) AS OVERTIME_AMT
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	WHERE UPPER(PAYROLL_CONTROL_NAME) LIKE ''%OVERTIME%''
	GROUP BY 1, 2
),
UNION_AMOUNT AS (
	SELECT DISTINCT EMPLOYEE_NO_, CHECK_NO_, SUM(AMOUNT_ON_PAY_CHECK) AS UNION_AMOUNT
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	WHERE UPPER(PAYROLL_CONTROL_NAME) LIKE ''%UNION%'' OR UPPER(PAYROLL_POSTING_GROUP) LIKE ''%UNION%''
	GROUP BY 1, 2
),
REIMB_AMOUNT AS (
	SELECT DISTINCT EMPLOYEE_NO_, CHECK_NO_, SUM(AMOUNT) AS REIMB_AMOUNT
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	WHERE UPPER(PAYROLL_CONTROL_NAME) LIKE ''%REIMB%''
	GROUP BY 1, 2
),
NET_PAY AS (
	SELECT EMPLOYEE_NO_, CHECK_NO_, SUM(AMOUNT_ON_PAY_CHECK) AS NET_PAY
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	GROUP BY 1, 2
),
OTHER_DEDUCTIONS_AMOUNT AS (
	SELECT DISTINCT EMPLOYEE_NO_, CHECK_NO_, SUM(AMOUNT_ON_PAY_CHECK) AS DEDUCTIONS_AMOUNT
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	WHERE AMOUNT_ON_PAY_CHECK LIKE ''-%'' AND UPPER(PLE.PAYROLL_CONTROL_NAME) NOT LIKE ''%TAX%'' AND UPPER(PLE.PAYROLL_CONTROL_NAME) NOT LIKE ''%UNION%''
	GROUP BY 1, 2
),
SERVICE_HOURS AS (
	SELECT DISTINCT EMPLOYEE_NO_, CHECK_NO_, AMOUNT AS SRV_HRS
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	WHERE PAYROLL_CONTROL_NAME LIKE ''Regular Hours''
),
OVERTIME_HOURS AS (
	SELECT DISTINCT EMPLOYEE_NO_, CHECK_NO_, AMOUNT AS OVERTIME_HRS
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	WHERE PAYROLL_CONTROL_NAME LIKE ''Overtime Hours''
),
NON_SERV_HOURS AS (
	SELECT DISTINCT EMPLOYEE_NO_, CHECK_NO_, SUM(AMOUNT) AS NON_SERV_HRS
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	WHERE PAYROLL_CONTROL_NAME = ''Holiday Hours'' OR PAYROLL_CONTROL_NAME = ''Training Hours'' OR PAYROLL_CONTROL_NAME = ''Personal Hours''
	GROUP BY 1, 2
),
SICK_HOURS AS (
	SELECT DISTINCT EMPLOYEE_NO_, CHECK_NO_, SUM(AMOUNT) AS SICK_HRS
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	WHERE PAYROLL_CONTROL_NAME = ''Sick Hours Used''
	GROUP BY 1, 2
),
VACATION_HOURS AS (
	SELECT DISTINCT EMPLOYEE_NO_, CHECK_NO_, SUM(AMOUNT) AS VAC_HRS
	FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
	WHERE PAYROLL_CONTROL_NAME = ''Vacation Hours Used''
	GROUP BY 1, 2
)
SELECT DISTINCT
	MD5(CAST(PAY_DATE AS VARCHAR) || ''-'' || COALESCE(EMP.MASTER_ID, PLE.EMPLOYEE_NO_) || ''-'' || NVL(PLE.CHECK_NO_, ''UNKNOWN'')  || ''-'' || PLE.PAY_PERIOD_START_DATE || ''-'' || ''NAVISION'') AS PAYROLL_KEY,
	PAY_DATE::DATE AS REPORT_DATE,
	COALESCE(EMP.EMPLOYEE_KEY, MD5(''NAVISION'' || ''-'' || PLE.EMPLOYEE_NO_ || ''-'' || ''NAVISION'')) AS EMPLOYEE_KEY,
	COALESCE(MD5(''NAVISION'' || ''-'' || B.BRANCH_CODE || B.BRANCH_NAME || ''-'' || ''NAVISION''), ''UNKNOWN'') AS BRANCH_KEY,
	21 AS SOURCE_SYSTEM_ID,
	PAY_DATE::DATE AS PAYROLL_DATE,
	COALESCE(EMP.ID, PLE.EMPLOYEE_NO_) AS EMPLOYEE_ID,
	COALESCE(B.BRANCH_NAME, ''UNKNOWN'') AS BRANCH_NAME,
	''NAVISION'' AS SYSTEM_CODE,
	PAY_PERIOD_START_DATE::DATE PAY_PERIOD_START_DATE,
	PAY_PERIOD_END_DATE::DATE PAY_PERIOD_END_DATE,
	PLE.CHECK_NO_ AS CHECK_NUMBER,
	NULL AS PAY_HOURS,
	SH.SRV_HRS AS SERVICE_HOURS,
	OH.OVERTIME_HRS AS OVERTIME_HOURS,
	NSH.NON_SERV_HRS AS NON_SERVICE_UNITS,							-- ASK
	SICK_H.SICK_HRS AS SICK_HOURS,
	VH.VAC_HRS AS VACATION_HOURS,
--	CASE
--		WHEN PLE.CHECK_NO_ NOT LIKE ''ADM%'' THEN ERATES.REGULAR_RATE
--		ELSE NULL
--	END AS PAY_RATE,
	(SP.SERV_AMT / SH.SRV_HRS) AS PAY_RATE,
	CASE WHEN PLE.CHECK_NO_ NOT LIKE ''ADM%'' 
		THEN ERATES.OVERTIME_RATE 
	ELSE NULL 
	END AS OVERTIME_RATE,
	GA.GROSS_AMT AS GROSS_PAY_AMOUNT,
	SP.SERV_AMT AS SERVICE_PAY_AMOUNT,
	OTM.OVERTIME_AMT AS OVERTIME_PAY_AMOUNT,
	NSP.NON_SERV_AMT AS NON_SERVICE_PAY_AMOUNT,
	REPLACE(TAX.TAX_AMT, ''-'') AS TAX_AMOUNT,
	NP.NET_PAY AS NET_PAY_AMOUNT,
	REPLACE(ODA.DEDUCTIONS_AMOUNT, ''-'') AS OTHER_DEDUCTIONS_AMOUNT,
	REPLACE(UA.UNION_AMOUNT, ''-'') AS UNION_DUES_AMOUNT,
	RA.REIMB_AMOUNT AS REINBURSMENT_AMOUNT,
	:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
	:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_INSERTED_DATE,
		CURRENT_USER AS ETL_INSERTED_BY,
		convert_timezone(''UTC'', CURRENT_TIMESTAMP)::timestamp_ntz AS ETL_LAST_UPDATED_DATE,
		CURRENT_USER AS ETL_LAST_UPDATED_BY,
		FALSE AS ETL_DELETED_FLAG
FROM DISC_PROD.NAVISION.PAYROLL_LEDGER_ENTRY PLE
LEFT JOIN EMPLOYEE EMP
	ON EMP.ID = PLE.EMPLOYEE_NO_
LEFT JOIN SERVICE_PAY AS SP
	ON SP.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND SP.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN NON_SERVICE_PAY AS NSP
	ON NSP.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND NSP.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN UNION_AMOUNT AS UA
	ON UA.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND UA.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN REIMB_AMOUNT AS RA
	ON RA.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND RA.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN GROSS_PAY AS GA
	ON GA.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND GA.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN TAX_AMT AS TAX
	ON TAX.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND TAX.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN NET_PAY AS NP
	ON NP.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND NP.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN OTHER_DEDUCTIONS_AMOUNT AS ODA
	ON ODA.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND ODA.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN OVERTIME_PAY AS OTM
	ON OTM.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND OTM.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN SERVICE_HOURS AS SH 
	ON SH.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND SH.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN OVERTIME_HOURS AS OH
	ON OH.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND OH.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN NON_SERV_HOURS AS NSH
	ON NSH.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND NSH.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN SICK_HOURS AS SICK_H 
	ON SICK_H.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND SICK_H.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN VACATION_HOURS AS VH
	ON VH.EMPLOYEE_NO_ = PLE.EMPLOYEE_NO_ AND VH.CHECK_NO_ = PLE.CHECK_NO_
LEFT JOIN DISC_PROD.NAVISION.EMPLOYEE_RATES AS ERATES 
	ON ERATES.NO_ = PLE.EMPLOYEE_NO_
LEFT JOIN DISC_PROD.NAVISION.BRANCH_MAPPING B
	ON B.BRANCH_CODE = LEFT(PLE.EMPLOYEE_NO_, 3);
END;
';