resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_PAYERDOCUMENTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_PAYERDOCUMENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_PAYERDOCUMENTS

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "PAYDOC_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "PAYDOC_PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYDOC_TYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYDOC_FORMAT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYDOC_FILENAME"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "PAYDOC_FILESIZE"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYDOC_NOTES"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "PAYDOC_SHARELEVEL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYDOC_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYDOC_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYDOC_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYDOC_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYDOC_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYDOC_ISCOMPRESSED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYDOC_SUBTYPEID"
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

