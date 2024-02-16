resource "snowflake_table" "DISC_ALAYACARE_SERVICE_HISTORY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "SERVICE_HISTORY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.SERVICE_HISTORY

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
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_BILL_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "STATUS_HISTORICAL"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "STATUS_REASON"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CREATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REVISION_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REVISION_FROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REVISION_UNTIL"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LENGTH_OF_STAY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_FACILITY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "SERVICE_ASSIGNED_EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_BILLING_CONTACT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}

}

