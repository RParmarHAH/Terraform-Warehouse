resource "snowflake_table" "DISC_ALAYACARE_SERVICE_SKILL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "SERVICE_SKILL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.SERVICE_SKILL

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
	name = "SKILL_POSITION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SKILL_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_POSITION_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_POSITION_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_POSITION_IDPOSITION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_POSITION_IDSKILL"
	type = "VARCHAR(250)"
	nullable = true
}

}

