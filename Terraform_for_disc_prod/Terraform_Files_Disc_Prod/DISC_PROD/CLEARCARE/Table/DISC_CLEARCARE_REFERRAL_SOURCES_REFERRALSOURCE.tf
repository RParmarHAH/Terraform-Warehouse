resource "snowflake_table" "DISC_CLEARCARE_REFERRAL_SOURCES_REFERRALSOURCE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "REFERRAL_SOURCES_REFERRALSOURCE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.REFERRAL_SOURCES_REFERRALSOURCE

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
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROSPECT_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CAREGIVER_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "APPLICANT_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UNIQUE_KEY"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "UPDATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "REFERRAL_SOURCE_TYPE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LIFETIME_VALUE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "OWNER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACTIVITY_ALERT_DAYS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACTIVITY_ALERT_DAYS_MODIFIED"
	type = "DATE"
	nullable = true
}


column {
	name = "WEB_ADDRESS"
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
	name = "COMMUNITY_COUNT"
	type = "NUMBER(38,0)"
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

