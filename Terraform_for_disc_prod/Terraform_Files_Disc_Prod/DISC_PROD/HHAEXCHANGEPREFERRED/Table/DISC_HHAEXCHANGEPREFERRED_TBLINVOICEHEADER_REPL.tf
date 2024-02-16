resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_TBLINVOICEHEADER_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "TBLINVOICEHEADER_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.TBLINVOICEHEADER_REPL

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
	name = "INVOICEHEADERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "COORDINATORID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYMENTSTATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVOICEAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INHVISITFROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INHVISITTO"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INHHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INHOTHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INHTTHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VENDORINVOICENUMBER"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYERREFNO"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MEMO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INHBILLEDUNITS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PATIENTPAIDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "REBILLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTPRINTEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDUTCDATE"
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

