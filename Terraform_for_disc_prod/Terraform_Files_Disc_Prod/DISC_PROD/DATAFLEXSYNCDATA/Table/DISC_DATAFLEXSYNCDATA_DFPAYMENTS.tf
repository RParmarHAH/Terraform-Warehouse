resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_DFPAYMENTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "DFPAYMENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.DFPAYMENTS

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
	name = "CONTRACTCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLIENTNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "CHECKNUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CREDITAMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "NUMBERSOFINVOICES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYMENTNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ADDEDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CHANGEDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "AUDITNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "RESERVED"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WRITEOFFREASON"
	type = "NUMBER(10,0)"
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

