resource "snowflake_table" "DW_REPORT_CLIENTS_REFERRED_BKCP_07_27_2023" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CLIENTS_REFERRED_BKCP_07_27_2023"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CLIENTS_REFERRED_BKCP_07_27_2023

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
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "FIRST_CONTRACT_CODE"
	type = "VARCHAR(50)"
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
	name = "ORIGINAL_CLIENT_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ORIGINAL_CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ORIGINAL_SOURCE_SYSTEM_ID"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CLIENT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_HOME_PHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLIENT_WORK_PHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SUPERVISOR_KEY"
	type = "VARCHAR(32)"
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
	name = "FIRST_VISIT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LATEST_VISIT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "REFERRED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DAYS_TO_SERVICE"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "OPEN_REFERRAL"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "REFERRAL_AGE"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "FIRST_CONTRACT_BEGIN_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "OFFICE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_AREA"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CCU_AGREE_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CONTRACT_NUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "GAUR_NAME"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(75)"
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

