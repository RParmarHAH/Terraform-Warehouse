resource "snowflake_table" "DISC_ALAYACARE_CLIENT_MEDHIST_ALLERGY_LIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CLIENT_MEDHIST_ALLERGY_LIST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CLIENT_MEDHIST_ALLERGY_LIST

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
	name = "TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CATEGORY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SEVERITY_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SEVERITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TREATMENT"
	type = "VARCHAR(250)"
	nullable = true
}

}

