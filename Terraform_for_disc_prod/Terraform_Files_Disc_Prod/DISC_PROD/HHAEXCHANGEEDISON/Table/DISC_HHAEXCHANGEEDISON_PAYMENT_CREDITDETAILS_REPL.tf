resource "snowflake_table" "DISC_HHAEXCHANGEEDISON_PAYMENT_CREDITDETAILS_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEEDISON"
	name = "PAYMENT_CREDITDETAILS_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEEDISON.PAYMENT_CREDITDETAILS_REPL

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEEDISON

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
	name = "CREDITDETAILID"
	type = "NUMBER(19,0)"
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
	name = "CHECKID"
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
	name = "VISITID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AMOUNT"
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
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISIT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "OTHERCHARGEID"
	type = "NUMBER(10,0)"
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

