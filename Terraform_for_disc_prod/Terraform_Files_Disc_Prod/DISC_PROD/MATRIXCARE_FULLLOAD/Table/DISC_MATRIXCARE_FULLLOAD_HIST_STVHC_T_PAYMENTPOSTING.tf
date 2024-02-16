resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_PAYMENTPOSTING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_PAYMENTPOSTING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_PAYMENTPOSTING

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
	name = "POST_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "POST_PAYMENTREGISTERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POST_AMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "POST_POSTEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POST_INVOICEDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POST_PAYMENTPOSTINGTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POST_NOTES"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "POST_PERIODCLOSEDID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POST_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POST_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POST_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POST_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POST_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "POST_ACCTEXTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POST_ACCTEXTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "POST_CONTROLNO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POST_EDIID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POST_EFTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POST_INCLUDEEFT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POST_DELETEWITHINVOICE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "POST_DELETEWITHINVOICEHEADERID"
	type = "NUMBER(19,0)"
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

