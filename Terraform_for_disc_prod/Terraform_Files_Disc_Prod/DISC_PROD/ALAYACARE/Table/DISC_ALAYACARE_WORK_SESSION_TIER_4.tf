resource "snowflake_table" "DISC_ALAYACARE_WORK_SESSION_TIER_4" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "WORK_SESSION_TIER_4"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.WORK_SESSION_TIER_4

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
	name = "START_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PUNCH_IN_LON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PUNCH_IN_LAT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PUNCH_IN_DISTANCE"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "PUNCH_IN_DISTANCE_LIMIT"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "END_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PUNCH_OUT_LON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PUNCH_OUT_LAT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PUNCH_OUT_DISTANCE"
	type = "NUMBER(13,2)"
	nullable = true
}


column {
	name = "PUNCH_OUT_DISTANCE_LIMIT"
	type = "NUMBER(13,2)"
	nullable = true
}

}

