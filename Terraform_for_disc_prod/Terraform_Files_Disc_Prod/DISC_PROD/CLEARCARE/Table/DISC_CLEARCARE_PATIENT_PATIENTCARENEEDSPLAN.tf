resource "snowflake_table" "DISC_CLEARCARE_PATIENT_PATIENTCARENEEDSPLAN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "PATIENT_PATIENTCARENEEDSPLAN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.PATIENT_PATIENTCARENEEDSPLAN

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
	name = "PATIENT_ID"
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
	name = "CARE_GOALS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PROPOSED_SCHEDULE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CAR_TRANSPORTATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BEDBOUND"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREGIVER_GENDER_PREFERENCE"
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
	name = "CNA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HHA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LVN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INITIAL_CONTACT"
	type = "DATE"
	nullable = true
}


column {
	name = "START_DATE"
	type = "DATE"
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
	name = "CARE_PLAN_PROGNOSIS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CARE_COORDINATION_NOTES"
	type = "VARCHAR(16383)"
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

