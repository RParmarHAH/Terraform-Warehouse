resource "snowflake_table" "DISC_ALAYACARE_COMPUTED_VISIT_WORK_SESSION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "COMPUTED_VISIT_WORK_SESSION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.COMPUTED_VISIT_WORK_SESSION

    -- Purpose : Discovery Data Population

    -- Project : ALAYACARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "VISIT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PERCENTAGE_RAW"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "PERCENTAGE"
	type = "NUMBER(21,8)"
	nullable = true
}


column {
	name = "PUNCHED"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "PUNCHED_START_MINUS_SCHEDULED_START"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "VISIT_LATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PUNCHED_DURATION"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "VISIT_SCHEDULED_DURATION"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "SCHEDULED_MINUS_PUNCHED_DURATION"
	type = "NUMBER(13,2)"
	nullable = true
}

}

