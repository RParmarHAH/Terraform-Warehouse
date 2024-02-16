resource "snowflake_table" "DISC_ALAYACARE_AVAILABILITY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "AVAILABILITY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.AVAILABILITY

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
	name = "AVAILABILITY_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "AVAILABILITY_GUID_TO"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICECODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AVAILABILITY_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AVAILABILITY_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EVENT_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EVENT_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AVAILABILITY_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "AVAILABILITY_FREQUENCY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "AVAILABILITY_INTERVAL"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EVENT_DURATION_PAID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AVAILABILITY_DISABLED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TIME_OFF_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EVENT_DURATION"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AVAILABILITY_DAYS"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "AVAILABILITY_DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "AVAILABILITY_DAYS_LIST"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "IS_DELETED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_DESCRIPTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_DISABLED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_DURATION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_GUID_TO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_RRULE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_SCHEDULED_TO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_START_AT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SCHEDULE_RRULES_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UNAVAILABILITY_RRULES_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UNAVAILABILITY_RRULES_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UNAVAILABILITY_RRULES_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UNAVAILABILITY_RRULES_DURATION_PAID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UNAVAILABILITY_RRULES_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UNAVAILABILITY_RRULES_IS_DELETED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UNAVAILABILITY_RRULES_SCHEDULE_RRULE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UNAVAILABILITY_RRULES_TIME_OFF_TYPE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UNAVAILABILITY_RRULES_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UNAVAILABILITY_RRULES_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_AVAILABILITY_RRULES"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PROPERTIES_TIME_OFF_TYPES_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TIME_OFF_TYPES_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TIME_OFF_TYPES_DAY_DURATION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TIME_OFF_TYPES_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TIME_OFF_TYPES_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TIME_OFF_TYPES_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TIME_OFF_TYPES_PAY_SCHEDULE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TIME_OFF_TYPES_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TIME_OFF_TYPES_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_EVENTS_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_EVENTS_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_EVENTS_CREATED_AT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_EVENTS_DURATION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_EVENTS_END_AT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_EVENTS_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_EVENTS_RRULE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_EVENTS_START_AT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_EVENTS_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_EVENTS_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_EVENTS_UPDATED_AT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_TIME_OFF_EVENTS_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_TIME_OFF_EVENTS_CALENDAR_EVENT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_TIME_OFF_EVENTS_DURATION_PAID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CALENDAR_TIME_OFF_EVENTS_DURATION_BREAKDOWNS"
	type = "VARCHAR(250)"
	nullable = true
}

}

