resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_TBLINVOICEDETAILS_REPL_28" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "TBLINVOICEDETAILS_REPL_28"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.TBLINVOICEDETAILS_REPL_28

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
	name = "INVOICEDETAILID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICEHEADERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITSTARTTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITENDTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLEDHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLEDRATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVERTIMEHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVERTIMERATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRAVELTIMEHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRAVELTIMERATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVSERVICECODEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVCONTRACTSERVICECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVRATETYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITPAYMENTSTATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLEDUNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTHORIZATIONNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTEXPORTEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTPAIDAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICEDETAILID3RDPARTY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EBILLINGHOLD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYERREFERENCENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUBMISSIONDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUBMISSIONUTCDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EBILLINGHOLDREASONTEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DFTAVISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTERNALSCHEDULEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTERNALINVOICENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTERNALCLAIMNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGLINEITEMID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDUTCDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATEDBY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATEDUTCDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

