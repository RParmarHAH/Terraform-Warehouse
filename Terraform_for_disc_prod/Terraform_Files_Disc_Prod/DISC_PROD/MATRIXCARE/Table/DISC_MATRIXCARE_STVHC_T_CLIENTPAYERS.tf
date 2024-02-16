resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_CLIENTPAYERS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_CLIENTPAYERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_CLIENTPAYERS

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
	name = "CLIPAY_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIPAY_CLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIPAY_PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIPAY_SEQNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIPAY_POLICYNUMBER"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "CLIPAY_EFFECTIVEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIPAY_EXPIRATIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIPAY_BILLSPLITTYPEID"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CLIPAY_DEFAULTFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIPAY_AMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CLIPAY_PERCENT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "CLIPAY_DISCOUNTAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CLIPAY_DISCOUNTPERCENT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "CLIPAY_DEDUCTIBLE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CLIPAY_DEDUCTIBLEBALANCE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CLIPAY_COPAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIPAY_COPAYAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CLIPAY_COPAYPERCENT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "CLIPAY_COPAYMULTIPLIER"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CLIPAY_COPAYINVOICENOTE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLIPAY_NOTES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLIPAY_BILLNOTE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "CLIPAY_ACTIVEFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIPAY_EXCLUDEHOLIDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIPAY_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIPAY_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIPAY_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLIPAY_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIPAY_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIPAY_AUTHREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIPAY_AUTHSUSESERVICECATEGORIES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLIPAY_AUTHORIZATIONCONFLICTSALLOW"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CLIPAY_ADDRESSBOOKID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CLIPAY_CHARGEALLOCATIONSEQNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIPAY_MANAGECOB"
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

