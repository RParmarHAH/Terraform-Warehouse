resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CAREGIVERATTACHMENTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CAREGIVERATTACHMENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CAREGIVERATTACHMENTS

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
	name = "SOCIALSECNUM"
	type = "VARCHAR(9)"
	nullable = false
}


column {
	name = "ATTACHMENTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "DESCR"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "ATTACHMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STR_FILENAME"
	type = "VARCHAR(260)"
	nullable = true
}


column {
	name = "DOCUMENTPATH"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "UPDATED_PATH"
	type = "VARCHAR(2200)"
	nullable = true
}


column {
	name = "UPDATED_FILENAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AZUREENABLED"
	type = "BOOLEAN"
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
	name = "ISCAREGIVERACCESS"
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

