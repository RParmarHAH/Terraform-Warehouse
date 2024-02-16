resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_STVHC_T_PAYERBRANCHES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "STVHC_T_PAYERBRANCHES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_PAYERBRANCHES

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
	name = "PAYBR_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYBR_PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PAYBR_BRANCH_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAYBR_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYBR_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYBR_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PAYBR_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYBR_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PAYBR_ALLOWFLEXIBLETIMESCHEDULING"
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
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

