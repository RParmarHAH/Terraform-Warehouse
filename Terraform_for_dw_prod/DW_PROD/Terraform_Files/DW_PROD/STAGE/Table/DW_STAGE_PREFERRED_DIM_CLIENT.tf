resource "snowflake_table" "DW_STAGE_PREFERRED_DIM_CLIENT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "PREFERRED_DIM_CLIENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.STAGE.PREFERRED_DIM_CLIENT

    -- Purpose : Business Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = false
}


column {
	name = "CLIENT_NUMBER"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(20)"
	nullable = false
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "CLIENT_PID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_MEDICARE_ID"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MEDICAID_ID"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CLIENT_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENT_DATE_OF_DEATH"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENT_GENDER"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "CLIENT_ETHNICITY"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "HISPANIC_OR_LATINO"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIENT_GENDER_IDENTITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_SEXUAL_ORIENTATION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_RACE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_MARITAL_STATUS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLIENT_SALUTATION"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLIENT_FIRST_NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CLIENT_MIDDLE_NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CLIENT_LAST_NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CLIENT_NAME"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "CLIENT_ADDRESS1"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "CLIENT_ADDRESS2"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "CLIENT_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_STATE_CODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "CLIENT_ZIP"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "CLIENT_CLN_ADDRESS1"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLIENT_CLN_ADDRESS2"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLIENT_CLN_CITY"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "CLIENT_CLN_STATE_CODE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENT_CLN_ZIP"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENT_STD_ADDRESS1"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CLIENT_STD_ADDRESS2"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CLIENT_STD_CITY"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENT_STD_STATE_CODE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENT_STD_ZIP"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENT_HOME_PHONE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENT_CELL_PHONE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENT_WORK_PHONE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CLIENT_FAX_NUMBER"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CLIENT_PERSONAL_EMAIL"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "REFERRAL_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DAYS_TO_SERVICE"
	type = "NUMBER(38,3)"
	nullable = true
}


column {
	name = "CONTRACT_BEGIN_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CONTRACT_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "FIRST_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LAST_SERVICE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "BEGIN_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ACTIVE_CLIENT_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIENT_STATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DISCHARGE_REASON"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "ON_HOLD_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ON_HOLD_START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ON_HOLD_END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "LINKED_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACQUIRED_FROM_COMPANY_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "ACQUIRED_FROM_COMPANY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ACQUIRED_FROM_COMPANY_FULL_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACQUISITION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ACQUISITION_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ADMISSION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ADMISSION_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIENT_CONVERTED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PRIMARY_SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PRIMARY_SUPERVISOR_CODE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PRIMARY_SUPERVISOR_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SECONDARY_SUPERVISOR_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SECONDARY_SUPERVISOR_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "SECONDARY_SUPERVISOR_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRIMARY_BRANCH_STATE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "GUARANTOR_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(10000)"
	nullable = true
}


column {
	name = "AGENCY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "REFERRER_KEY"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "EFFECTIVE_FROM_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "EFFECTIVE_TO_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
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


column {
	name = "ETL_INFERRED_MEMBER_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

