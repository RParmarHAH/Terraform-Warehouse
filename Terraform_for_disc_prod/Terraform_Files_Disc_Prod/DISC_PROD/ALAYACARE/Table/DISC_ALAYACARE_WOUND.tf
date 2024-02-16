resource "snowflake_table" "DISC_ALAYACARE_WOUND" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "WOUND"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.WOUND

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
	name = "TREATMENT_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "WOUND_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "WOUND_EMPLOYEE_CREATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "WOUND_EMPLOYEE_UPDATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TREATMENT_EMPLOYEE_CREATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TREATMENT_EMPLOYEE_UPDATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TREATMENT_COMPLETE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISIT_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "NON_APPLICABLE"
	type = "NUMBER(2,0)"
	nullable = true
}


column {
	name = "LENGTH"
	type = "FLOAT"
	nullable = true
}


column {
	name = "WIDTH"
	type = "FLOAT"
	nullable = true
}


column {
	name = "DEPTH"
	type = "FLOAT"
	nullable = true
}


column {
	name = "AREA"
	type = "FLOAT"
	nullable = true
}


column {
	name = "INITIAL_AREA"
	type = "FLOAT"
	nullable = true
}


column {
	name = "HEALING_PERCENTAGE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "UNDERMINING"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "UNDERMINING_DEPTH"
	type = "FLOAT"
	nullable = true
}


column {
	name = "UNDERMINING_CLOCK"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TUNNELING"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TUNNELING_DEPTH"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TUNNELING_CLOCK"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BLACK_ESCHAR"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "RED_PINK_HYPER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "GREEN_YELLOW"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EXUDATE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ODOUR"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "MARGINS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PERIWOUND"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PERIWOUND_OTHER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SKIN_SENSATION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PAIN"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CULTURE_SENSITIVITY_SWAB"
	type = "NUMBER(2,0)"
	nullable = true
}


column {
	name = "SWAB_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFF_LOADING"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "OFF_LOADING_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "STAGE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ABPI"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "COMPRESSION"
	type = "NUMBER(2,0)"
	nullable = true
}


column {
	name = "COMPRESSION_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "COMPRESSION_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "WOUND_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "ACUITY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "LOCATION_DRAWING"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DIAGRAM"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FREQUENCY"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TREATMENT_PROTOCOL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TREATMENT_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TOTAL_VISITS_PERMITTED"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_WOUND_CARE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_WOUND_CARE_TREATMENT"
	type = "VARCHAR(250)"
	nullable = true
}

}

