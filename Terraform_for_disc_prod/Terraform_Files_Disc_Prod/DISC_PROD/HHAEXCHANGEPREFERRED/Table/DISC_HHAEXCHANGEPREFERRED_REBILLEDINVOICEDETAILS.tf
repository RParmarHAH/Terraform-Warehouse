resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_REBILLEDINVOICEDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "REBILLEDINVOICEDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.REBILLEDINVOICEDETAILS

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
	name = "REBILLEDINVOICEDETAILID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVOICEHEADERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PREVINVOICENUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVOICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "BATCHNUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "VISITDURATION"
	type = "VARCHAR(61)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ADMISSIONID"
	type = "VARCHAR(80)"
	nullable = true
}


column {
	name = "PATIENTNAME"
	type = "VARCHAR(163)"
	nullable = true
}


column {
	name = "ADDRESS"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "TOTALHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILLEDUNITS"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "THRDPARTYAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "TOTALAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "CONTRACT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAIDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "DISCOUNT"
	type = "NUMBER(10,2)"
	nullable = true
}


column {
	name = "PAYMENTSTATUS"
	type = "VARCHAR(14)"
	nullable = true
}


column {
	name = "DELETEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DELETEDDATE"
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

