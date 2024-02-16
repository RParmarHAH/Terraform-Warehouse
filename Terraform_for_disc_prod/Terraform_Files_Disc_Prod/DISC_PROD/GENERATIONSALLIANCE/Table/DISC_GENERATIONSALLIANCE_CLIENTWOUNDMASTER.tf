resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CLIENTWOUNDMASTER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CLIENTWOUNDMASTER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CLIENTWOUNDMASTER

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
	name = "CLIENTWOUNDMASTERID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TITLE"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "PICTURE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DISCOVERYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ODOR"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "WOUNDDIMENSION"
	type = "VARCHAR(250)"
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

