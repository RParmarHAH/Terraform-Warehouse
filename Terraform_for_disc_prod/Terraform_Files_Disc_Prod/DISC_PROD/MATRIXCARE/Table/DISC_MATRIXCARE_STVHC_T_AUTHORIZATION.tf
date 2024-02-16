resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_AUTHORIZATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_AUTHORIZATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_AUTHORIZATION

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
	name = "AUTH_ID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "AUTH_ADMISSIONID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "AUTH_PAYERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "AUTH_SERVICECODEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AUTH_UNITFLAG"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "AUTH_BEGINDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AUTH_ENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AUTH_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AUTH_ACTIVEFLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTH_NOTES"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AUTH_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AUTH_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AUTH_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "AUTH_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AUTH_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "AUTH_POCID"
	type = "NUMBER(19,0)"
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

