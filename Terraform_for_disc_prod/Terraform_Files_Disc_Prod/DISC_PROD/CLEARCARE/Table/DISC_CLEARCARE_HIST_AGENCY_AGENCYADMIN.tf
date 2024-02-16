resource "snowflake_table" "DISC_CLEARCARE_HIST_AGENCY_AGENCYADMIN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "HIST_AGENCY_AGENCYADMIN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.HIST_AGENCY_AGENCYADMIN

    -- Purpose : Discovery Data Population

    -- Project : CLEARCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "USER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "GROUP_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HIDE_ALL_RATES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALERT_UNSUCCESSFUL_LOGIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SEND_INVOICE_REPLIES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUPER_ADMIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACCOUNT_OWNER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UPDATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CAN_RATE_CAREGIVERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MY_AGENCY_DASHBOARD_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMAIL_SIGNATURE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "LIVEDASH_DEFAULTS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "ORIGINATOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAST_UPDATED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DELETED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "READ_ONLY_ACCESS_TO_ACCOUNTING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKERS_COMP_CLASS_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_METHOD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_RATE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HOURS_PER_WEEK"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SEND_ACH_ALERTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATUS_IO_SUBSCRIBER_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "INDIVIDUAL_RATE_POLICY_AND_SERVICE_AUTH_PAGES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SEARCH_PREFERENCES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DATE_DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "FRANCHISOR_ID"
	type = "NUMBER(38,0)"
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

