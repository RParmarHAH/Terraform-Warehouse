resource "snowflake_table" "DISC_ALAYACARE_CLIENT_MEDHIST_STAT_REQ" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CLIENT_MEDHIST_STAT_REQ"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CLIENT_MEDHIST_STAT_REQ

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
	name = "PROGNOSIS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MENTAL_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ACTIVITIES_PERMITTED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FUNCTIONAL_LIMITATIONS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "NUTRITIONAL_REQUIREMENTS"
	type = "VARCHAR(250)"
	nullable = true
}

}

