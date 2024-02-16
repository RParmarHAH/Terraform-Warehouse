resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_SCHEDULEEXPENSES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_SCHEDULEEXPENSES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_SCHEDULEEXPENSES

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SCHEXP_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "SCHEXP_SCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHEXP_EXPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHEXP_CLIENTPAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHEXP_PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHEXP_COSTUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SCHEXP_COSTRATEOVERRIDEAMT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHEXP_COSTRATEOVERRIDEMODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEXP_COSTRATEOVERRIDEMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEXP_BILLUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SCHEXP_BILLRATEUNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCHEXP_BILLRATEOVERRIDEAMT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHEXP_BILLRATEOVERRIDEMODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEXP_BILLRATEOVERRIDEMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEXP_BILLRATEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHEXP_BILLRATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHEXP_PAYUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SCHEXP_PAYRATEUNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "SCHEXP_PAYRATEOVERRIDEAMT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHEXP_PAYRATEOVERRIDEMODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEXP_PAYRATEOVERRIDEMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEXP_NOTES"
	type = "VARCHAR(255)"
	nullable = true
}


column {
	name = "SCHEXP_PAYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEXP_REVENUECODE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHEXP_PAYCODE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHEXP_PAYREVIEWFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCHEXP_PAYROLLBATCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHEXP_NOTESDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEXP_BILLINGSTATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHEXP_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEXP_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEXP_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEXP_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEXP_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SCHEXP_TOTALCHARGE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHEXP_BILLOTUNITS"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SCHEXP_BILLOTMULTI"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SCHEXP_ORIGINALPAYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEXP_TOTALBILLABLE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHEXP_TOTALBILLED"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHEXP_TOTALPAID"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "SCHEXP_INVOICEDETAILDESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INSERTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DELETEDFLAG"
	type = "BOOLEAN"
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

