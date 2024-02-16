resource "snowflake_table" "DISC_GENERATIONSALLIANCE_EMAILLOG" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "EMAILLOG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.EMAILLOG

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "FROMADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TOADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MAILSUBJECT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "MAILSTATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ERROR"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "BODY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ATTACHMENTS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SENTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "MASSEMAILID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "EVENTTYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SMTPSTATUSCODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUSMESSAGE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ATTACHMENTSIZEBYTES"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

