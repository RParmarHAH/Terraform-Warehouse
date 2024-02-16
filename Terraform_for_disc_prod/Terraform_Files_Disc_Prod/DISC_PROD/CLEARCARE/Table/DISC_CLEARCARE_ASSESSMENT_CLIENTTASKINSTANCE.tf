resource "snowflake_table" "DISC_CLEARCARE_ASSESSMENT_CLIENTTASKINSTANCE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "ASSESSMENT_CLIENTTASKINSTANCE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.ASSESSMENT_CLIENTTASKINSTANCE

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
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PLACE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_TASK_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TASK_DATE"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "STATUS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CAREGIVER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACKNOWLEDGE_AT"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CARE_LOG_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CAREGIVER_INSTRUCTION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "START_TIME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SHIFT_RANGE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RATE_SCHEDULE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "DURATION"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "COMMUNITY_TASK_SET_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
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

