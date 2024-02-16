resource "snowflake_table" "DW_REPORT_CLIENT_TENURE_DERIVED_MONTHLY_METRICS_BKCP_11242023" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CLIENT_TENURE_DERIVED_MONTHLY_METRICS_BKCP_11242023"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CLIENT_TENURE_DERIVED_MONTHLY_METRICS_BKCP_11242023

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
	name = "SERVICE_MONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "FIRST_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LATEST_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "TENURE_OF_SERVICE_MONTHS"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "CLIENT_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENT_AGE_AS_OF_SERVICE_MONTH"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}

}

