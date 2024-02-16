resource "snowflake_table" "DISC_JAZZHR_HIST_HIRES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "JAZZHR"
	name = "HIST_HIRES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.JAZZHR.HIST_HIRES

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
	name = "APPLICANT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIRED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "HIRED_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKFLOW_STEP_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKFLOW_STEP_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(10,0)"
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
	type = "BOOLEAN"
	nullable = true
}

}

