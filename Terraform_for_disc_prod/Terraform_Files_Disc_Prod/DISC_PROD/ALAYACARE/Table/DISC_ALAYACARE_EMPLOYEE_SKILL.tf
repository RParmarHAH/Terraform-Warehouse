resource "snowflake_table" "DISC_ALAYACARE_EMPLOYEE_SKILL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "EMPLOYEE_SKILL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.EMPLOYEE_SKILL

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
	name = "SKILLLABEL_ID"
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
	name = "STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EXPIRY_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TRAINING_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIENT_SPECIFIC_SKILL"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "LABEL_1_VALUE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "LABEL_2_VALUE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "LABEL_3_VALUE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DATE_LABEL_VALUE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_COMMENTS"
	type = "VARCHAR(20000)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_EXPIRY_DATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_GUID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_IDSKILL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_IDSTATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_IDUSER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_START_AT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_TBL_EMPLOYEE_SKILL_TO_EMPLOYEE_UPDATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}

}

