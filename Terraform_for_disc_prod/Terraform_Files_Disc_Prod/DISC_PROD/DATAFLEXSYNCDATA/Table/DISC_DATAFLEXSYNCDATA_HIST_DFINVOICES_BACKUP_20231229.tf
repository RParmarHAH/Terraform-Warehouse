resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_HIST_DFINVOICES_BACKUP_20231229" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "HIST_DFINVOICES_BACKUP_20231229"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.HIST_DFINVOICES_BACKUP_20231229

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
	name = "INVOICENO"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PERIOD"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "CLIENTNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVOICETYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUPPLEMENTNO"
	type = "NUMBER(10,0)"
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
	name = "PAYMENTRECEIVED"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "CREDITEDAMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "OUTSANDINGAMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "INVOICECREATEDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SERVICEAREA"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYERCODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "BATCH"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TEMPFINAL"
	type = "VARCHAR(5)"
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
	name = "MOVEDTO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SHORTDESC"
	type = "VARCHAR(125)"
	nullable = true
}


column {
	name = "LASTPAYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTCHECKNO"
	type = "VARCHAR(10)"
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

