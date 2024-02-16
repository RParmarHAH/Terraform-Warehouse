resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_HIST_DFARINVOICES_BACKUP_20231228" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "HIST_DFARINVOICES_BACKUP_20231228"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.HIST_DFARINVOICES_BACKUP_20231228

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
	nullable = false
}


column {
	name = "REFERENCENO"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "INVOICENUMBER"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PERIOD"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SUPPLEMENTNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BATCH"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SERVICEAREA"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CONTRACTTEXT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATECREATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HOURSBILLED"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "AMOUNTBILLED"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "LASTPAYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "GROSSPAID"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "OUTSTANDING"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "CLIENTBILLED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CCUCONTRACT"
	type = "VARCHAR(12)"
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

