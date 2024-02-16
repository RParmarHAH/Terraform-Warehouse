resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CLIENTWOUND" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CLIENTWOUND"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CLIENTWOUND

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
	name = "CLIENTWOUNDID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LENGTH"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "WIDTH"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "DEPTH"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "DRAINAGE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "COMMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PICTURE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REASON"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STAGE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "APPROVEDSTATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CLIENTWOUNDMASTERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ODOR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WOUNDNOTESSTAGEID"
	type = "NUMBER(10,0)"
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

