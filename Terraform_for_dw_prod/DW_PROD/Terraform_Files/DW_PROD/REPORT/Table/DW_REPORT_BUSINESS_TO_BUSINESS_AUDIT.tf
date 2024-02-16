resource "snowflake_table" "DW_REPORT_BUSINESS_TO_BUSINESS_AUDIT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "BUSINESS_TO_BUSINESS_AUDIT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.BUSINESS_TO_BUSINESS_AUDIT

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
	name = "TABLE_NAME"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DB"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DW_PROD_SOURCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PREVIOUS_DAY_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CURRENT_DAY_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "COUNT_DIFF"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PERCENT_OF_VARIANCE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INSERT_DATE"
	type = "DATE"
	nullable = true
}

}

