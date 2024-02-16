resource "snowflake_table" "DISC_ALAYACARE_GEOMAP" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "GEOMAP"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.GEOMAP

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
	name = "ID"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ENTITY_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ENTITY_ADDRESS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ENTITY_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}

}

