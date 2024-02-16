resource "snowflake_table" "DISC_ALAYACARE_EMPLOYEE_GROUP" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "EMPLOYEE_GROUP"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.EMPLOYEE_GROUP

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
	name = "GROUP_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_IDBILLITEM"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ACTIVE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_END_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDUSER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDPAYROLLITEM"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_REMARKS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROFILE_COMPANY"
	type = "VARCHAR(250)"
	nullable = true
}

}

