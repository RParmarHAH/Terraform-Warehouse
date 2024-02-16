resource "snowflake_table" "DW_REPORT_PAYPERIOD_GROUP" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "PAYPERIOD_GROUP"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.PAYPERIOD_GROUP

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
	name = "OFFICE_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PAYPERIODFREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYPERIOD_FIRST_DAY"
	type = "VARCHAR(3)"
	nullable = true
}

}

