resource "snowflake_table" "DISC_HAH_REPORTING_KEYMETOFFICES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HAH_REPORTING"
	name = "KEYMETOFFICES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HAH_REPORTING.KEYMETOFFICES

    -- Purpose : Discovery Data Population

    -- Project : HAH_REPORTING

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "OFFICENUMBER"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "OFFICENAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "REGIONNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ORD"
	type = "FLOAT"
	nullable = true
}


column {
	name = "OFFICESTATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SYNCNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "U_ID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "WDAYS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "GEONAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REGIONNUMBER"
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
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

