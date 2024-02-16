resource "snowflake_table" "DISC_HHAEXCHANGEOPENSYSTEMS_DELETEDINVOICE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOPENSYSTEMS"
	name = "DELETEDINVOICE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOPENSYSTEMS.DELETEDINVOICE

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
	nullable = true
}


column {
	name = "DELETEDINVOICEID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "PATIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "VISITDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULEDSTARTTIME"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SCHEDULEDENDTIME"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "IVRCALLIN"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "IVRCALLOUT"
	type = "VARCHAR(1)"
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
	name = "DUTIES"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "APPROVEDTRAVELTIMEHOURS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "MISSEDVISIT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TIMESHEETREQUIRED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TIMESHEETRECEIVED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PRIMARYBILLTO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIMARYSERVICECODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PRIMARYCONTRACTHOURS"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PRIMARYBILLTYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DISCIPLINE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SECONDARYBILLTO"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SECONDARYSERVICECODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SECONDARYCONTRACTHOURS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "SECONDARYBILLTYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BILLED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BILLEDHOURS"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "TRAVELTIMEHOURS"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "OVERTIMEHOURS"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "BILLEDAMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVOICENUMBER"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVOICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BATCHNUMBER"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BILLINGEXPORTED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BILLINGEXPORTDATE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYRATE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAID"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAIDDATE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAYROLLBATCHNUMBER"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAYROLLEXPORTED"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAYROLLEXPORTDATE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAIDAMOUNT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAIDHOURS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "THIRDPARTYAMOUNT"
	type = "VARCHAR(1)"
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

