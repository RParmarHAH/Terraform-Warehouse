resource "snowflake_table" "DISC_GENERATIONSALLIANCE_MASSEMAILLOG" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "MASSEMAILLOG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.MASSEMAILLOG

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
	name = "UID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "MESSAGETYPE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "FROMADDRESS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SUBJECT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "BODY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SENDINGDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MAILSTATUS"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "TOTAL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUCCESSCOUNT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMAILLOGTYPE"
	type = "VARCHAR(50)"
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

