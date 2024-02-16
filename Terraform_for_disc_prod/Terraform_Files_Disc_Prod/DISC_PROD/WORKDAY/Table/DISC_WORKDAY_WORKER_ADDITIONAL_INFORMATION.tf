resource "snowflake_table" "DISC_WORKDAY_WORKER_ADDITIONAL_INFORMATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "WORKDAY"
	name = "WORKER_ADDITIONAL_INFORMATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.WORKDAY.WORKER_ADDITIONAL_INFORMATION

    -- Purpose : Discovery Data Population

    -- Project : WORKDAY

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "UNION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNION_ACTIVE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNION_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LATEST_VACCINATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LATEST_VACCINATION_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LATEST_VACCINATION_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SEND_TO_AMS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MANAGER_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MANAGER_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MANAGER_MIDDLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MANAGER_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MANAGER_SUFFIX"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_IDENTIFIER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GP_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVER_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENTERPRISE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_OF_DEATH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREFERRED_LOCALE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURLY_COMPENSATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NEW_HIRE_FLAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_DAY_WORKED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMS_COST_CENTER_HIERARCHY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_CHANGE_OLD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_CHANGE_NEW"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLICANT_ENTERED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRE_BOARDING_COMPLETION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARADOX_PREHIRE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANDING_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LANDING_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCESSED_TIMESTAMP"
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
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FILE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

