resource "snowflake_table" "DISC_DOCEBO_USERS_EXPORT_NEW" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DOCEBO"
	name = "USERS_EXPORT_NEW"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DOCEBO.USERS_EXPORT_NEW

    -- Purpose : Discovery Data Population

    -- Project : DOCEBO

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "USERNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ARE_YOU_OR_ARE_YOU_APPLYING_TO_BE_AN_INHOME_CAREGIVER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "BRANCHES"
	type = "VARCHAR(112)"
	nullable = true
}


column {
	name = "BUSINESS_UNIT"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "DEACTIVATED"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIRECT_MANAGER"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "DO_YOU_HAVE_A_HOME_HEALTH_CERTIFICATION"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "EMAIL_ADDRESS"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "FIELD_OR_ADMIN"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FIRST_NAME"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "FIRST_SERVICE_DATE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "FULL_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "HIRE_DATE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "HOURLY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "JOB_LEVEL"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "LANGUAGE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "LAST_NAME"
	type = "VARCHAR(70)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MANAGER_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "PAYROLL_ID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "TIME_ZONE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "USER_EXPIRATION_DATE"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "USER_LEVEL"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "USER_UNIQUE_ID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "NUMBER(1,0)"
	nullable = true
}

}

