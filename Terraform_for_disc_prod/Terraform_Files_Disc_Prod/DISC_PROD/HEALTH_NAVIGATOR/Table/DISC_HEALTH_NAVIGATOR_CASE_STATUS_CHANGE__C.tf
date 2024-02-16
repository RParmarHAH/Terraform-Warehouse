resource "snowflake_table" "DISC_HEALTH_NAVIGATOR_CASE_STATUS_CHANGE__C" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HEALTH_NAVIGATOR"
	name = "CASE_STATUS_CHANGE__C"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HEALTH_NAVIGATOR.CASE_STATUS_CHANGE__C

    -- Purpose : Discovery Data Population

    -- Project : HEALTH_NAVIGATOR

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
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "SET_TIME__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AGE__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_ZIP__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "ACCOUNT_NAME__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "CASE_TYPE__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "CLIENT_STATE__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "CLIENT_CARE_PROGRAMS__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "CURRENT_CASE_OWNER__C"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "STATUS_FROM__C"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "CREATEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "STATUS_TIME__C"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CASE_RECORD_TYPE__C"
	type = "VARCHAR(1300)"
	nullable = true
}


column {
	name = "CASE__C"
	type = "VARCHAR(18)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CHANGE_TIME__C"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUS_NAME__C"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBYID"
	type = "VARCHAR(18)"
	nullable = true
}

}

