resource "snowflake_table" "DW_REPORT_CLIENT_DERIVED_MONTHLY_VISIT_METRICS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CLIENT_DERIVED_MONTHLY_VISIT_METRICS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CLIENT_DERIVED_MONTHLY_VISIT_METRICS

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
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "REFERRAL_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LIFETIME_FIRST_SERVICE_MONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "LIFETIME_LAST_SERVICE_MONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "LIFETIME_TENURE_IN_MONTHS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LIFETIME_NUMBER_MONTHS_WITH_SERVICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LIFETIME_NUMBER_MONTHS_WO_SERVICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LIFETIME_NUMBER_OF_GAPS_IN_SERVICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LIFETIME_SMALLEST_GAP_IN_SERVICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LIFETIME_LARGEST_GAP_IN_SERVICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NEW_CLIENT_FLAG"
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
	name = "SUM_OF_HOURS_RECEIVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "PREVIOUS_MONTH_SUM_OF_HOURS_RECEIVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "PREVIOUS_2_MONTH_SUM_OF_HOURS_RECEIVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NEXT_MONTH_SUM_OF_HOURS_RECEIVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NEXT_2_MONTH_SUM_OF_HOURS_RECEIVED"
	type = "NUMBER(9,3)"
	nullable = true
}


column {
	name = "NUMBER_OF_HC_VISITS"
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
	name = "SUM_OF_NS_HOURS_SERVED"
	type = "NUMBER(9,3)"
	nullable = true
}

}

