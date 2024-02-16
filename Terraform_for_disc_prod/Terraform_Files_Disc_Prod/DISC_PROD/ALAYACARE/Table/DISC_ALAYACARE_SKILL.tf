resource "snowflake_table" "DISC_ALAYACARE_SKILL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "SKILL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.SKILL

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
	name = "SKILL_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "LABEL_1_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "LABEL_2_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "LABEL_3_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DATE_LABEL_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ACQUIRED_DATE_LABEL_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_LABEL1"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_HAS_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_IDCATEGORY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_DATE_LABEL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_OP"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_LABEL2"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_IS_CLIENT_SPECIFIC"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_ACQUIRED_DATE_LABEL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_HAS_ACQUIRED_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_CATEGORY_IDMASTERACCOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_CATEGORY_DETAILS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_CATEGORY_DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_CATEGORY_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_ID"
	type = "VARCHAR(250)"
	nullable = true
}

}

