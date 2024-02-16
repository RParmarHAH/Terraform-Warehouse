resource "snowflake_table" "DISC_PUBLIC_DFINVOICES_FULLLOAD_20231229" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "DFINVOICES_FULLLOAD_20231229"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.DFINVOICES_FULLLOAD_20231229

    -- Purpose : Discovery Data Population

    -- Project : PUBLIC

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
	name = "INVOICENO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERIOD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENTNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUPPLEMENTNO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURSBILLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMOUNTBILLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYMENTRECEIVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREDITEDAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OUTSANDINGAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICECREATEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEAREA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYERCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BATCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TEMPFINAL"
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
	name = "MOVEDTO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SHORTDESC"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTPAYDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTCHECKNO"
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

