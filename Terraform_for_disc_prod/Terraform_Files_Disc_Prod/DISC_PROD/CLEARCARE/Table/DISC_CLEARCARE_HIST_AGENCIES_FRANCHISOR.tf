resource "snowflake_table" "DISC_CLEARCARE_HIST_AGENCIES_FRANCHISOR" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "HIST_AGENCIES_FRANCHISOR"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.HIST_AGENCIES_FRANCHISOR

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
	name = "AGENCY_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "WEBSITE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SUBDOMAIN"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "BACKGROUND"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "LOGO"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PROVIDES_LOGIN_LINK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLING_POLICY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAY_POLICY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TIMEZONE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "BILL_DAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TABLETS_COUNT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CC_ACCOUNT_OWNER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ROUNDING"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ALWAYS_ROUND_TO_SCHEDULED_TIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SEND_MISSED_CLOCK_OUT_ALERTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLOCK_OUT_ALERT_MINUTES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TELEPHONY_NUMBER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "APPLY_PAGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORK_WEEK_START"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ALLOW_CAREGIVER_MOBILE_PHONE_CLOCKINS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LAST_ACTIVITY"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "STALE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CALENDAR_INTERVAL"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_FOR_MILEAGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_FOR_MILEAGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLING_ACCOUNTING_METHOD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_ACCOUNTING_METHOD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "QBO_CONNECTION_TICKET"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "QB_TOKEN"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CAREGIVER_EMPLOYMENT_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "COUNTRY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SHOW_CLIENT_EXTRA_FIELD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIENT_EXTRA_FIELD_LABEL"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SHOW_CAREGIVER_EXTRA_FIELD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVER_EXTRA_FIELD_LABEL"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "WEEKLY_REPORTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TOMORROW_SHIFTS_EMAILS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATUS_FOR_MISSED_SHIFTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MISSED_CLOCKIN_ALERTS_MINUTES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PREFERRED_CARE_FRANCHISE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOW_AD_HOC_CARELOGS"
	type = "BOOLEAN"
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
	name = "CARE_MANAGEMENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "QB_DO_INITAL_IMPORT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LIVE_IN_REMAINDER_HOURS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CUSTOM_FIELD_LABEL"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CUSTOM_FIELD_FOR_CAREGIVER"
	type = "BOOLEAN"
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
	name = "ESIGNATURE_CAREMANAGER_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TOTAL_TIME_INCREMENTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SET_RATES_BY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILLING_PRINT_INVOICES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTIVATE_SCHEDULER_FIELD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTIVATE_MARKETER_FIELD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTIVATE_PRIMARY_MANAGER_FIELD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACTIVATE_SECONDARY_MANAGER_FIELD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TEXT_MESSAGING_EMAILS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOW_CAREGIVER_RACE_FIELD"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAY_LIVE_IN_HOURS_TO_COUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "FORBID_MOBILE_CLOCK_IN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_BILL_PER_VISIT_DAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "GROUP_CHILDREN_CARELOGS_ON_INVOICES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GROUP_CHILDREN_CARELOGS_ON_BILLS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_EXCEL_EXPORT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_LIVE_IN_HOURS_TO_COUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "ASSIGN_QB_TIME_DATA_TO_CUSTOMERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "QB_MATCH_ON_PAYER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "QB_SETUP_STAGE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "QB_OWNER_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TRACK_RECEIVABLES_IN_CLEARCARE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NEW_INVOICES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICE_DUEDATE_TERMS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INVOICE_START_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TRAVEL_TIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRAVEL_TIME_MINUTES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TRAVEL_TIME_PAY_RATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INVOICE_TERMS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_FILTERING_BY_CLIENT_LOCATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICING_ALLOW_HISTORICAL_UPLOADS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICING_CHARGE_INTEREST"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICING_INTEREST_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "INVOICING_NUM_DAYS_INTEREST_BEGINS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PHONE_NUMBER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "FAX_NUMBER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "INVOICING_HIDE_CARELOG_HOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXPORT_WITH_EXTERNAL_ID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FAMILY_ROOM_CARE_LOGS_SHOW_COMMENTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLING_EXCEPTIONS_NOTE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "INVOICING_ALLOW_EMAIL_OPTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICING_ID_PREFIX"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DATE_LAST_TOMORROW_SHIFTS_EMAIL_SENT"
	type = "DATE"
	nullable = true
}


column {
	name = "SALESFORCE_SYNC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVER_AUTO_LOGOUT_TIME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INVOICING_TAX_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "INVOICING_COMPOUND_TAX_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "INVOICING_ROYALTY_PERCENTAGE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "CLOCK_IN_GRACE_MINUTES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLOCK_OUT_GRACE_MINUTES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FILTER_BY_LOCATIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOW_CAREGIVER_EXCEL_IMPORT_LINK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOW_MEDICATION_MANAGEMENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SALESFORCE_REALTIME_SYNC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_BILL_LIVE_IN_DAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_COMPANY_EXPORT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_SHOW_RATE_CODE_FIELDS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_MILEAGE_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_TRAVEL_TIME_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_EXPENSES_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_HOLIDAY_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_LIVE_IN_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_HOURLY_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_PER_VISIT_RATE_CODE"
	type = "VARCHAR(16383)"
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
	name = "INVOICING_TAX_CARELOGS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICING_TAX_MILEAGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICING_TAX_EXPENSES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOW_CLOCK_IN_ALERTS_CAREGIVER_INTERFACE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOW_CLOCK_IN_ALERTS_MOBILE_PHONE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOW_CLOCK_IN_ALERTS_UNKNOWN_NUMBER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXCLUDE_NON_HOURLY_FOR_OT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICING_HIDE_OVERDUE_STAMP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOW_MOBILE_PHONE_CLOCKINS_WITHOUT_CALLER_ID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SINGLE_SOURCE_PRICE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "SETUP_WIZARD_STATUS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "RATES_AND_AUTHORIZATIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DISPLAY_RATE_AMOUNTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GEOLOCATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STAGE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_OVERTIME_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_DOUBLE_OVERTIME_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_RATE_NUMBER_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_EXPORT_SPLIT_LIVE_IN_SHIFTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLING_INCLUDE_TRAILING_DAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOW_VOICE_MESSAGING_NEXT_CAREGIVER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "US_FEDERAL_TAX_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CMS_1500"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SINGLE_SOURCE_PASSWORD"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SINGLE_SOURCE_USERNAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SINGLE_SOURCE_CREDENTIALS_VALID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICE_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SINGLE_SOURCE_COMMISSION_PAYABLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOW_NON_HOURLY_AUTHORIZATIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_DEPT_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "AGENCY_NAME_FOR_REPORTING"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PREFER_SCHEDULED_TIME_WHEN_ROUNDING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILLING_EXPORT_TYPE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_EXPORT_TYPE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_EXTERNAL_ID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HIDE_FAMILY_ROOM_TOOLTIP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USE_REAL_SMS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TWILIO_NUMBER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AR_SCHEDULING_LIMIT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "CAREGIVER_EDIT_SHIFT_WINDOW"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DOUBLE_ALPHA_NUMERIC_PASSWORD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOCATION_NAME"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FAMILY_ROOM_SHOW_CAREGIVER_CONTACT_INFO"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FAMILY_ROOM_AVAILABLE_TABS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "FAMILY_ROOM_HIDDEN_TABS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TURN_ON_ADLS_SECTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TAGGING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOW_PAYMENTS_PER_ITEM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVER_REQUIRE_SHIFT_CONFIRMATIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRAVEL_TYPE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "USE_WHICH_SCHEDULER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SCHEDULING_HORIZON"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SALESFORCE_ACCOUNT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ZUORA_CONNECTION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ZUORA_ACCOUNT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ZUORA_CLIENT_RATE_PLAN_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ZUORA_CLIENT_PRODUCT_RATE_PLAN_CHARGE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HIGH_WATERMARK_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INVOICED_BY_ACCOUNTING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SPLIT_PAYER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVER_PORTAL_VIEW_OTHER_CAREGIVER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FACILITY_PAY_POLICY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FACILITY_PAY_THRESHOLD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INVOICE_SHOW_RATE_NAMES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_OVERTIME_HOLIDAY_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_DOUBLE_OVERTIME_HOLIDAY_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_PER_VISIT_HOLIDAY_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_PER_VISIT_OVERTIME_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_PER_VISIT_OVERTIME_HOLIDAY_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_PER_VISIT_DOUBLE_OVERTIME_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_PER_VISIT_DOUBLE_OVERTIME_HOLIDAY_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_JOB_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_LIVE_IN_HOLIDAY_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_LIVE_IN_OVERTIME_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_LIVE_IN_OVERTIME_HOLIDAY_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_LIVE_IN_DOUBLE_OVERTIME_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_LIVE_IN_DOUBLE_OVERTIME_HOLIDAY_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_RATE_OR_TOTAL"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_DEPT_CODE_PER_LOCATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_VISIT_NOTE_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ITEM_PAYROLL_RATE_NUMBER_CARE_LOGS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ITEM_PAYROLL_RATE_NUMBER_MILEAGE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ITEM_PAYROLL_RATE_NUMBER_EXPENSES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ITEM_PAYROLL_RATE_NUMBER_CREDITS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "RATE_NAMES_IN_CALENDARS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NEAT_CALENDARS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ZUORA_IPAD_RATE_PLAN_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ZUORA_IPAD_PRODUCT_RATE_PLAN_CHARGE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BURDEN_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TOMORROW_SHIFT_REMINDER_TIME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "HIDE_CAREGIVER_FROM_CUSTOMER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HIDE_CAREGIVER_INFO_FROM_CUSTOMER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_SHOW_DEPT_CODE_FIELDS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEFAULT_HOURLY_RATE_DEPARTMENT_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DEFAULT_LIVE_IN_RATE_DEPARTMENT_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DEFAULT_PER_VISIT_RATE_DEPARTMENT_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DEFAULT_VISIT_NOTE_RATE_DEPARTMENT_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DEFAULT_MILEAGE_RATE_DEPARTMENT_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DEFAULT_EXPENSE_RATE_DEPARTMENT_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DEFAULT_TRAVEL_TIME_RATE_DEPARTMENT_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TAX_JURISDICTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICING_HIDE_QUICKBOOKS_CARELOG_HOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICING_QUICKBOOKS_FULL_VISIT_NOTE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICING_INCLUDE_AGING_SUMMARY"
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
	name = "TRAVEL_PAY_REASONABLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRAVEL_PAY_REASONABLE_MINUTES"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "QOC_ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "QOC_AUTOMATIC_TASK_CREATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "QOC_ENABLE_CIC_TRACKING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "QOC_ENABLE_HSP_TRACKING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "E_PAY_ENABLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "E_PAY_ACCOUNT_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "E_PAY_ACCOUNT_TOKEN"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "E_PAY_MERCHANT_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "E_PAY_TERMINAL_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "E_PAY_SETTINGS_CONFIRMED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "E_PAY_ACTIVATED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTOPAY_ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_TRAVEL_TIME_OVERTIME_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PAYROLL_TRAVEL_TIME_DOUBLE_OVERTIME_RATE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "INVOICING_DISABLE_UNLOCKING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREDIT_CARDS_ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACH_ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADVANCE_BILLING_ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADVANCE_BILLING_IS_DEFAULT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYMENTS_DISABLE_UNLOCKING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_ALLOW_UNFINALIZING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADVANCE_BILLING_CALCULATION"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SHOW_CLIENT_INFO_IN_REMINDERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PATIENT_PHONE_NUMBER_DISPLAYS_IN_THE_PORTAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SAFETY_MODULE_ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RECRUITING_ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADVANCE_BILLING_SKIP_INTERVAL"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ADVANCE_BILLING_ADJUSTMENT_MODE_ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICING_COMPACT_LAYOUT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTOPAY_DAY_DELAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ES_ACTIVATION_STAGE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ALLOW_ALTERNATE_CLIENT_BILLING_TYPE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SEND_ACH_ALERTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CCOIS_ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HIDE_WORKSAFE_TAB"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PREPOPULATE_PEOPLEPICKERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLE_ADMIN_ALERT_SUBSCRIPTIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYROLL_EXPORT_TYPE_2_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_EXPORT_TYPE_3_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYROLL_EXPORT_TYPE_4_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACCOUNTING_PAGE_FILTER_GRANULARITY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DISABLE_AUTOMATIC_CLOCK_OUT_IN_FOR_BACK_TO_BACK_SHIFTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIENT_PLACES_ENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOW_AD_HOC_TELEPHONY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOW_AD_HOC_MOBILE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REQUIRE_CAREGIVER_TELEPHONY_PIN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PREVENT_AD_HOC_TELEPHONY_SHIFTS_EXCEEDING_AUTH_LIMITS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PREVENT_AD_HOC_MOBILE_SHIFTS_EXCEEDING_AUTH_LIMITS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ES_VENDOR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ENABLE_AGENCY_ADDRESS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DATE_DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "FRANCHISOR_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "IS_PREFERRED_CARE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAN_ACCESS_METRICS_DASHBOARD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RESTRICT_RATE_CATEGORIES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RATE_CATEGORIES_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RATE_CATEGORIES_REQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAN_ACCESS_CUSTOM_REPORTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ROYALTY_PERCENTAGE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "ROYALTIES_BASED_ON"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RESTRICT_REFERRAL_TYPES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RESTRICT_LOCATIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CUSTOM_FIELD_REQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CUSTOM_FIELD_REQUIRED_FOR_CAREGIVER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONCURRENT_GROUP_CARE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SEQUENTIAL_GROUP_CARE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ROUNDING_COMPLETED_SHIFTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TIERED_BY_HOURS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENABLE_FACILITY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOW_MOBILE_CLOCKIN_WITH_LOCATION_DISABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MOBILE_LOCATION_GEOFENCE_RADIUS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TRAVEL_PAY_CONSECUTIVE_SHIFTS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "USE_COMMUNITY_CARE_ALTERNATIVE_REVENUE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WALKME_VERSION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ECLAIM_INTEGRATED_PARTNER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ECLAIM_INTEGRATED_PARTNER_ACCOUNT"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "FAMILY_ROOM_SHOW_POSTED_PICTURES"
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

