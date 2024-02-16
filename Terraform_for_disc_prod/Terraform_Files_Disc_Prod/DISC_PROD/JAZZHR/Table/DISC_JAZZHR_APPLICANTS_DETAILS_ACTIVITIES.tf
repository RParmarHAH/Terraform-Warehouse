resource "snowflake_table" "DISC_JAZZHR_APPLICANTS_DETAILS_ACTIVITIES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "JAZZHR"
	name = "APPLICANTS_DETAILS_ACTIVITIES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.JAZZHR.APPLICANTS_DETAILS_ACTIVITIES

    -- Purpose : Discovery Data Population

    -- Project : JAZZHR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ACTIVITY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLICANT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIVITY_DETAILS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIVITY_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIVITY_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPLY_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

