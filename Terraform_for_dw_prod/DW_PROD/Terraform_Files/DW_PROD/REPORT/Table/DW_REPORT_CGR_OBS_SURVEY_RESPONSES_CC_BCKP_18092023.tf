resource "snowflake_table" "DW_REPORT_CGR_OBS_SURVEY_RESPONSES_CC_BCKP_18092023" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "REPORT"
	name = "CGR_OBS_SURVEY_RESPONSES_CC_BCKP_18092023"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.REPORT.CGR_OBS_SURVEY_RESPONSES_CC_BCKP_18092023

    -- Purpose : Business Report Data Population

    -- Project : REPORT

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SURVEY_DISTRIBUTION_REPORT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SURVEY_RESPONSE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "EMPLOYEE_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "BRANCH_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "SURVEY_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "DISTRIBUTION_KEY"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "DISTIBUTION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SURVEY_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "OPTOUTS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BOUNCEBACK"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PARTNER_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LANGUAGE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLIENT_EMPLOYEE_FIRST_SURVEY_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_FIRST_SURVEY_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENT_FIRST_SURVEY_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENT_EMPLOYEE_LATEST_SURVEY_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENT_LATEST_SURVEY_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EMPLOYEE_LATEST_SURVEY_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SURVEY_STATUS"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CORRESPONDING_VISIT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PRIOR_VISIT_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "GENERAL_APPEARANCE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "APPEARANCE_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EATING_HABITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DRINKING_HABITS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGES_WALKING"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGES_TRANSFER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MISSED_MEDICATIONS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CHANGED_MEDICATION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CHANGES_AGITATION"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGES_ANKLELEG_SWELLING"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGES_BREATHING"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGES_CONFUSION"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGES_DAYTIME_SLEEPINESS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGES_PAIN"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGES_SADNESS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGES_SKIN_BREAKDOWN"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGES_SWELLING_ELSEWHERE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGES_SLEEPING_PATTERNS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHANGES_NIGHT_SLEEP"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "URINATION_FREQUENCY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BOWEL_MOVEMENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BLADDER_CONTROL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BOWEL_CONTROL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DIARRHEA_ISSUES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "URINE_SMELL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FALLEN_SINCE_LAST_VISIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ERVISIT_SINCE_LAST_VISIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "URGENTVISIT_SINCE_LAST_VISIT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INJURY_FROM_FALL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "THREE_PLUS_DAYS_OF_FOOD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FRESH_FOOD_SUPPLY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKING_SMOKE_DETECTOR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKING_ELECTRICAL_SYSTEM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKING_FURNACE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOME_FREE_OF_BEDBUGS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOME_FREE_OF_ROACHES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "HOME_FREE_OF_MICE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKING_OVEN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WORKING_STOVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIENT_WEIGHT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WEIGHT_UNITS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DIABETIC"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CURRENT_BLOOD_SUGAR"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HELP_FOR_CLIENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HELP_FOR_CLIENT_OTHER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HELP_FOR_CAREGIVER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INPATIENT_STAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SHORT_TERM_REHAB"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NURSING_FAC_VISIT"
	type = "BOOLEAN"
	nullable = true
}

}

