resource "snowflake_table" "DISC_GENERATIONSALLIANCE_SCHEDULEREQUEST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "SCHEDULEREQUEST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.SCHEDULEREQUEST

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
	name = "REQUESTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREGIVERSSN"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISSCHEDULED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "USERALERTSTAUS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISREQUESTOPENED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISREQUESTCANCELED"
	type = "BOOLEAN"
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

