resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_REFERRALBYSTATUS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_REFERRALBYSTATUS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_REFERRALBYSTATUS

    -- Purpose : Discovery Data Population

    -- Project : MATRIXCARE_FULLLOAD

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "REFBY_ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "REFBY_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REFBY_SHOWORHIDE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REFBY_LISTITEMTYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "REFBY_RPTGROUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFBY_BRANCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFBY_OVERRIDEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFBY_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REFBY_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFBY_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REFBY_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFBY_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REFBY_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REFBY_DESCRIPTION"
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

