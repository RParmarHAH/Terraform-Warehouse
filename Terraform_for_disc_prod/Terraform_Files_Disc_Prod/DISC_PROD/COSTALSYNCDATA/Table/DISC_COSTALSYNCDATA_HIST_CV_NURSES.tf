resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_NURSES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_NURSES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_NURSES

    -- Purpose : Discovery Data Population

    -- Project : COSTALSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(50)"
	nullable = false
}


column {
	name = "RECSTAT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ENTRY_USER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ENTRY_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATE_USER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "UPDATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "NURSE_ID"
	type = "VARCHAR(9)"
	nullable = false
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "MIDDLE_INITIAL"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "STREET_NAME"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "NURSE_SECONDARY_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "BIRTH_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SEX"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SALUTE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "MARITALSTATS_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "EMERGENCY_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CONTACT_PERSON"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "CAR_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "BEEPER_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "BEEPER_CODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "SPECIALTY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DDL_NURSE_STATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "NURSE_STATUS_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DEGREE"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "RESOURCE_CATEGORY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SERVICE_CATEGORY_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "HIRE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HIRE_COMMEMT"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "TERMINATION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TERMINATION_COMMENT"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "REVIEW_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REVIEW_COMMENT"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "REFERRING_SOURCE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CB_REFERRAL_CHECK"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_INSERVICE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_MEDICAL_TEST"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_JOB_DESCRIPTION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ADDL_CATEGORY_ARRAY4_1"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "ADDL_CATEGORY_ARRAY4_2"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "ADDL_CATEGORY_ARRAY4_3"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "ADDL_CATEGORY_ARRAY4_4"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "PREFERRENCE_LEVEL"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PREFER_LEVEL_NOTE40_ARR2_1"
	type = "VARCHAR(41)"
	nullable = true
}


column {
	name = "PREFER_LEVEL_NOTE40_ARR2_2"
	type = "VARCHAR(41)"
	nullable = true
}


column {
	name = "GENERAL_NOTE40_ARRAY2_1"
	type = "VARCHAR(41)"
	nullable = true
}


column {
	name = "GENERAL_NOTE40_ARRAY2_2"
	type = "VARCHAR(41)"
	nullable = true
}


column {
	name = "LOCATION_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "WORK_PHONE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "PRIMARY_DEPARTMENT"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SECONDARY_DEPARTMENT"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PROVIDER_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PAY_RATE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "ZONE_CODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CB_HIDE_PAYRATE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_OT_CALC_METHOD"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DDL_EMPLOYEE_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "FEDERAL_TAX_FILING_ST"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "FEDERAL_TAX_EXEMPTIONS"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "STATE_TAX_FILING_STATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "STATE_TAX_EXEMPTIONS"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "WORKED_STATE_TAX_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SUISDI_TAX_JURISDICTION"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "WORKSTATION_NAME"
	type = "VARCHAR(81)"
	nullable = true
}


column {
	name = "DISCIPLINE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CB_ONCALL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "EMPLOYEE_PROFILE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "EMPLOYEE_MANAGER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "FACILITY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "INTERFACE_UNIQUE_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "FIRST_PAYMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_PAYMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FIRST_CHARGE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_CHARGE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CB_CHECK_OVER_TIME"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "OVERTIME_CRITERIA_CODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "EMPLOYEE_RATING"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PTO_BALANCE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "BILLED_VISITS_FOR_VISIT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "BILLED_HOURS_FOR_VISIT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "BILLED_VISITS_FOR_HOURLY"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "BILLED_HOURS_FOR_HOURLY"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAID_VISITS_FOR_VISIT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAID_HOURS_FOR_VISIT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAID_VISITS_FOR_HOURLY"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAID_HOURS_FOR_HOURLY"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "EMPLOYEE_STATUS_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE_CODE"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "TOTAL_BILLED_HOURS"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "TOTAL_BILLED_UNITS"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "TOTAL_PAID_HOURS"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "TOTAL_PAID_UNITS"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PREV_NAME"
	type = "VARCHAR(101)"
	nullable = true
}


column {
	name = "ETHNICITY_LEVEL1"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "ETHNICITY_LEVEL2"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
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

