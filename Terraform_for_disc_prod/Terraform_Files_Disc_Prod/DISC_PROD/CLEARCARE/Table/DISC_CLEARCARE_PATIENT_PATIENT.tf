resource "snowflake_table" "DISC_CLEARCARE_PATIENT_PATIENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "PATIENT_PATIENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.PATIENT_PATIENT

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
	name = "DATE_DEACTIVATED"
	type = "DATE"
	nullable = true
}


column {
	name = "DEACTIVATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POLICY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RATE_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CUSTOM_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "LOCATION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IS_CLIENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REFERRER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CONVERSION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PRIMARY_CARE_MANAGER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SECONDARY_CARE_MANAGER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CUSTOM_FIELD_VALUE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAST_CARELOG_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ESIGNATURE_CLIENT_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ESIGNATURE_CAREGIVER_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CARE_MANAGEMENT_RATE_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CARE_MANAGEMENT_RATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CARE_MANAGEMENT_CUSTOM_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "MARKETER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SCHEDULER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PRIMARY_MANAGER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SECONDARY_MANAGER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DEACTIVATION_REASON"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROSPECT_DATE_CREATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CLIENT_DATE_CREATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "PATIENT_UPDATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CHARGE_TAX"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICE_DUEDATE_TERMS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IN_FACILITY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTO_CLOCK_IN_STATUS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYER_CONTACT_ID"
	type = "NUMBER(38,0)"
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
	name = "TAX_JURISDICTION"
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
	name = "QOC_CONSENT_PROVIDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYMENT_PORTAL_PAYMENT_METHODS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_BILLING_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CUSTOM_FIELD_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CUSTOM_FIELD_CONTENT_TYPE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "META"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "IS_PLACE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHIFT_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "GROUP_CONCURRENT_INVOICE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TYPE_OF_CARE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MOBILE_LOCATION_GEOFENCE_RADIUS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PLACE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PATIENT_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "COMMUNITY_ROOM_DETAILS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DATE_DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "DEFAULT_COMMUNITY_TASK_SET_ID"
	type = "NUMBER(32,0)"
	nullable = true
}


column {
	name = "ADD_SURCHARGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TASKS_BUILD_STARTED"
	type = "DATE"
	nullable = true
}


column {
	name = "DISABLE_MISSED_CLOCK_INOUT_ALERTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CUID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TAX_JURISDICTION_CUID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "A_R_ANALYST_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SECONDARY_MARKETER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SECONDARY_SCHEDULER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IS_AUTO_CLOCK_IN"
	type = "BOOLEAN"
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

