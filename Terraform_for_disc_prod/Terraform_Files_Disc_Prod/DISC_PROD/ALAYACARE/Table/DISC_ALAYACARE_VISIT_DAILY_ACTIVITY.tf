resource "snowflake_table" "DISC_ALAYACARE_VISIT_DAILY_ACTIVITY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "VISIT_DAILY_ACTIVITY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.VISIT_DAILY_ACTIVITY

    -- Purpose : Discovery Data Population

    -- Project : ALAYACARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "VISIT_ADL_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_CREATED_AT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_UPDATED_AT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_COMPLETION_CONTEXT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_SCHEDULE_ITEM_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_UPDATED_BY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_POSITION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_COMPLETED_BY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_COMPLETED_AT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_COMMENT"
	type = "VARCHAR(15000)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_COMPLETED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_DAILY_ACTIVITY_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_IS_AD_HOC"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_WORK_SESSION_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_PROPERTIES_CREATED_BY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_RECURRENCE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_CAREPLAN_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_CREATED_AT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_IS_REQUIRED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_TIMEZONE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_IS_FROM_LIBRARY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_EXTERNAL_LINK_URL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_HAS_DURATION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_EXTERNAL_LINK_LABEL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_WEEKDAYS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_UPDATED_BY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_FREQUENCY_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_INTERVAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_CATEGORY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_START_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_LATEST_REVISION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_UPDATED_AT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_COUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_CLIENT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_CREATED_BY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_INCLUDE_485"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_RANK"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_DESCRIPTION"
	type = "VARCHAR(15000)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ADL_PROPERTIES_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ADL_CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISIT_ADL_UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISIT_ADL_START_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISIT_ADL_END_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

