resource "snowflake_table" "DW_REPORT_COVID_19_EVV_VISITS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "COVID_19_EVV_VISITS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.COVID_19_EVV_VISITS

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
	name = "STATE"
	type = "VARCHAR(2)"
	nullable = false
}


column {
	name = "OFFICENUMBER"
	type = "VARCHAR(3)"
	nullable = false
}


column {
	name = "OFFICENAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "SERVICEDATE"
	type = "DATE"
	nullable = false
}


column {
	name = "ZIP"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "CASECOUNT"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "TOTALSCHEDULES"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "HOURSMANAGED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "PENDING_MISSEDSCHEDULES"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "ONHOLDSCHEDULES"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "CANCELLEDSCHEDULES"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "VISITS_TOTALCONFIRMED"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "VISITS_AUTOCONFIRMED"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "VISITS_MANUALLYCONFIRMED"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(38)"
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

