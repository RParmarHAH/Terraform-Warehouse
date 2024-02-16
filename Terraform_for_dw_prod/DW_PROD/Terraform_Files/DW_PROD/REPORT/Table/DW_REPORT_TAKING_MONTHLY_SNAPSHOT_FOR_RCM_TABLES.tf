resource "snowflake_table" "DW_REPORT_TAKING_MONTHLY_SNAPSHOT_FOR_RCM_TABLES" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "TAKING_MONTHLY_SNAPSHOT_FOR_RCM_TABLES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.TAKING_MONTHLY_SNAPSHOT_FOR_RCM_TABLES

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
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BEFORE_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AFTER_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "START_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}

}

