resource "snowflake_table" "DISC_CCSI_CLIENTCALL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "CLIENTCALL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.CLIENTCALL

    -- Purpose : Discovery Data Population

    -- Project : CCSI

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORD_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CLIENT_NAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ABUSE2_PRINTED_DATE"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DATE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "COMMENT_1"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "COMMENT_2"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "COMMENT_3"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "COMMENT_4"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "COMMENT_5"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "COMMENT_6"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "COMMENT_7"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "COMMENT_8"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "COMMENT_9"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "COMMENT_10"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "LOCKED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DESK"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "FOLLOW_UP"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MEDICAID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ACTION_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MISSED_HOURS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CAPTURED_HOURS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "URGENT_NEED"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ISSUED_RESOLVED"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RESOLVED_BY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RESOLVED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "RESOLVED_TIME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INITIAL_REVIEW_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EMPLOYEE_NAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EMPLOYEE_NO"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NONIDOA"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SOURCE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CRITICAL_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CRITICAL_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CRITICAL_TIME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICE_TYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CRITICAL_EVENT_NO"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "NEW_PRINTED"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "NON_CRIT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FKEYS_OR_TXCODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CREATED_BY_2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CREATED_ON"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_AT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

