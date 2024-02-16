resource "snowflake_table" "DISC_ALAYACARE_VISIT_TEST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "VISIT_TEST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.VISIT_TEST

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
	name = "VISIT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IDACCOUNTTYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "GUID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_CODE_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "START_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FUNDER_LAST_UPDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HOLIDAY_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "VISIT_COMPUTED_RATE_UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_COMPUTED_RATE_BILLITEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_COMPUTED_RATE"
	type = "NUMBER(21,4)"
	nullable = true
}


column {
	name = "FACILITY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_COMPLETED"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_STATUS_REASON_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_IDUSER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_END_TIME_OFFSET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_IDMASTERACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_LAST_VIEWED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_HOURS_APPROVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_SERVICE_INSTRUCTIONS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_LAST_WORK_SESSION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_END_TIME_APPROVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_FIRST_WORK_SESSION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_START_TIME_OFFSET"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_RATE_BILL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_OP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_HOURS_BILL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_END_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_CANCELLED_CODE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_START_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_IS_LOCKED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_SERVICE_CODE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_CREATE_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_CHECK_HASH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_GUID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_LAST_EMAILED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_UPDATE_USER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_START_TIME_APPROVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_LAST_NOTIFICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_MODIFIED_SINGLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_IDPOSITION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_BREAK_MINUTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_IDDEPTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_SERVICE_RRULE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_UPDATE_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_USE_DEFAULT_DURATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_IDSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_LAST_ACCEPTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_DISPLAY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_CREATE_USER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_APPROVAL_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_FUNDER_VALIDATION_BLOCK_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_LAST_MODIFIED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_HOURS_PAY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_SCHEDULER_ITEM_CONFIRMED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IN_OUT_OF_RECURRENCE_STATUS"
	type = "VARCHAR(17)"
	nullable = true
}


column {
	name = "VISIT_RECURRENCE"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "IS_INVOICED"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "IS_PAID"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "VISIT_IN_FACILITY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_SEQUENCE_BY_CLIENT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_SEQUENCE_BY_CLIENT_SERVICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACCOUNT_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_VISIT_FACILITY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_MARKED_FOR_RESUBMISSION"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_WRITTEN_OFF"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ADL_COMPLETE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HAS_ADL"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HAS_NOTE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_NOTE_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BREAK_MINUTES"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "BREAK_HOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "VISIT_APPROVAL_STATUS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_HOURS_APPROVED"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "VISIT_HOURS_BILL"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "VISIT_BILL"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "VISIT_SCHEDULED_DURATION"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "VISIT_UNIT_QTY"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "VISIT_REVENUE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "VISIT_REVENUE_BREAKTIME"
	type = "FLOAT"
	nullable = true
}


column {
	name = "VISIT_MISSED_CLASS"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "VISIT_BILL_DURATION"
	type = "NUMBER(13,2)"
	nullable = true
}

}

