resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CONTACTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CONTACTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CONTACTS

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
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CONTACTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CONTACTEMAIL"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "OTHERCONTACTINFO"
	type = "VARCHAR(6000)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SORTORDER"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "INLUDEONCAREPLAN"
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

