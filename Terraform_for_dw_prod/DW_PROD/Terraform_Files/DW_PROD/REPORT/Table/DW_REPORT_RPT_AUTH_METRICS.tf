resource "snowflake_table" "DW_REPORT_RPT_AUTH_METRICS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "RPT_AUTH_METRICS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.RPT_AUTH_METRICS

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
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "HOURS_SERVED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "SCHEDULE_HOURS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "HOURS_AUTHORIZED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "OVER_AUTHED_CONTRACT"
	type = "BOOLEAN"
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
	name = "PRE_AUTH_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BEGIN_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "END_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LATEST_AUTH_BEGIN_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LATEST_AUTH_END_DATE"
	type = "DATE"
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
	name = "EXP_AUTHS_DAYS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EXP_AUTHS"
	type = "VARCHAR(20)"
	nullable = true
}

}

