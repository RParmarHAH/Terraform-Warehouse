resource "snowflake_table" "DISC_ALAYACARE_DO_NOT_SEND" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "DO_NOT_SEND"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.DO_NOT_SEND

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
	name = "BLOCK_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CREATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DO_NOT_SEND_REASON"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_DO_NOT_SEND_OP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_DO_NOT_SEND_BLOCKED_GUID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_DO_NOT_SEND_COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_DO_NOT_SEND_CREATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_DO_NOT_SEND_CREATE_USER_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_DO_NOT_SEND_GUID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_DO_NOT_SEND_UPDATE_TIME"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_DO_NOT_SEND_UPDATE_USER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

