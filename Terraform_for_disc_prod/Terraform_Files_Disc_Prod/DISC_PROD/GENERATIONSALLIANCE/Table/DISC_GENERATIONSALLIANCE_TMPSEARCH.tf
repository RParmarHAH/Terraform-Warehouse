resource "snowflake_table" "DISC_GENERATIONSALLIANCE_TMPSEARCH" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "TMPSEARCH"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.TMPSEARCH

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
	name = "SOCIALSECURITYNUM"
	type = "VARCHAR(9)"
	nullable = false
}


column {
	name = "LASTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FIRSTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDRESS1"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "ADDRESS2"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "CITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "COUNTY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ZIP"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "PHONE1"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "PHONE2"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "MILES"
	type = "NUMBER(6,2)"
	nullable = true
}


column {
	name = "PRIOR_VISITS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ISAPPLICANT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TEXTMESSAGE"
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

