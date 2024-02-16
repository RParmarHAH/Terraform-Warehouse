resource "snowflake_table" "DISC_ALAYACARE_CLIENT_CARE_PLAN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CLIENT_CARE_PLAN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CLIENT_CARE_PLAN

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
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "COMPLETED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CREATION_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CREATION_USER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "COMPLETION_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "COMPLETION_USER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(250)"
	nullable = true
}

}

