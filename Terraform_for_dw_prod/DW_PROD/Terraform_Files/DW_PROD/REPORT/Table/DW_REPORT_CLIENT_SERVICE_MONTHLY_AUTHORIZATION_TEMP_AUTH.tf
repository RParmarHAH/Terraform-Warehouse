resource "snowflake_table" "DW_REPORT_CLIENT_SERVICE_MONTHLY_AUTHORIZATION_TEMP_AUTH" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CLIENT_SERVICE_MONTHLY_AUTHORIZATION_TEMP_AUTH"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CLIENT_SERVICE_MONTHLY_AUTHORIZATION_TEMP_AUTH

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
	name = "FIRST_DAY_OF_MONTH"
	type = "DATE"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "AUTH_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "AUTH_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENT_SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ATYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PARTNER_CONTRACT_SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "AUTHORIZATION_MAX_UNITS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "AUTHORIZATION_MAX_UNITS_ADJUSTED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "AUTHDAYS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "PERIOD_BEGIN_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PERIOD_END_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PERIOD_ONHOLD_BEGIN_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PERIOD_ONHOLD_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ACTUALMONTHDAYS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "MONTHDAYSWOH"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "PERIOD_HOURS_AUTHORIZED_NON_ADJUSTED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "PERIOD_HOURS_AUTHORIZED"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "INVALID_FLAG"
	type = "BOOLEAN"
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


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

