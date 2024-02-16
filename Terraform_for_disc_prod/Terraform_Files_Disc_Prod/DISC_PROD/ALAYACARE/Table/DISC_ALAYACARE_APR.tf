resource "snowflake_table" "DISC_ALAYACARE_APR" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "APR"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.APR

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
	name = "APR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_CHANGE_TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "EXTERNAL_ID"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REPORT_TITLE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FUNDER_ID"
	type = "NUMBER(38,0)"
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
	name = "CREATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REVISION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SUBMISSION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICE_DISCHARGE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SUB_FIRSTVISIT_DAYS"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "SUB_LASTVISIT_DAYS"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "SUB_SERVICEDISCHARGE_DAYS"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "SUB_FIRSTVISIT"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "SUB_LASTVISIT"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "SUB_SERVICEDISCHARGE"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "URGENT"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "RESPONSE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PROPERTIES_PROVIDER"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_PROVIDER_SERVICE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "PROPERTIES_SERVICE"
	type = "VARCHAR(250)"
	nullable = true
}

}

