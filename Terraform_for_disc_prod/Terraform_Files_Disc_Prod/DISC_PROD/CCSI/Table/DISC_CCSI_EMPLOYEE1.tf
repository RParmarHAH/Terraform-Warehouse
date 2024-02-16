resource "snowflake_table" "DISC_CCSI_EMPLOYEE1" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "EMPLOYEE1"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.EMPLOYEE1

    -- Purpose : Discovery Data Population

    -- Project : CCSI

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORD_NUMBER"
	type = "VARCHAR(9999999)"
	nullable = true
}


column {
	name = "EMPLOYEE_NUMBER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EMPLOYEE_NAME"
	type = "VARCHAR(9999999)"
	nullable = true
}


column {
	name = "HOURLY_RATE_SERVICE_TYPE_25"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "OVERTIME_RATE_TRAINING"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SPECIAL_RATE_SERVICE_TYPE_21"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PHONENUMBER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "LEVEL_OF_TRAINING"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PHYSICAL_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "TB_TEST_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DISCIPLINARY_LEVEL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FEDERAL_DEDUCTIONS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STATE_DEDUCTIONS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DATE_OF_BIRTH"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FIRST_DAY_OF_WORK_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "HIRE_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "MAIL_CHECK_TO_EMPLOYEE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "REHIRE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "I_9"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DESIRES_MORE_HOURS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REQUIRES_HOMEMAKER_DOCS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TERMINATION_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PROBATIONARY_EVALUATION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PERSONALCELL_OPT_IN"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "MARITAL_STATUS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FED_EXTRA"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STATE_EXTRA"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "POSITION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "NEW_RECORD"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "WORKING_AS_HOMEMAKER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SUPERVISORY_DESK"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CURRENCY_EXCHANGE_PREFERENCE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_AM_PHONE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLIENT_PM_PHONE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "INACTIVE_FIELD"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INACTIVE_DATE_AND_INFO"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PHONE_RELEASE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "INS_CODE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "INS_AMT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PUBLIC_AID"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PUBLIC_AID_OFFICE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "NOTIFIED_TERMED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DLN"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "EXPIRES"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "AUTO_INS_EXPIRES"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "BACKGROUND_STATUS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPLOAD_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "MIDDLE_INITIAL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "SEX"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "RACE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CELLPHONE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "FINGERPRINTED"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FP_RESPONSE_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FP_VERIFIED_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "RELOOK_FLAG"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "NOTPAID_COUNTER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FAMILY_CARE_GIVER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "AREA"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "LAST_PAID"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "REGION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CALL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "INFLUENZA_SHOT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "OTY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "PRE_EMPID"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "HAS_SMARTPHONE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(200)"
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
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

