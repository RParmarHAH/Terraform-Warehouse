resource "snowflake_table" "DISC_ALAYACARE_SERVICE_CODE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "SERVICE_CODE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.SERVICE_CODE

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
	name = "SERVICE_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_MATCHING_SHIFT_COVERAGE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IS_DISABLED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_DISREGARD_START_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDPAYCODEREGULAR"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_OT_EXEMPT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_DISREGARD_SHIFT_COVERAGE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_ALLOW_VIRTUAL_CARE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_MATCHING_SHIFT_LATE_START"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_RATING_METHODOLOGY_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_DURATION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_DISREGARD_EMPLOYEE_CAPACITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IS_VISIT_CANCELLED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_IDPAYCODEHOLIDAY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_VISITS_CAN_OVERLAP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DEPARTMENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DEPARTMENT_NAME"
	type = "VARCHAR(250)"
	nullable = true
}

}

