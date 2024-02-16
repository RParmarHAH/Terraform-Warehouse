resource "snowflake_table" "DISC_ALAYACARE_CLIENT_STATUS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "CLIENT_STATUS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.CLIENT_STATUS

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
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EFFECTIVE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EFFECTIVE_DATE_TO"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REASON_CODE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CREATION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REVISION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EMPLOYEE_CREATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_UPDATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SEQ"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}

}

