resource "snowflake_table" "DISC_GENERATIONSALLIANCE_SERVICES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "SERVICES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.SERVICES

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
	name = "SERVICECODE"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "SHORTDESCRIPTION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "COST"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ITEMTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "QUICKBOOKSID"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "FLATRATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALTERNATESERVICEID1"
	type = "VARCHAR(50)"
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
	name = "STATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REGION8ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MODIFIER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TOS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MODIFIER2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REVENUECODE"
	type = "VARCHAR(4)"
	nullable = true
}


column {
	name = "STATEEVV"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUPPLYINFO"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "ACCOUNTNUM"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MODIFIER3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MODIFIER4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INCLUDEINADJUSTEDDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "OVERRIDESERVICEDESCRIPTION"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROCEDURETAXONOMYCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ISTELLUSENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CAREPROGRAMID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AUTHENTICAREENABLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "THIRDPARTYEVV"
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

