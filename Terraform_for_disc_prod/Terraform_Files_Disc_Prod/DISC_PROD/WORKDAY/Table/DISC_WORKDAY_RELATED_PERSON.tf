resource "snowflake_table" "DISC_WORKDAY_RELATED_PERSON" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "WORKDAY"
	name = "RELATED_PERSON"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.WORKDAY.RELATED_PERSON

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
	name = "OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RELATED_PERSON_ID"
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "RELATED_PERSON_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RELATIONSHIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BIRTH_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "MARITAL_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HISPANIC_OR_LATINO"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

