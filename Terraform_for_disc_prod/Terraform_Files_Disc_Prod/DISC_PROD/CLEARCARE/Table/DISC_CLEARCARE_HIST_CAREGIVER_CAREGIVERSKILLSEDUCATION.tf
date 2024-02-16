resource "snowflake_table" "DISC_CLEARCARE_HIST_CAREGIVER_CAREGIVERSKILLSEDUCATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "HIST_CAREGIVER_CAREGIVERSKILLSEDUCATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.HIST_CAREGIVER_CAREGIVERSKILLSEDUCATION

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
	name = "CAREGIVER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "COMPANIONSHIP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COOKING_MEAL_PREPARATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LIGHT_HOUSEKEEPING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OUT_OF_HOME_ACTIVITIES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAR_TRANSPORTATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DR_APPT_ERRANDS_SHOPPING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LIGHT_EXERCISE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MONITOR_WONDERING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MED_REMINDERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FEED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BATH_SHOWER_SPONGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DRESS_GROOM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AMBULATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CANE_WALKER_WHCHAIR_SCOOTER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TOILETING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GAIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FALL_RISK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRANSFER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WEARS_BRIEFS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FOR_ACCIDENTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEMENTIA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOSPICE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BEDBOUND"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HAS_ACCESS_TO_A_CAR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OK_WITH_CLIENTS_THAT_SMOKE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HIGHSCHOOL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COLLEGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "COLLEGE_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DEGREE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "MAX_CLIENT_WEIGHT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DATE_OF_BIRTH"
	type = "DATE"
	nullable = true
}


column {
	name = "HEIGHT"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "WEIGHT"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LANGUAGES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CN_FEEDING_TUBE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CN_HOYER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COLOSTOMY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WOUND_CARE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LIVE_IN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HIRE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "TERMINATION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "HR_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "RACE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "OK_WITH_DOGS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OK_WITH_CATS"
	type = "BOOLEAN"
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
	name = "DATE_DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "AGENCY_ID"
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

