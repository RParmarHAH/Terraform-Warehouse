resource "snowflake_table" "DISC_PARADOX_HIRED_AL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PARADOX"
	name = "HIRED_AL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PARADOX.HIRED_AL

    -- Purpose : Discovery Data Population

    -- Project : PARADOX

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CANDIDATE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_CREATE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REQUISITION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_JOURNEY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOURNEY_STAGE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOURNEY_STAGE_ORDER_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOURNEY_STATUS_ORDER_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS_CHANGE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS_CHANGED_BY_USER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CANDIDATE_SOURCED_FROM_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROFILE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MULTIPLE_RECORDS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_IDENTIFIER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REAPPLY_IN_CAPTURE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REAPPLY_IN_JOB_SEARCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REAPPLY_IN_CAMPAIGN"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

