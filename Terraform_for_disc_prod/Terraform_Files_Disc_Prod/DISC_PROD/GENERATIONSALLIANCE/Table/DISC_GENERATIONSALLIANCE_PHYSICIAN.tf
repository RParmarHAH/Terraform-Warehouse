resource "snowflake_table" "DISC_GENERATIONSALLIANCE_PHYSICIAN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "PHYSICIAN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.PHYSICIAN

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
	name = "PHYSICIANNAME"
	type = "VARCHAR(255)"
	nullable = false
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FAX"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ALTPHONE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(3000)"
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
	name = "EMAIL"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "NPI_NUMBER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PHYSICIANLASTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "PHYSICIANFIRSTNAME"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "TAXONOMYNUMBER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TAXONOMYCODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "QUALIFIERID"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "QUALIFIER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "PROVIDERASSIGNEDID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "SPECIALTY"
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

