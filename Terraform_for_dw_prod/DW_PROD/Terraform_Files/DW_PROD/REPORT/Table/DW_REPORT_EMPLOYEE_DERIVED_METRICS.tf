resource "snowflake_table" "DW_REPORT_EMPLOYEE_DERIVED_METRICS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "EMPLOYEE_DERIVED_METRICS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.EMPLOYEE_DERIVED_METRICS

    -- Purpose : Business Report Data Population

    -- Project : REPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "MDM_EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_PID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_CATEGORY"
	type = "VARCHAR(15)"
	nullable = true
	comment = "Corporate, Admin, Field"
}


column {
	name = "DERIVED_EMPLOYEE_CATEGORY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DERIVED_WORK_STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "EMPLOYEE_OFFICE_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_STATE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PRIMARY_SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PRIMARY_SUPERVISOR_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PRIMARY_SUPERVISOR_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "CURRENT_AGE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGE_AT_TERMINATION"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_HIRE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_REHIRE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_BENEFIT_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_CHECK_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_CHECK_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_WORKED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_TERMINATE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_HIRE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_LATEST_REHIRE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_REHIRE_FLAG"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "DERIVED_FIRST_CHECK_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_LAST_CHECK_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_FIRST_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_LAST_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DERIVED_LATEST_TERMINATE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "TENURE_IN_MONTHS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_TENURE_BUCKET"
	type = "VARCHAR(16)"
	nullable = true
}


column {
	name = "DAYS_INACTIVE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MONTHS_OF_ACTIVE_SERVICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DELIVERED_CLS_SERVICES_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DELIVERED_HH_SERVICES_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DELIVERED_HC_SERVICES_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DELIVERED_OTHER_SERVICES_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DAYS_SINCE_LAST_PAYCHECK"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACTIVE_EMPLOYEE_FLAG"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "DERIVED_ACTIVE_EMPLOYEE_FLAG"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "DERIVED_UNION_FLAG"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "PAYROLL_ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAYROLL_EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYROLL_SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PAYROLL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_EMPLOYEE_PID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PAYROLL_EMPLOYEE_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DERIVED_PAY_RATE_SALARY"
	type = "NUMBER(15,3)"
	nullable = true
	comment = "This column should be encoded, similar to SSN"
}


column {
	name = "DERIVED_PAY_RATE_HOURLY"
	type = "NUMBER(15,3)"
	nullable = true
	comment = "This column should be encoded, similar to SSN"
}


column {
	name = "DERIVED_PAY_RATE_AVG_HOURLY"
	type = "NUMBER(15,3)"
	nullable = true
	comment = "This column should be encoded, similar to SSN"
}


column {
	name = "DERIVED_PAY_RATE_MIN_HOURLY"
	type = "NUMBER(15,3)"
	nullable = true
	comment = "This column should be encoded, similar to SSN"
}


column {
	name = "DERIVED_PAY_RATE_MAX_HOURLY"
	type = "NUMBER(15,3)"
	nullable = true
	comment = "This column should be encoded, similar to SSN"
}


column {
	name = "DERIVED_EXEMPT_FLAG"
	type = "BOOLEAN"
	nullable = false
}


column {
	name = "TOTAL_WAGES_CURRENT_YEAR"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "TOTAL_WAGES_PREVIOUS_YEAR"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "TOTAL_WAGES_2_YEARS_PREVIOUS"
	type = "NUMBER(15,3)"
	nullable = true
}


column {
	name = "TOTAL_REG_HOURS_ROLLING_12_MONTHS"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "AVG_WEEKLY_REG_HOURS_ROLLING_12_MONTHS"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "TOTAL_OVERTIME_HOURS_ROLLING_12_MONTHS"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "AVG_WEEKLY_OVERTIME_HOURS_ROLLING_12_MONTHS"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "TOTAL_COMPENSATION_ROLLING_12_MONTHS"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "AVG_HOURLY_PAY_RATE_ROLLING_12_MONTHS"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "AVG_HOURLY_OVERTIME_RATE_ROLLING_12_MONTHS"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "BONUS_COMPENSATION_ROLLING_12_MONTHS"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "TOTAL_REG_HOURS_PREV_YR"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "AVG_WEEKLY_REG_HOURS_PREV_YR"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "TOTAL_OVERTIME_HOURS_PREV_YR"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "AVG_WEEKLY_OVERTIME_HOURS_PREV_YR"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "TOTAL_COMPENSATION_PREV_YR"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "AVG_HOURLY_PAY_RATE_PREV_YR"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "AVG_HOURLY_OVERTIME_RATE_PREV_YR"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "BONUS_COMPENSATION_PREV_YR"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "TOTAL_REG_HOURS_CURR_YR"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "AVG_WEEKLY_REG_HOURS_CURRENT_YR"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "TOTAL_OVERTIME_HOURS_CURR_YR"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "AVG_WEEKLY_OVERTIME_HOURS_CURRENT_YR"
	type = "NUMBER(7,2)"
	nullable = true
}


column {
	name = "TOTAL_COMPENSATION_CURR_YR"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "AVG_HOURLY_PAY_RATE_CURRENT_YR"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "AVG_HOURLY_OVERTIME_RATE_CURRENT_YR"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "BONUS_COMPENSATION_CURRENT_YR"
	type = "NUMBER(12,2)"
	nullable = true
}


column {
	name = "APPLICANT_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "APPLICANT_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLICANT_SOURCE_SYSTEM_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "APPLICANT_HIRED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DATE_APPLIED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "APPLICATION_TO_HIRE_DAYS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FIRST_SERVICE_AFTER_REHIRE"
	type = "DATE"
	nullable = true
}


column {
	name = "HIRE_TO_FIRST_SERVICE_DAYS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NEXT_SCHEDULED_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "APPLICATION_JOB_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PHONE1"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PHONE3"
	type = "VARCHAR(32)"
	nullable = true
}

}

