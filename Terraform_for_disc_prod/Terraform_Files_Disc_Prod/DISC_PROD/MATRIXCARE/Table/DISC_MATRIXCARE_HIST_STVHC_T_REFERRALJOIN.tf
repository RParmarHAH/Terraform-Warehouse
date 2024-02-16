resource "snowflake_table" "DISC_MATRIXCARE_HIST_STVHC_T_REFERRALJOIN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "HIST_STVHC_T_REFERRALJOIN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.HIST_STVHC_T_REFERRALJOIN

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
	name = "REFJOIN_ID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "REFJOIN_REFERRALBYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "REFJOIN_REFERRALFACILITYID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "REFJOIN_NOTES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "REFJOIN_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFJOIN_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REFJOIN_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFJOIN_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REFJOIN_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REFJOIN_STARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFJOIN_ENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "REFJOIN_REFERRALRATINGID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REFJOIN_BRANCHID"
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

