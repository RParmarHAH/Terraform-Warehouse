resource "snowflake_table" "DISC_NAVISION_EMPLOYEE_RATES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "NAVISION"
	name = "EMPLOYEE_RATES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.NAVISION.EMPLOYEE_RATES

    -- Purpose : Discovery Data Population

    -- Project : NAVISION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "TIMESTAMP"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MIDDLE_NAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "INITIALS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SEARCH_NAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ADDRESS_2"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "POST_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PHONE_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MOBILE_PHONE_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ALT__ADDRESS_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ALT__ADDRESS_START_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ALT__ADDRESS_END_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PICTURE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "BIRTH_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SOCIAL_SECURITY_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "UNION_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "UNION_MEMBERSHIP_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COUNTRY_REGION_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MANAGER_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMPLYMT__CONTRACT_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "STATISTICS_GROUP_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMPLOYMENT_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "INACTIVE_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CAUSE_OF_INACTIVITY_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TERMINATION_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GROUNDS_FOR_TERM__CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GLOBAL_DIMENSION_1_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GLOBAL_DIMENSION_2_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "RESOURCE_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LAST_DATE_MODIFIED"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EXTENSION"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAGER"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "FAX_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COMPANY_EMAIL"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SALESPERS__PURCH__CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "NO__SERIES"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "REVIEW_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "REGULAR_RATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SPECIAL_RATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TRAINING_RATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "OVERTIME_RATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CREATION_DATE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COST_CENTER_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COST_OBJECT_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CLASS_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMPLOYER_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MIDDLE_INITIAL"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SUFFIX"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HOME_PHONE_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "RACE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "BLOCKED"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "DEFAULT_WORK_TYPE_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "DECEASED"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SSN_IS_VERIFIED"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PAY_CYCLE_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "STATUTORY_EMPLOYEE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "RETIREMENT_PLAN"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LEGAL_REPRESENTATIVE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HOUSEHOLD_EMPLOYEE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "DEFERRED_COMPENSATION"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "THIRD_PARTY_SICK_PAY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "DEFAULT_REP__AUTH__CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SOCIAL_INSURANCE_NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "CPP_EXEMPT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EI_EXEMPT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "RPP_OR_DPSP"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "OVERRIDE_INSURABLE_HOURS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SALARIED"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LANGUAGE_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HR_REP__NO_"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "HR_REP__CONTACT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SALUTATION_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "POSITION_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "F_T__EQUIVALENT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SCORE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EMPLOYEE_TYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MARITAL_STATUS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "EEO_JOB_CLASS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PPIP_EXEMPT"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "OFFICE_LOCATION"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "VISIO_SHAPE_TYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TWITTER_USERNAME"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GRP_ADD"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GRP_CAN"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GRP_DEN"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GRP_L_STD"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GRP_VIS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "GRP_CRI"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

