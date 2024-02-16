resource "snowflake_table" "DISC_OLYMPUS_OLYMPUS_SOURCE_DATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "OLYMPUS"
	name = "OLYMPUS_SOURCE_DATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.OLYMPUS.OLYMPUS_SOURCE_DATA

    -- Purpose : Discovery Data Population

    -- Project : OLYMPUS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DATEOFBIRTH"
	type = "DATE"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ZIPCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PATIENT_ID"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "LOADDATE"
	type = "DATE"
	nullable = true
}

}

