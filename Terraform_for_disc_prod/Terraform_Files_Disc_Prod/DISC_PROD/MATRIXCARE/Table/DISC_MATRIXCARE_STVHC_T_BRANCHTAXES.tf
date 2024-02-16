resource "snowflake_table" "DISC_MATRIXCARE_STVHC_T_BRANCHTAXES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE"
	name = "STVHC_T_BRANCHTAXES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE.STVHC_T_BRANCHTAXES

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
	name = "BRTX_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BRTX_GROUPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BRTX_TAXTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BRTX_DESC"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BRTX_PERCENT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "BRTX_FIXEDAMT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "BRTX_EFFECTIVESTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BRTX_EFFECTIVEEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BRTX_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BRTX_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRTX_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BRTX_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "BRTX_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BRTX_HCPCS"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "BRTX_ACCTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BRTX_ACCTCODE"
	type = "VARCHAR(50)"
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

