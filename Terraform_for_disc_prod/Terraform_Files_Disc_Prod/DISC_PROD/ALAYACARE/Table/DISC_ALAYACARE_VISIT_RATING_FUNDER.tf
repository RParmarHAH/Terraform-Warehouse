resource "snowflake_table" "DISC_ALAYACARE_VISIT_RATING_FUNDER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "VISIT_RATING_FUNDER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.VISIT_RATING_FUNDER

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
	name = "PK_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FUNDER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PERCENTAGE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IS_PRIMARY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "BILLCODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISIT_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "VARIANT"
	nullable = true
}


column {
	name = "CONTACT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROGRAM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROGRAM_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

