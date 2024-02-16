resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_PAYROLLBATCH" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_PAYROLLBATCH"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_PAYROLLBATCH

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
	name = "PROLLB_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "PROLLB_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLB_EXTRACTTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLB_PAYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLB_FINALIZEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLB_CAREGIVERGROUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLB_PAYROLLCOMPANYEXTRACTTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PROLLB_LASTPRCOMPANYEXTRACTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLB_LASTPRCOMPANYEXTRACTUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLB_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLB_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLB_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLB_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLB_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROLLB_CANCELUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLB_CANCELDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLB_SERVICETHROUGHDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLB_LASTDRAFTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PROLLB_LASTDRAFTUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PROLLB_CAREGIVERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PROLLB_OTSETTINGS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROLLB_ISHOLIDAYOTELIGIBLE"
	type = "BOOLEAN"
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

