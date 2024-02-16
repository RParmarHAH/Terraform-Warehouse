resource "snowflake_table" "DISC_JAZZHR_HIST_JOBS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "JAZZHR"
	name = "HIST_JOBS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.JAZZHR.HIST_JOBS

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
	name = "ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TEAM_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COUNTRY_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DEPARTMENT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MINIMUM_SALARY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MAXIMUM_SALARY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "ORIGINAL_OPEN_DATE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SEND_TO_JOB_BOARDS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "HIRING_LEAD"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BOARD_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INTERNAL_CODE"
	type = "VARCHAR(100)"
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

