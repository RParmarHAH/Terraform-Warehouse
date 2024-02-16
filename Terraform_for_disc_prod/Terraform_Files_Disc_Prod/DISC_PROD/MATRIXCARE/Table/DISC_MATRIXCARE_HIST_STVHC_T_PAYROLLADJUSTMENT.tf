resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_PAYROLLADJUSTMENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_PAYROLLADJUSTMENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_PAYROLLADJUSTMENT

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
	name = "PROLLA_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "PROLLA_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLA_SCHEDULEID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLA_PAYROLLADJCODE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLA_PAYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLA_UNIT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "PROLLA_RATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "PROLLA_STATUS"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PROLLA_RECALCOVERTIME"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PROLLA_NOTES"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "PROLLA_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLA_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLA_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLA_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLA_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROLLA_ORIGINALPAYDATE"
	type = "TIMESTAMP_NTZ(9)"
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

