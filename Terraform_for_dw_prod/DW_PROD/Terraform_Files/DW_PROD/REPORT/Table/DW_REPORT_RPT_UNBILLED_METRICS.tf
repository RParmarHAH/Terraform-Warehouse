resource "snowflake_table" "DW_REPORT_RPT_UNBILLED_METRICS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "RPT_UNBILLED_METRICS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.RPT_UNBILLED_METRICS

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
	name = "SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "REPORT_DATE"
	type = "DATE"
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
	name = "BRANCH_SERVICE_LINE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "OFFICE_CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OFFICE_STATE_CODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "STATE_BRANCH"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REGION_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONTRACT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EMPLOYEENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SUPERVISOR_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SUPERVISOR_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATUS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATUS_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATUS_DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "NO_OF_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HOURS_SERVED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "UNBILLED_HRS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "BILLED_HRS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "UNUSED_HOURS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(100)"
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

}

