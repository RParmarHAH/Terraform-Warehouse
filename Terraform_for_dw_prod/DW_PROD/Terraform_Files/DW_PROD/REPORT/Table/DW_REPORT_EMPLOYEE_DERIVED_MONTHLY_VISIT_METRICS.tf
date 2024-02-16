resource "snowflake_table" "DW_REPORT_EMPLOYEE_DERIVED_MONTHLY_VISIT_METRICS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "EMPLOYEE_DERIVED_MONTHLY_VISIT_METRICS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.EMPLOYEE_DERIVED_MONTHLY_VISIT_METRICS

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
	name = "SERVICE_MONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
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
	name = "PAYROLL_ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EMPLOYEE_CATEGORY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "DERIVED_EMPLOYEE_CATEGORY"
	type = "VARCHAR(15)"
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
	name = "EMPLOYEE_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "EMPLOYEE_ETHNICITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BRANCH_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "FIRST_SERVICE_MONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "LAST_SERVICE_MONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "TENURE_IN_MONTHS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_MONTHS_WITH_SERVICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_MONTHS_WO_SERVICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_GAPS_IN_SERVICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SMALLEST_GAP_IN_SERVICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LARGEST_GAP_IN_SERVICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NEW_HIRE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FIRST_MONTH_INACTIVE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTIVE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REACTIVATED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NUMBER_OF_SERVICE_LINES_PROVIDED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HC_SERVICE_LINE_PROVIDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HH_SERVICE_LINE_PROVIDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLS_SERVICE_LINE_PROVIDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NA_SERVICE_LINE_PROVIDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_SERVICE_LINE_PROVIDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NS_SERVICE_LINE_PROVIDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTHER_SERVICE_LINE_PROVIDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NUMBER_OF_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PREVIOUS_MONTH_NUMBER_OF_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PREVIOUS_2_MONTH_NUMBER_OF_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NEXT_MONTH_NUMBER_OF_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NEXT_2_MONTH_NUMBER_OF_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_DISTINCT_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PREVIOUS_MONTH_NUMBER_OF_DISTINCT_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PREVIOUS_2_MONTH_NUMBER_OF_DISTINCT_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NEXT_MONTH_NUMBER_OF_DISTINCT_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NEXT_2_MONTH_NUMBER_OF_DISTINCT_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SUM_OF_HOURS_SERVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "PREVIOUS_MONTH_SUM_OF_HOURS_SERVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "PREVIOUS_2_MONTH_SUM_OF_HOURS_SERVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NEXT_MONTH_SUM_OF_HOURS_SERVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NEXT_2_MONTH_SUM_OF_HOURS_SERVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NUMBER_OF_HC_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_DISTINCT_HC_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SUM_OF_HC_HOURS_SERVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NUMBER_OF_HH_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_DISTINCT_HH_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SUM_OF_HH_HOURS_SERVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NUMBER_OF_CLS_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_DISTINCT_CLS_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SUM_OF_CLS_HOURS_SERVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NUMBER_OF_NA_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_DISTINCT_NA_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SUM_OF_NA_HOURS_SERVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NUMBER_OF_IS_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_DISTINCT_IS_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SUM_OF_IS_HOURS_SERVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NUMBER_OF_NS_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_DISTINCT_NS_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SUM_OF_NS_HOURS_SERVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NUMBER_OF_OTHER_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_DISTINCT_OTHER_CLIENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SUM_OF_OTHER_HOURS_SERVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "FUTURE_HOURS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "HOURS_MISSED"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "FUTURE_VISITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "VISITS_MISSED"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ACQUIRED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYEE_ACQUISITION_NAME"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "UNION_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REHIRED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REHIRED_DATE"
	type = "DATE"
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
	name = "DERIVED_FIRST_SERVICE_DATE"
	type = "DATE"
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
	name = "OVER_TIME_HOUR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BOE_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

