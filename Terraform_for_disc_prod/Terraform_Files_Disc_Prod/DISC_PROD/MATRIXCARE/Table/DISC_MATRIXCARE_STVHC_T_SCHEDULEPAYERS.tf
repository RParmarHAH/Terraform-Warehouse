resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_SCHEDULEPAYERS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_SCHEDULEPAYERS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_SCHEDULEPAYERS

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
	name = "SCHCP_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHCP_CLIENTPAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHCP_PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHCP_ADMISSIONID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHCP_SCHEDULEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHCP_SCHEDULEEXPENSEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHCP_SEQNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHCP_BILLSPLITTYPEID"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SCHCP_AMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHCP_PERCENT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SCHCP_DISCOUNTAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHCP_DISCOUNTPERCENT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SCHCP_COPAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHCP_COPAYINVOICENOTE"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SCHCP_NOTES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SCHCP_SOURCE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHCP_EXCLUDEHOLIDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCHCP_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHCP_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHCP_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHCP_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHCP_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SCHCP_INVOICEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHCP_CANCELDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHCP_ADDRESSBOOKID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHCP_FEECHARTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHCP_CHARGEALLOCATIONSEQNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHCP_TRANSFERFROMINVOICEHEADERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHCP_TRANSFERTOINVOICEHEADERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHCP_MANAGECOB"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHCP_COBSTATUS"
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

