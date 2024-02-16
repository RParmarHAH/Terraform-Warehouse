resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_PLANOFCAREDOCUMENTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_PLANOFCAREDOCUMENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_PLANOFCAREDOCUMENTS

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
	name = "POCDOC_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "POCDOC_PLANOFCAREID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POCDOC_TYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCDOC_FORMAT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POCDOC_FILENAME"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "POCDOC_FILESIZE"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POCDOC_NOTES"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "POCDOC_SHARELEVEL"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCDOC_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCDOC_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POCDOC_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POCDOC_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POCDOC_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "POCDOC_ISCOMPRESSED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POCDOC_SUBTYPEID"
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

