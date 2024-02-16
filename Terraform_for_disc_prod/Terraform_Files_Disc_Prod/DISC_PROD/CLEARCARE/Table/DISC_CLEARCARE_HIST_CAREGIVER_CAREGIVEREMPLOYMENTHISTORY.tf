resource "snowflake_table" "DISC_CLEARCARE_HIST_CAREGIVER_CAREGIVEREMPLOYMENTHISTORY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "HIST_CAREGIVER_CAREGIVEREMPLOYMENTHISTORY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.HIST_CAREGIVER_CAREGIVEREMPLOYMENTHISTORY

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
	name = "CAREGIVER_SKILLS_EDUCATION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SUPERVISOR"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "EMPLOYMENT_PHONE_NUMBER"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ADDRESS_1"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ADDRESS_2"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ADDRESS_ZIP"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DATE_EMPLOYED_FROM"
	type = "DATE"
	nullable = true
}


column {
	name = "DATE_EMPLOYED_TO"
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

