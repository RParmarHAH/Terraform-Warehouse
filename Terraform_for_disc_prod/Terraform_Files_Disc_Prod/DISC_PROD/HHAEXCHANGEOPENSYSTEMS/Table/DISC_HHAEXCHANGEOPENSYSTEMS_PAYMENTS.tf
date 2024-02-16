resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_PAYMENTS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "PAYMENTS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.PAYMENTS

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOPENSYSTEMS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYMENTID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "INVOICEDETAILID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BILLEDHOURS"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVOICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAIDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CHECKDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CHECKNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAIDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ADJUSTMENT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "TTADJUSTMENT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "WRITEOFF"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "OTHERADJUSTMENT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CREDITS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYERREFERENCENUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "THIRDPARTYAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BANKCODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYMENTBATCHID"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CHECKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
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

