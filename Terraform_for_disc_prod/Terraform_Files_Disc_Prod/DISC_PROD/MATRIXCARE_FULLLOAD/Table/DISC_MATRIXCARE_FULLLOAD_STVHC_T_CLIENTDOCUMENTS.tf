resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_STVHC_T_CLIENTDOCUMENTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "STVHC_T_CLIENTDOCUMENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_CLIENTDOCUMENTS

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE_FULLLOAD

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLIDOC_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIDOC_CLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIDOC_TYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIDOC_FORMAT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIDOC_FILENAME"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "CLIDOC_FILESIZE"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIDOC_NOTES"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "CLIDOC_SHARELEVEL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIDOC_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIDOC_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIDOC_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIDOC_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIDOC_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIDOC_ISCOMPRESSED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIDOC_SUBTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INSERTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELETEDFLAG"
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

