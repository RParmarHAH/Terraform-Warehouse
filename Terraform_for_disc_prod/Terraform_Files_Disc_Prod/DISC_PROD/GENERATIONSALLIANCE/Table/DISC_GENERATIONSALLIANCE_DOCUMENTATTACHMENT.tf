resource "snowflake_table" "DISC_GENERATIONSALLIANCE_DOCUMENTATTACHMENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "DOCUMENTATTACHMENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.DOCUMENTATTACHMENT

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
	name = "ATTACHMENTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "FILENAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "FOLDERID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "LOCATION"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CLASS"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FILEURL"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "UPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "AZURECONTAINER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AZURENAME"
	type = "VARCHAR(500)"
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

