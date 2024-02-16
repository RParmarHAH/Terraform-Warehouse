resource "snowflake_table" "DISC_HHAEXCHANGEPREFERRED_TBLINVOICEDETAILS_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEPREFERRED"
	name = "TBLINVOICEDETAILS_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEPREFERRED.TBLINVOICEDETAILS_REPL

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
	name = "INVOICEDETAILID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVOICEHEADERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITSTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "VISITENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BILLEDHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILLEDRATE"
	type = "NUMBER(18,6)"
	nullable = true
}


column {
	name = "OVERTIMEHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OVERTIMERATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "TRAVELTIMEHOURS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRAVELTIMERATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVSERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVCONTRACTSERVICECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVRATETYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "VISITPAYMENTSTATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "BILLEDUNITS"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "AUTHORIZATIONNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LASTEXPORTEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PATIENTPAIDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVOICEDETAILID3RDPARTY"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "EBILLINGHOLD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAYERREFERENCENUMBER"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUBMISSIONDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SUBMISSIONUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EBILLINGHOLDREASONTEXT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DFTAVISIT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EXTERNALSCHEDULEID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXTERNALINVOICENUMBER"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "EXTERNALCLAIMNUMBER"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "BILLINGLINEITEMID"
	type = "VARCHAR(50)"
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
	name = "CREATEDUTCDATE"
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

