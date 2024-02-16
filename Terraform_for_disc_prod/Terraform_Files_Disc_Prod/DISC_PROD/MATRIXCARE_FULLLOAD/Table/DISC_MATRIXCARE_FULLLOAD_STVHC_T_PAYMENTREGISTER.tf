resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_STVHC_T_PAYMENTREGISTER" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "STVHC_T_PAYMENTREGISTER"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_PAYMENTREGISTER

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
	name = "PMTREG_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PMTREG_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PMTREG_NUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PMTREG_AMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PMTREG_NETPAYMENT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PMTREG_PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PMTREG_DATED"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PMTREG_DEPOSITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PMTREG_MEMO"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PMTREG_PAYMENTREGISTERSTATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PMTREG_CLIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PMTREG_PERIODDATESID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PMTREG_PAYMENTREGISTERTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PMTREG_ORDERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PMTREG_AUTHORIZATIONNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PMTREG_TRANSACTIONNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PMTREG_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PMTREG_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PMTREG_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PMTREG_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PMTREG_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PMTREG_ACCTEXTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PMTREG_ACCTEXTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PMTREG_DEPOSITBALANCE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PMTREG_AVAILABLETOPOST"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PMTREG_EDIID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PMTREG_ELECTPMTCUSTID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "PMTREG_ELECTPMTCUSTPMTID"
	type = "VARCHAR(20)"
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

