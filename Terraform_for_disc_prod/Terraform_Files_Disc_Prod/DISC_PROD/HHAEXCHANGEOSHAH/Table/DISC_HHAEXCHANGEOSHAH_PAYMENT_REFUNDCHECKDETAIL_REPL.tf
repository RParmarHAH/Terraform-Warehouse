resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_PAYMENT_REFUNDCHECKDETAIL_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "PAYMENT_REFUNDCHECKDETAIL_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.PAYMENT_REFUNDCHECKDETAIL_REPL

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
	name = "REFUNDCHECKDETAILID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "TYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFUNDCHECKHEADERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CHECKNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REFCHECKID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "REFCHECKNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CREDITPATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREDITTYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "POSTEDDATE"
	type = "TIMESTAMP_NTZ(9)"
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

