resource "snowflake_table" "DISC_CLEARCARE_CAREGIVER_CAREGIVER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "CAREGIVER_CAREGIVER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.CAREGIVER_CAREGIVER

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
	name = "RATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "POLICY_ID"
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
	name = "EMPLOYMENT_TYPE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LOCATION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IS_HIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REFERRER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CARE_MANAGER"
	type = "BOOLEAN"
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
	name = "DEACTIVATION_REASON"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "APPLICANT_DATE_CREATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CAREGIVER_DATE_CREATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "CAREGIVER_UPDATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "RATING"
	type = "NUMBER(38,0)"
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
	name = "WORKERS_COMP_CLASS_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "HOURS_WANTED_WEEKLY"
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
	name = "FIRST_CARELOG_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ALLOW_MOBILE_CLOCKIN_WITH_LOCATION_DISABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DATE_DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "HEARD_MOBILE_APP_MARKETING_MESSAGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOW_MOBILE_USE_OFFLINE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CUID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CAREGIVER_NPI"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "LOCATION_MANAGER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROCESSOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "RECRUITER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SCHEDULER_ID"
	type = "NUMBER(38,0)"
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

