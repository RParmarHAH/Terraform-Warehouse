resource "snowflake_table" "DISC_HEALTH_STREAM_HEALTH_STREAM_DIM_EMPLOYEE_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_STREAM"
	name = "HEALTH_STREAM_DIM_EMPLOYEE_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_STREAM.HEALTH_STREAM_DIM_EMPLOYEE_MAPPING

    -- Purpose : Discovery Data Population

    -- Project : HEALTH_STREAM

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "F_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "F_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "F_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "F_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "F_DOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WH_EMPLOYEE_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WH_SOURCE_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WH_SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WH_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WH_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WH_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WH_PERSONAL_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WH_WORK_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WH_WORKDAY_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WH_DOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RULE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

