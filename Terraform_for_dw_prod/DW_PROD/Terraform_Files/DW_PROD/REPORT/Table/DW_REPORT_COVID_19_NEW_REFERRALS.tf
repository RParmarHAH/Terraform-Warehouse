resource "snowflake_table" "DW_REPORT_COVID_19_NEW_REFERRALS" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "COVID_19_NEW_REFERRALS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.COVID_19_NEW_REFERRALS

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
	name = "OFFICE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "CLIENT_NAME"
	type = "VARCHAR(200)"
	nullable = false
}


column {
	name = "YEAR"
	type = "NUMBER(4,0)"
	nullable = false
}


column {
	name = "MONTH"
	type = "NUMBER(2,0)"
	nullable = false
}


column {
	name = "PERIOD_BEGIN_DATE"
	type = "DATE"
	nullable = false
}


column {
	name = "PERIOD_NAME"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "IS_ACTIVE"
	type = "VARCHAR(3)"
	nullable = false
}


column {
	name = "REFERRAL_DATE"
	type = "DATE"
	nullable = false
}


column {
	name = "FIRST_DATE_OF_SERVICE"
	type = "DATE"
	nullable = true
}


column {
	name = "DAYS_TO_SERVICE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "HASNOSCHEDULEANDSERVICE"
	type = "VARCHAR(3)"
	nullable = false
}


column {
	name = "HASSCHEDULE"
	type = "VARCHAR(3)"
	nullable = false
}


column {
	name = "HASSCHEDULEBUTNOSERVICE"
	type = "VARCHAR(3)"
	nullable = false
}


column {
	name = "AGINGBUCKET"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "VISITS_SCHEDULED"
	type = "NUMBER(20,0)"
	nullable = true
}


column {
	name = "VISITS_COMPLETED"
	type = "NUMBER(20,0)"
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

