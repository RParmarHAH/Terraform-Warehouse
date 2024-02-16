resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_ATTRIBUTE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_ATTRIBUTE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_ATTRIBUTE

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
	name = "ATR_ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "ATR_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ATR_SORT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ATR_CLASSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ATR_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ATR_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ATR_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ATR_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ATR_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ATR_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ATR_LISTITEMTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ATR_RPTGROUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ATR_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ATR_OVERRIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ATR_DESCRIPTION"
	type = "VARCHAR(1000)"
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

