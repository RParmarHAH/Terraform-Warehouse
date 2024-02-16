resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_TRANSACTIONS_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "TRANSACTIONS_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.TRANSACTIONS_REPL

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEPREFERRED

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
	name = "SEQ"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRANSACTIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TRANSACTIONNUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TRANSACTIONTYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TRANSACTIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DEBITAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CREDITAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CHECKDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DEPOSITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BILLEDHOURS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BILLEDUNITS"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POSTEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RATETYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CAREIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DISCIPLINEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TTHOURS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OTHOURS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CHARGETYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OTHERCHARGEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITADJUSTMENTREASONTEXT"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "REFUNDCHECKHEADERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "TRANSACTIONUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREDITREFNUMBER"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "OTHERADJUSTMENT"
	type = "NUMBER(10,2)"
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

