resource "snowflake_table" "DISC_ALAYACARE_EMPLOYMENT_TYPE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "EMPLOYMENT_TYPE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.EMPLOYMENT_TYPE

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
	name = "LAKE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYMENT_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ELIGIBLE_FOR_HOLIDAYS"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES"
	type = "VARCHAR(250)"
	nullable = true
}

}

