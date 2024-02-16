resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_PAYROLLADJUSTMENTCODE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_PAYROLLADJUSTMENTCODE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_PAYROLLADJUSTMENTCODE

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
	name = "PROLLAC_ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PROLLAC_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROLLAC_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLAC_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLAC_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLAC_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLAC_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROLLAC_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLAC_LISTITEMTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PROLLAC_RPTGROUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLAC_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLAC_DESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PROLLAC_OVERRIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLAC_PAYROLLCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLAC_DEDUCTEARN"
	type = "VARCHAR(5)"
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

