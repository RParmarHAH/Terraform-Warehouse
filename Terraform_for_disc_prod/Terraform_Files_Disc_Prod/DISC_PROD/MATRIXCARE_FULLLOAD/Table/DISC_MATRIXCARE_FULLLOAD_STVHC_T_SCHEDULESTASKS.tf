resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_STVHC_T_SCHEDULESTASKS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "STVHC_T_SCHEDULESTASKS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.STVHC_T_SCHEDULESTASKS

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
	name = "SCHTSK_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHTSK_SCHID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "SCHTSK_TASKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SCHTSK_NOTES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SCHTSK_FROMTELEPHONY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCHTSK_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCHTSK_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHTSK_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHTSK_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHTSK_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHTSK_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SCHTSK_NUMERICVALUE"
	type = "NUMBER(6,2)"
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

