resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_EREMITTANCEPREVIEW" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "EREMITTANCEPREVIEW"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.EREMITTANCEPREVIEW

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
	nullable = false
}


column {
	name = "CHECKINFOID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYMENTID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "CONTRACTNAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "VENDORNAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "RECEIVEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CHECKNUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CHECKDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLAIMNUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PATIENTNUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PATIENTNAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PAIDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PATIENTRESPAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PATIENTREFNUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADJUSTMENTCODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ADJUSTMENTAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "ADJUSTMENTDESCRIPTION"
	type = "VARCHAR(5000)"
	nullable = true
}


column {
	name = "REJECTEDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CLAIMSTATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REMARKCODE"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "INTERESTAMT"
	type = "NUMBER(18,2)"
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

