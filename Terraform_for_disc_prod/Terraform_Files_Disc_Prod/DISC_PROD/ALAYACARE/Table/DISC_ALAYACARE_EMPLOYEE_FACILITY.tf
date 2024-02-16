resource "snowflake_table" "DISC_ALAYACARE_EMPLOYEE_FACILITY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "EMPLOYEE_FACILITY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.EMPLOYEE_FACILITY

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
	name = "FACILITY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES"
	type = "VARCHAR(2500)"
	nullable = true
}


column {
	name = "PROFILE"
	type = "VARCHAR(2500)"
	nullable = true
}

}

