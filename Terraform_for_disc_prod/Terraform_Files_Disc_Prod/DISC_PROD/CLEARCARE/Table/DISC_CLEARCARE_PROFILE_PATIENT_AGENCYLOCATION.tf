resource "snowflake_table" "DISC_CLEARCARE_PROFILE_PATIENT_AGENCYLOCATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "PROFILE_PATIENT_AGENCYLOCATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.PROFILE_PATIENT_AGENCYLOCATION

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
	name = "ADDRESS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ADDRESS_LINE_2"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "HOME_PHONE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "MOBILE_PHONE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "WORK_PHONE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PHOTO"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "IS_AUTHORIZED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTHORIZED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "COMPANY_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "MIDDLE_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "AGENCY_ADMIN_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PATIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CAREGIVER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TIMEZONE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "COMPANY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IS_COMPANY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMAIL_VALID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SEND_SMS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CARRIER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SMS_VALID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SEND_ALERTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "FAX_PHONE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "EXTRA_FIELD"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PIN"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "QB_LIST_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ESIGNATURE_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SEND_ESIG_NOTIFICATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ESIGNATURE_TURNON_DATE"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "ESIGNATURE_ADMIN_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "IMPORT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REFERRAL_SOURCE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DERIVED_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "QB_PERSON_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "QB_ADD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXTERNAL_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "EMAIL_INVOICES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GEOLOCATION_ID"
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
	name = "KPI_DASHBOARD_STATE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "UNSUBSCRIBE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "EMAIL_CONFIRMED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "EMAIL_CONFIRMATION_SENT"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "EMAIL_CONFIRMATION_REQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMAIL_UNSUBSCRIBED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "EMAIL_UNSUBSCRIBED_REASON"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SMS_CONFIRMED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "SMS_CONFIRMATION_REQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SMS_CONFIRMATION_SENT"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "SMS_UNSUBSCRIBED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "SMS_UNSUBSCRIBED_REASON"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PARENT_PAYER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAST_STATUS_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAST_STATUS_TEXT"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "LAST_CONTACT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "MOBILE_PHONE_TELEPHONY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORK_PHONE_TELEPHONY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SALESFORCE_CONTACT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_HOLIDAY_RATE"
	type = "BOOLEAN"
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
	name = "ADVANCE_BILLING_ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADVANCE_BILLING_ADJUSTMENT_MODE_ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NO_MIDDLE_NAME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REMITTANCE_ADDRESS_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DATE_DELETED"
	type = "TIMESTAMP_TZ(9)"
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
	name = "TAX_JURISDICTION"
	type = "VARCHAR(16383)"
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
	name = "NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "USE_AS_CLASS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_DEPT_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_BRANCH_ID"
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
	name = "CREATED_LOCAL"
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

