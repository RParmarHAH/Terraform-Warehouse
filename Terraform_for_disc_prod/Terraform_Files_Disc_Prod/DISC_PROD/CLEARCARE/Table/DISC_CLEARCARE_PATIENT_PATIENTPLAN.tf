resource "snowflake_table" "DISC_CLEARCARE_PATIENT_PATIENTPLAN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "PATIENT_PATIENTPLAN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.PATIENT_PATIENTPLAN

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
	name = "MARITAL_STATUS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SPOUSE_NAME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "LIVES_WITH"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "LANGUAGES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DNR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RELIGION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ATTENDS_CHURCH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAST_PROFESSION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "MEDICAL_CONDITIONS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "HEARING"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "HEARING_AID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SPEACH"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "VISION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "GLASSES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SWALLOWING"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SMOKER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SENSITIVE_TO_SMELL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ON_OXYGEN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COLOSTOMY_BAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FEEDING_TUBE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MENTAL_BAHAVIOR"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DEPRESSION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LETHARGY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAST_CURRENT_SUBSTANCE_ABUSE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAN_CLIENT_BE_LEFT_ALONE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WANDERER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FREQUENT_MOOD_CHANGES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HALLUCINATIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROBLEM_SOLVING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHORT_TERM_MEMORY_LOSS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "COMPLETING_TASK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUNDOWNING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SPATIAL_VISUAL_RELATIONSHIPS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MISPLACING_ITEMS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POOR_EATING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SPEAKING_CONVERSING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POOR_JUDGMENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SLEEPING_PROBLEMS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ANXIETY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AGITATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FEAR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PARANOIA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUSPICION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AGGRESSION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONFUSION_OF_TIME_PLACE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WITHDRAWAL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SYMPTOMS_DEPRESSION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REPETITION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WANDERING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TRIGGERS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TOILETS_SELF"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NEEDS_REMINDERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STAND_BY_ASSIST"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BOWELS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CONSTIPATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DIARRHEA"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "URINATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ELIMINATION_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "NEED_MEDICATION_REMINDERS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOW_MANY_TIMES_PER_DAY"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "WHO_MANAGES_MEDICATION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "NUMBER_OF_MEDICATIONS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SEPARATE_MEDICATION_SCHEDULE_SHEET"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MEDICATIONS_SETUP_IN_PILL_BOXES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOW_MANY_WEEKS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CANE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WALKER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WHEEL_CHAIR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GERI_CHAIR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCOOTER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CCI_LEFT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CCI_RIGHT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AMBULATION_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TRANSFER_OBSERVED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TRANSFER_TYPES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "GAIT_BELT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOYER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AIDES_OTHER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AIDES_OTHER_CONNECTED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TRANSFER_RISKS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TRANSFER_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "RESISTS_BATHING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USES_SHOWER_BENCH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOWER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BATH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SPONGE_BATH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BGD_FREQUENCY"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DENTAL_DENTURES_CARE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SKIN_CARE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HYGIENE_OTHER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HYGIENE_OTHER_CONNECTED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DRESSING"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "BGD_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "COOKING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PREPARATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "APPETITE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DIET"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SPECIAL_DIET"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SHOPPING_BY"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "BREAKFAST"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BREAKFAST_CONNECTED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "LUNCH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LUNCH_CONNECTED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DINNER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DINNER_CONNECTED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SNACKS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SNACKS_CONNECTED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SWALLOWING_ISSUES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENCOURAGE_LIQUIDS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FAVORITE_BREAKFAST"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "FAVORITE_LUNCH"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "FAVORITE_SNACK"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "FAVORITE_DINNER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "MEALS_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "VEHICLE_NEED_CAREGIVER_TO_DRIVE_CONNECTED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ERRANDS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ERRANDS_CONNECTED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DRS_APPT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DRS_APPT_CONNECTED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DRIVING_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "EXCERCISE_IMPORTANCE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DOES_CLIENT_HAVE_SPECIFIC_EXCERCISE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ENCOURAGE_EXCERCISES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXCERCISE_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "HOUSEKEEPING_IMPORTANCE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "LAUNDRY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CHANGE_BED_BATH_LINENS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLEAN_KITCHEN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLEAN_BATHROOM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MAKE_BEDS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SWEEP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "VACUUM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MOP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DUST"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TAKE_OUT_TRASH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WATER_PLANTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FEED_ANIMALS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOUSEKEEPING_OTHER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TASKS_OTHER_CONNECTED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "HOUSEKEEPING_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "GOES_TO_BED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "WAKES_UP"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SLEEP_PATTERNS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "NAPS_DURING_DAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NAP_TIME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "NAP_DURATION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SLEEP_PATTERNS_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "HAS_SAFETY_ASSESSMENT_BEEN_DONE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INTERESTED_IN_LIFELINE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BEDRAILS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOSPITAL_BED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BED_COMMODE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "GRAB_BARS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LIFT_CHAIR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RAISED_TOILET_SEAT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHOWER_BENCH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HANDHELD_SHOWERHEAD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EQUIPMENT_ENVIRONMENT_OTHER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EQUIPMENT_ENVIRONMENT_OTHER_CONNECTED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "EQUIPMENT_ENVIRONMENT_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CAT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLEAN_LITTER_BOX"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DOG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FEEDING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WALK_DOG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PETS_OTHER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PETS_OTHER_CONNECTED"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "MORNING"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "AFTERNOON"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "EVENING"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ACTIVITIES_AT_HOME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ACTIVITIES_AWAY_FROM_HOME"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "FAVORITE_RESTAURANTS_SHOPS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DIFFICULTY_RETURNING_TO_SLEEP"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FAMILY_FRIENDS_NEIGHBORS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TRANSFER_ASSISTANCE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "BGD_ASSISTANCE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "NEEDS_ASSISTANCE_AT_NIGHT_FROM_CAREGIVER"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MENTAL_DEMENTIA"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ELIMINATION_WEARS_BRIEFS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "AMBULATION_AMBULATION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "AMBULATION_FALL_RISK"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "MEAL_FEEDING"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIENT_DRIVES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NEED_CAREGIVER_TO_DRIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MEDICATION_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DATE_OF_DEATH"
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
	name = "FULL_ASSESSMENT_FIRST_SAVE"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SECTIONS_IN_USE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ALLERGY_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PET_CARE_NOTES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PATIENT_CONTROL_NUMBER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "MEDICAL_RECORD_NUMBER"
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

