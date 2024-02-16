resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_BILLING_PAIDVISITS_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "BILLING_PAIDVISITS_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.BILLING_PAIDVISITS_REPL

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOSHAH

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
	name = "PAYMENTDETAILID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CHECKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAIDAMOUNT"
	type = "NUMBER(18,2)"
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
	name = "UPDATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UPDATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "PAYERREFERENCENUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OTHERADJUSTMENT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "NOTES"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "CREDITS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OTHERCHARGEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POSTEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DEPOSITDATE"
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

