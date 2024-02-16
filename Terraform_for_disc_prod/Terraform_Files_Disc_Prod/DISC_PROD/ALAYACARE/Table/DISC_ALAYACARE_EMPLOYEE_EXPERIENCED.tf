resource "snowflake_table" "DISC_ALAYACARE_EMPLOYEE_EXPERIENCED" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "EMPLOYEE_EXPERIENCED"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.EMPLOYEE_EXPERIENCED

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
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISITS_TOTAL"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VISITS_WITH_CONTINUITY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CONTINUITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_VISITS_WITH_CONTINUITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_DATE_COMPUTED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ID_AUTO"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_RANK"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CLIENT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_EMPLOYEE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_VISITS_TOTAL"
	type = "VARCHAR(250)"
	nullable = true
}

}

