resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_CLIENTSTATUS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_CLIENTSTATUS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_CLIENTSTATUS

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
	name = "CLS_ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CLS_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLS_SHOWORHIDE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLS_LISTITEMTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CLS_RPTGROUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLS_OVERRIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLS_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLS_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CLS_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLS_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLS_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLS_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLS_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLS_DESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CLS_UPLOADTELEPHONY"
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

