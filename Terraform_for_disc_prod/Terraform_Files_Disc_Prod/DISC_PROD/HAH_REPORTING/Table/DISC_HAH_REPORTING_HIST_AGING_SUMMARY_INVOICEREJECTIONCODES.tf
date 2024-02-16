resource "snowflake_table" "DISC_HAH_REPORTING_HIST_AGING_SUMMARY_INVOICEREJECTIONCODES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HAH_REPORTING"
	name = "HIST_AGING_SUMMARY_INVOICEREJECTIONCODES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HAH_REPORTING.HIST_AGING_SUMMARY_INVOICEREJECTIONCODES

    -- Purpose : Discovery Data Population

    -- Project : HAH_REPORTING

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DFDB"
	type = "VARCHAR(12)"
	nullable = false
}


column {
	name = "CODE"
	type = "VARCHAR(12)"
	nullable = false
}


column {
	name = "REASON"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

