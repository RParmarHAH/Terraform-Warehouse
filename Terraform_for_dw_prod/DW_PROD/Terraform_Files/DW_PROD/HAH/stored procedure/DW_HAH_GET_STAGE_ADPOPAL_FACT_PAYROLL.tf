resource "snowflake_procedure" "DW_HAH_GET_STAGE_ADPOPAL_FACT_PAYROLL" {
	name ="GET_STAGE_ADPOPAL_FACT_PAYROLL"
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
-- NAME: ADPOPAL_FACT_PAYROLL
--
-- PURPOSE: Creates one row for each PAYROLL according to ADP-OPAL
--
-- DEVELOPMENT LOG:
-- DATE				AUTHOR                					NOTES:
-- ----------		--------------------------------		-------------------------------------------------------------------
-- 27/12/2022		Aditya Shukla							Initial Development
--*****************************************************************************************************************************

INSERT OVERWRITE INTO STAGE.ADPOPAL_FACT_PAYROLL

WITH EMPLOYEE AS (
	SELECT DISTINCT 
		MASTER_ID, FILE_NUMBER, PAYROLL_COMPANY_CODE AS COMPANY_CODE, HOME_DEPARTMENT_CODE, HOME_DEPARTMENT_DESCRIPTION 
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ADP.OPAL_EMPLOYEE_MASTER_LIST
	UNION
	SELECT DISTINCT 
		MASTER_ID, FILE_NUMBER, COMPANY_CODE, HOME_DEPARTMENT_CODE, HOME_DEPARTMENT_DESCRIPTION 
	FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ADP.OPAL_EMPLOYEE_MATCH_LIST 
	WHERE FILE_NUMBER NOT IN (SELECT DISTINCT FILE_NUMBER FROM DISC_DEDUPE_${var.SF_ENVIRONMENT}.ADP.OPAL_EMPLOYEE_MASTER_LIST)
), 
PAYROLL AS (
	SELECT DISTINCT 
		FILE_NUMBER,
		CHECK_VOUCHER_NUMBER,
		PAY_DATE::DATE AS PAY_DATE,
		PERIOD_BEGINNING_DATE,
		PERIOD_ENDING_DATE,
		SUM(REPLACE(TOTAL_HOURS, '','')) AS TOTAL_HOURS,
		SUM(REPLACE(REGULAR_HOURS, '','')) AS REGULAR_HOURS,
		SUM(REPLACE(OVERTIME_HOURS, '','')) AS OVERTIME_HOURS,
		SUM(NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__AP_AP_CW, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__AP2_AP_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__EL_C19_LEAVE, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__FLO_HH_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__GEN_GENERAL, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__GOT_GENERAL_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__H_HOLIDAY, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__HH2_HH_HOL_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__HLO_HOLIDAY_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__MG_M_AMP_G, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__OP_OP, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__OR_ORIENTAT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__OR_ORIENTATION, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__OR2_ORIENTATION_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__P2A_P2A_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PAP_PAP_PW, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PEL_C19_LEAVE, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PH_PW_HOL_REG, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PH2_PW_HOL_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PMG_PW_M_AMP_G, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PN2_PW_TRN_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PO_PW_OR, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PO2_PW_OR_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__POP_OP_PW, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PR2_PW_TRAV_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PT2_PW_T_AMP_T_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PTN_PW_TRAINING, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PTO_PTO, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PTR_PW_TRAVEL, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PTT_PW_T_AMP_T, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PW_PW_REG_HRS, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PWO_PW_OT_HRS, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PWV_PW_VISIT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__TNO_TRAINING_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__TR_TRAVEL_TIME, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__TRN_TRAINING, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__TRO_TRAVEL_TIME_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__TT_TIME__AMP__TROUBLE, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__TTO_TIME_AMP_TRBLE_OT, '',''), ''''), 0) + 	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__VST_VISIT, '',''), ''''), 0)) AS NON_SERVICE_UNITS,
		SUM(NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PWS_PW_SICK, '',''), ''''), 0) + NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__S_SICK_LEAVE, '',''), ''''), 0)) AS SICK_HOURS,
		SUM(NVL(NULLIF(REPLACE(GROSS_PAY, '',''), ''''), 0)) AS GROSS_PAY,
		SUM(NVL(NULLIF(REPLACE(REGULAR_EARNINGS, '',''), ''''), 0)) AS REGULAR_EARNINGS,
		SUM(NVL(NULLIF(REPLACE(OVERTIME_EARNINGS, '',''), ''''), 0)) AS OVERTIME_EARNINGS,
		SUM(NVL(NULLIF(REPLACE(ADDITIONAL_EARNINGS__O_OTHER, '',''), ''''), 0) + NVL(NULLIF(REPLACE(ADDITIONAL_EARNINGS__O_OTHEREA, '',''), ''''), 0)) AS NON_SERVICE_PAY_AMOUNT,
		SUM(NVL(NULLIF(REPLACE(TOTAL_EMPLOYEE_TAX, '',''), ''''), 0)) AS TOTAL_EMPLOYEE_TAX,
		SUM(NVL(NULLIF(REPLACE(TAKE_HOME, '',''), ''''), 0)) AS TAKE_HOME,
		SUM(NVL(NULLIF(REPLACE(TOTAL_VOLUNTARY_DEDUCTIONS, '',''), ''''), 0)) AS TOTAL_VOLUNTARY_DEDUCTIONS
	FROM DISC_${var.SF_ENVIRONMENT}.ADP.OPALPAYROLL
	GROUP BY 1, 2, 3, 4, 5
)
SELECT DISTINCT 
--MASTER_ID,
--pay.WORKED_IN_DEPARTMENT,
	MD5(18 || PAY.COMPANY_CODE || PAY.PAY_DATE || PAY.CHECK_VOUCHER_NUMBER || COALESCE(EMP.MASTER_ID, PAY.FILE_NUMBER) || PAY.PERIOD_BEGINNING_DATE || ''OPAL'') AS PAYROLL_KEY,
	PAY.PAY_DATE::DATE AS REPORT_DATE,
	MD5(18 || PAY.COMPANY_CODE || COALESCE(EMP.MASTER_ID, PAY.FILE_NUMBER) || ''OPAL'') AS EMPLOYEE_KEY,
	BRANCH.BRANCH_KEY AS BRANCH_KEY,
	18 AS SOURCE_SYSTEM_ID,
	PAY.PAY_DATE::DATE AS PAYROLL_DATE,
	RIGHT(''000000'' || COALESCE(EMP.FILE_NUMBER, PAY.FILE_NUMBER), 6) AS EMPLOYEE_ID,
	BRANCH.BRANCH_NAME AS BRANCH_NAME,
	''ADP-OPAL-'' || PAY.COMPANY_CODE AS SYSTEM_CODE,
	PAY.PERIOD_BEGINNING_DATE::DATE AS PAY_PERIOD_START_DATE,
	PAY.PERIOD_ENDING_DATE::DATE AS PAY_PERIOD_END_DATE,
	PAY.CHECK_VOUCHER_NUMBER AS CHECK_NUMBER,
	PAYROLL.TOTAL_HOURS AS PAY_HOURS,
	PAYROLL.REGULAR_HOURS AS SERVICE_HOURS,
	PAYROLL.OVERTIME_HOURS AS OVERTIME_HOURS,
	PAYROLL.NON_SERVICE_UNITS AS NON_SERVICE_UNITS,
	NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__PWS_PW_SICK, '',''), ''''), 0) + NVL(NULLIF(REPLACE(ADDITIONAL_HOURS__S_SICK_LEAVE, '',''), ''''), 0) AS SICK_HOURS,
	NULL AS VACATION_HOURS,
	REPLACE(REPLACE(RATE, '',''), ''$'') AS PAY_RATE,
	REPLACE(PAYROLL.OVERTIME_EARNINGS, '','') / REPLACE(PAYROLL.OVERTIME_HOURS, '','') AS OVERTIME_RATE,
	PAYROLL.GROSS_PAY AS GROSS_PAY_AMOUNT,
	PAYROLL.REGULAR_EARNINGS AS SERVICE_PAY_AMOUNT,
	PAYROLL.OVERTIME_EARNINGS AS OVERTIME_PAY_AMOUNT,
	PAYROLL.NON_SERVICE_PAY_AMOUNT AS NON_SERVICE_PAY_AMOUNT,
	PAYROLL.TOTAL_EMPLOYEE_TAX AS TAX_AMOUNT,
	PAYROLL.TAKE_HOME AS NET_PAY_AMOUNT,
	PAYROLL.TOTAL_VOLUNTARY_DEDUCTIONS AS OTHER_DEDUCTIONS_AMOUNT,
	NULL AS UNION_DUES_AMOUNT,
	REPLACE(VOLUNTARY_DEDUCTION_FP_FP_REIMB, '','') AS REINBURSMENT_AMOUNT,
		:STR_ETL_TASK_KEY AS ETL_TASK_KEY,
		:STR_ETL_TASK_KEY AS ETL_INSERTED_TASK_KEY,
		CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_INSERTED_DATE,
		CURRENT_USER AS ETL_INSERTED_BY,
		CONVERT_TIMEZONE(''UTC'', CURRENT_TIMESTAMP)::TIMESTAMP_NTZ AS ETL_LAST_UPDATED_DATE,
		CURRENT_USER AS ETL_LAST_UPDATED_BY,
		FALSE AS ETL_DELETED_FLAG
FROM DISC_${var.SF_ENVIRONMENT}.ADP.OPALPAYROLL PAY
LEFT JOIN PAYROLL 
	ON PAYROLL.FILE_NUMBER = PAY.FILE_NUMBER AND PAYROLL.PAY_DATE = PAY.PAY_DATE AND PAYROLL.CHECK_VOUCHER_NUMBER = PAY.CHECK_VOUCHER_NUMBER AND PAYROLL.PERIOD_BEGINNING_DATE = PAY.PERIOD_BEGINNING_DATE AND PAYROLL.PERIOD_ENDING_DATE = PAY.PERIOD_ENDING_DATE
LEFT JOIN EMPLOYEE EMP
	ON EMP.FILE_NUMBER::INT = PAY.FILE_NUMBER AND EMP.COMPANY_CODE = PAY.COMPANY_CODE
LEFT JOIN DW_${var.SF_ENVIRONMENT}.HAH.DIM_BRANCH BRANCH
	ON BRANCH.OFFICE_NUMBER = COALESCE(EMP.HOME_DEPARTMENT_CODE, PAY.WORKED_IN_DEPARTMENT)::NUMBER
	AND BRANCH.SYSTEM_CODE ILIKE ''%ADP-OPAL%'';

RETURN ''SUCCESS'';

END;

 EOT
}

