resource "snowflake_table" "DISC_ALAYACARE_VITAL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "VITAL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.VITAL

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
	name = "VITAL_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_GUID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VITAL_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VITAL_GROUP_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VITAL_SOURCE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VITAL_OPTIONS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VITAL_UNIT"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "VITAL_COMMENTS"
	type = "VARCHAR(1250)"
	nullable = true
}


column {
	name = "VITAL_MEASUREMENT"
	type = "NUMBER(38,10)"
	nullable = true
}


column {
	name = "VITAL_CREATED_AT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

