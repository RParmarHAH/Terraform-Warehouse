resource "snowflake_table" "DW_REPORT_CLIENTS_REFERRED_2_0" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CLIENTS_REFERRED_2_0"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CLIENTS_REFERRED_2_0

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
	name = "FIRST_CONTRACT_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_PARTNER_CONTRACT_SERVICE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "FIRST_ADJUSTED_AUTH_HOURS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "FIRST_NON_ADJUSTED_AUTH_HOURS"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "NEXT_SCHEDULED_VISIT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_NAME"
	type = "VARCHAR(3500)"
	nullable = true
}


column {
	name = "CLIENT_HOME_PHONE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENT_WORK_PHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(100)"
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
	name = "REFERRED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DAYS_TO_SERVICE"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "OPEN_REFERRAL"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "REFERRALS"
	type = "VARCHAR(10000)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}

}

