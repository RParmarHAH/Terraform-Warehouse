resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_VISITS_28" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "VISITS_28"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.VISITS_28

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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULEDSTARTTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULEDENDTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IVRCALLIN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IVRCALLOUT"
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
	name = "DUTIES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APPROVEDTRAVELTIMEHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MISSEDVISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMESHEETREQUIRED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMESHEETRECEIVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYBILLTO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYSERVICECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYCONTRACTHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARYBILLTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISCIPLINE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SECONDARYBILLTO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SECONDARYSERVICECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SECONDARYCONTRACTHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SECONDARYBILLTYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLEDHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRAVELTIMEHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OVERTIMEHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICEDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BATCHNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGEXPORTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLINGEXPORTDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AIDEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYRATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAIDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYROLLBATCHNUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYROLLEXPORTED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYROLLEXPORTDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAIDAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAIDHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "THIRDPARTYAMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLEDRATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTRACTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYERID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IMPORTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVVSOURCESTARTTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVVTYPESTARTTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVVSOURCEENDTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVVTYPEENDTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INVOICEDETAILID"
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

