resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_DFINVOICEDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "DFINVOICEDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.DFINVOICEDETAILS

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
	name = "REFERENCENO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVOICENO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DATEFROM"
	type = "DATE"
	nullable = true
}


column {
	name = "DATETO"
	type = "DATE"
	nullable = true
}


column {
	name = "HOURS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "AMOUNTPAID"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "BILLCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLIENTNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYEENO1"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYEENO2"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYEENO3"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PREAUTHNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STARTTIME"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "DATASOURCE"
	type = "VARCHAR(12)"
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

