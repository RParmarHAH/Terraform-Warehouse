resource "snowflake_table" "DISC_ALAYACARE_EVV_VISIT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "EVV_VISIT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.EVV_VISIT

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
	name = "BRANCH_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ALAYACARE_CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ALAYACARE_EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ALAYACARE_FUNDER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ALAYACARE_FUNDER_STATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ALAYACARE_SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ALAYACARE_VISIT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_CODE_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BILL_CODE_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BILL_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_CODE_UNITS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BILL_CODE_IS_MIDNIGHT_RULE_APPLICABLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CANCELLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CANCEL_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CANCEL_CODE_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CANCEL_CODE_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CANCEL_CODE_IS_BILLABLE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIENT_AC_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_ADDRESS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_ADDRESS_SUITE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_ATTRIBUTES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "CLIENT_BIRTHDAY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_CITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_FIRST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_GENDER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_LAST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_PHONE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_PHONE_OTHER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_PHONE_PERSONAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_STATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_ZIP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_TIMEZONE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_DIAGNOSES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CREATED_ON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EMPLOYEE_AC_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EMPLOYEE_ATTRIBUTES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "EMPLOYEE_BIRTHDAY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EMPLOYEE_EMAIL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EMPLOYEE_GENDER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EMPLOYEE_LAST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EMPLOYEE_PHONE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EMPLOYEE_UPDATED_BY"
	type = "VARIANT"
	nullable = true
}


column {
	name = "EMPLOYEE_UPDATED_ON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FUNDER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VISIT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EVV_STATUS"
	type = "VARCHAR(250)"
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
	name = "UPDATED_BY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "UPDATED_ON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMEZONE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_NUMBER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_LINE_ITEM_NUMBER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_LINE_UNITS_BILLED"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INVOICE_LINE_RATE_BY_BILLING_INCREMENT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INVOICE_LINE_BILLING_INCREMENT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INVOICE_TOTAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_QUANTITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_QUANTITY_UNITS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INVOICE_UNIT_PRICE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLAIM_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLAIM_UPDATE_FLOW"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FUNDER_AC_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FUNDER_ADDRESS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FUNDER_ADDRESS_SUITE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FUNDER_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FUNDER_CITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FUNDER_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FUNDER_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FUNDER_STATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FUNDER_ZIP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICE_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICE_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICE_SERVICE_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_SERVICE_CODE_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICE_ATTRIBUTES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "WORK_SESSIONS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "TIMEKEEPING_FIRST_CLOCK_IN_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMEKEEPING_LAST_CLOCK_OUT_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMEKEEPING_ADJUSTED_START_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMEKEEPING_ADJUSTED_END_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMEKEEPING_IS_ADJUSTED_START_TIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TIMEKEEPING_IS_ADJUSTED_END_TIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARIANT"
	nullable = true
}


column {
	name = "EXCEPTIONS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "REFERRING_PROVIDER_NPI"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REFERRING_PROVIDER_FIRST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REFERRING_PROVIDER_LAST_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "INTERVENTIONS_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

