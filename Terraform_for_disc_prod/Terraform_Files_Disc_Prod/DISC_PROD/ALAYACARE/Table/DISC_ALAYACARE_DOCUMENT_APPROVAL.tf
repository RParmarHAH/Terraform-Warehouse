resource "snowflake_table" "DISC_ALAYACARE_DOCUMENT_APPROVAL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "DOCUMENT_APPROVAL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.DOCUMENT_APPROVAL

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
	name = "DOCUMENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DOCUMENT_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DOCUMENT_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CERTIFICATION_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CERTIFICATION_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PHYSICIAN_NAME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PHYSICIAN_CONTACT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "START_CARE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}

}

