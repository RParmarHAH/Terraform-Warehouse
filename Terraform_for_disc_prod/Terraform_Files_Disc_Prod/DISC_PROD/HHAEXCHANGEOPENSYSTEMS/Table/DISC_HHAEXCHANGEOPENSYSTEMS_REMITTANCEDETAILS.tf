resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_REMITTANCEDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "REMITTANCEDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.REMITTANCEDETAILS

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
	nullable = false
}


column {
	name = "REMITTANCEID"
	type = "VARCHAR(26)"
	nullable = false
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
	name = "CHECKAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRACTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VISITID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "CLAIMSTATUS"
	type = "VARCHAR(6)"
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
	name = "PAYERREFERENCENUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PATIENTNAME"
	type = "VARCHAR(101)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VALIDATIONSTATUS"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "MODIFIEDDATE"
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

