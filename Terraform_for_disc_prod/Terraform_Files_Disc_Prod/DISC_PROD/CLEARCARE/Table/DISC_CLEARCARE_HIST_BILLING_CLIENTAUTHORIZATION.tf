resource "snowflake_table" "DISC_CLEARCARE_HIST_BILLING_CLIENTAUTHORIZATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "HIST_BILLING_CLIENTAUTHORIZATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.HIST_BILLING_CLIENTAUTHORIZATION

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
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYER_CONTACT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PARENT_PAYER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AUTHORIZATION_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "INITIAL_HOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "LIVE_IN"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PERIOD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "STATUS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_RATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INSURANCE_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "REFERRER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROCEDURE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "MODIFIER1"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ICD9_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_RATE_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "MODIFIER2"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "MODIFIER3"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "MODIFIER4"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "BASED_ON"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INITIAL_VISITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_RATE_METHOD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_PRO_RATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REFERRING_PROVIDER_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SPLIT_PAYERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SPLIT_PAYER_PROFILE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SPLIT_UNITS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "SPLIT_RANGE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SPLIT_LIMIT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "SPLIT_UNITS_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SPLIT_LIMIT_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TOTAL_HOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "REMAINING_HOURS"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BILL_MILEAGE_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "REVENUE_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "REVENUE_CODE_DESC"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "HIPPS_CODE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TYPE_OF_BILL"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TYPE_OF_ADMISSION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SOURCE_OF_ADMISSION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PATIENT_STATUS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TREATMENT_AUTHORIZATION_CODES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SHOW_INSTEAD_OF_CLIENT_NAME_IN_BOX_58"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PERSON_RELATIONSHIP"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "POLICY_GROUP"
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
	name = "ICD9_CODE_2_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ICD9_CODE_3_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ICD9_CODE_4_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LEAVE_BOX_76_EMPTY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ICD10_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ICD10_CODE_2_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ICD10_CODE_3_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ICD10_CODE_4_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BILL_EXPENSES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ACCOUNT_NUMBER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DISPLAY_IN_FAMILY_ROOM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMPLOYMENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTO_ACCIDENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OTHER_ACCIDENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REMARKS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "INSURANCE_PLAN_OR_PROGRAM_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SERVICE_FACILITY_LOCATION_INFO_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IS_OTHER_PLAN"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "OTHER_INSURED_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "OTHER_POLICY_NUMBER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "OTHER_PLAN_NAME"
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

