resource "snowflake_table" "DISC_ALAYACARE_SERVICE_RRULE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "SERVICE_RRULE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.SERVICE_RRULE

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
	name = "SERVICE_RRULE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_CODE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DURATION"
	type = "NUMBER(19,8)"
	nullable = true
}


column {
	name = "RULE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "RULE_FREQ"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "SERVICE_RECURRENCE_STATUS"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "REPEAT_INTERVAL"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CREATE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULED_UNTIL_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

