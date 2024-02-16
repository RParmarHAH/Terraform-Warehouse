resource "snowflake_table" "DW_REPORT_DISCOVERY_TO_BUSINESS_AUDIT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "DISCOVERY_TO_BUSINESS_AUDIT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.DISCOVERY_TO_BUSINESS_AUDIT

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
	name = "TASK"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DISC_DB"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DISC_PROD_SOURCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DISC_TABLE_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DW_PROD_TABLE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DW_DB"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DW_SOURCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DW_TABLE_COUNT"
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

