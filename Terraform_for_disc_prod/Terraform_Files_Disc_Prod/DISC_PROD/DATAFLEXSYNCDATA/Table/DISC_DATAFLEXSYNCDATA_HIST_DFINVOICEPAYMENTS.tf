resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_HIST_DFINVOICEPAYMENTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "HIST_DFINVOICEPAYMENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.HIST_DFINVOICEPAYMENTS

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
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "REFERENCENO"
	type = "NUMBER(10,0)"
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
	name = "PERIOD"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "INVOICENO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BATCH"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUPPLEMENTNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAIDAMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "COPAY"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "PAYMENTDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROVIDERCONTRACT"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AUDITNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VOUCHER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "RUNDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CPT_HPCS_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ADDEDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "WRITEOFFAMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "CHECKNUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MCOPAIDAMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "MCOPLUGAMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "WRITEOFFREASON"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CHANGEDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAYERCODE"
	type = "VARCHAR(20)"
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

