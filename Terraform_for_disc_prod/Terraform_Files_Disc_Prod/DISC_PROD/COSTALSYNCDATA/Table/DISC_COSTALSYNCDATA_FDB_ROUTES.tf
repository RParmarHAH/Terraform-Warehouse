resource "snowflake_table" "DISC_COSTALSYNCDATA_FDB_ROUTES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "FDB_ROUTES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.FDB_ROUTES

    -- Purpose : Discovery Data Population

    -- Project : COSTALSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DESCRIPTION1"
	type = "VARCHAR(90)"
	nullable = true
}


column {
	name = "DESCRIPTION2"
	type = "VARCHAR(90)"
	nullable = true
}


column {
	name = "DESCRIPTION3"
	type = "VARCHAR(90)"
	nullable = true
}


column {
	name = "DESCRIPTION4"
	type = "VARCHAR(90)"
	nullable = true
}


column {
	name = "DESCRIPTION5"
	type = "VARCHAR(90)"
	nullable = true
}


column {
	name = "DESCRIPTION6"
	type = "VARCHAR(90)"
	nullable = true
}


column {
	name = "ABBREV"
	type = "VARCHAR(4)"
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

