resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_DFOFFICES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "DFOFFICES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.DFOFFICES

    -- Purpose : Discovery Data Population

    -- Project : DATAFLEXSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DBNAME"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "OFFICENUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEBATCH"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "UPDATEDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYROLLGROUP"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYROLLBATCHNAME"
	type = "VARCHAR(15)"
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

