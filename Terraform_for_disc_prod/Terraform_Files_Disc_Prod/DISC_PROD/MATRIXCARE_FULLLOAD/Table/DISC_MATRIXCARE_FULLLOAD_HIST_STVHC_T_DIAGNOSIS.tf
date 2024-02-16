resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_DIAGNOSIS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_DIAGNOSIS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_DIAGNOSIS

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
	name = "DIAG_ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "DIAG_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIAG_DESCRIPTION"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "DIAG_DIAGNOSISCATEGORY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DIAG_EFFECTIVESTARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DIAG_EFFECTIVEENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DIAG_SURGICALPROCEDURE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DIAG_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DIAG_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DIAG_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DIAG_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DIAG_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DIAG_DIAGNOSISID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DIAG_SURGICALPROCEDUREID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DIAG_LONGDESCRIPTION"
	type = "VARCHAR(350)"
	nullable = true
}


column {
	name = "DIAG_VERSION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DIAG_ACTIVE"
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

