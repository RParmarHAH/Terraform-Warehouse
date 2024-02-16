resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_DFINVOICEDETAILS_FULLLOAD_20230905" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "DFINVOICEDETAILS_FULLLOAD_20230905"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.DFINVOICEDETAILS_FULLLOAD_20230905

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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCENO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICENO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATEFROM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATETO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMOUNTPAID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENTNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEENO1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEENO2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEENO3"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREAUTHNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STARTTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATEBATCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATEDTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATASOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

