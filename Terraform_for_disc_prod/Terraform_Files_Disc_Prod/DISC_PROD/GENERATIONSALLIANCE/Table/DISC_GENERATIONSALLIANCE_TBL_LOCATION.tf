resource "snowflake_table" "DISC_GENERATIONSALLIANCE_TBL_LOCATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "TBL_LOCATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.TBL_LOCATION

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
	name = "STR_LOCATIONID"
	type = "VARCHAR(3)"
	nullable = false
}


column {
	name = "STR_CREATEDBY"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "DTM_CREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STR_UPDATEDBY"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "DTM_LASTUPDATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BIT_OVERRIDEOFFSET"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DEC_OFFSET"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "TIMEZONEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "PROVIDERID"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "OVERRIDECOMPANYINFO"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOCATIONCOMPANYNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATIONTAXID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LOCATIONADDRESS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCATIONCITY"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "LOCATIONSTATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "LOCATIONZIP"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "LOCATIONPHONE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LOCATIONPAYROLLID"
	type = "VARCHAR(31)"
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

