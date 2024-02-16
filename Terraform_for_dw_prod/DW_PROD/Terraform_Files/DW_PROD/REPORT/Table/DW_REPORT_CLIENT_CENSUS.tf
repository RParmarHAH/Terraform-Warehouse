resource "snowflake_table" "DW_REPORT_CLIENT_CENSUS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CLIENT_CENSUS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CLIENT_CENSUS

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
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ORIGINAL_CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ORIGINAL_BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REVENUE_SUBCATEGORY_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICE_MONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "TERMINATED_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "REFERRAL_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "FIRST_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LAST_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "REACTIVATED_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "NEW_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "INCLUDE_FOR_OPS_PERF_CLIENTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INCLUDE_FOR_EXEC_OPS_CLIENTS"
	type = "BOOLEAN"
	nullable = true
}

}

