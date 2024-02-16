resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_BILLTYPE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_BILLTYPE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_BILLTYPE

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
	name = "BILTYP_ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "BILTYP_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILTYP_PRINTFORMAT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BILTYP_INVPROCESSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILTYP_BILLINGSTATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILTYP_NEWBILLINGSTATUSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILTYP_REPORTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILTYP_ALLOWDETAILEXCLUDE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILTYP_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BILTYP_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILTYP_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BILTYP_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILTYP_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BILTYP_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BILTYP_DESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "BILTYP_DEFREVENUE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILTYP_ALLOWUICHANGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILTYP_ALLOWEMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILTYP_ALLOWMULTIPRINT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "BILTYP_REPORTID"
	type = "NUMBER(10,0)"
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

