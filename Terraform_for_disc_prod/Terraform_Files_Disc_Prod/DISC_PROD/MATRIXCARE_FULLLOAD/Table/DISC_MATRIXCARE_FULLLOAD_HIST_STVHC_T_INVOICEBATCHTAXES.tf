resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_INVOICEBATCHTAXES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_INVOICEBATCHTAXES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_INVOICEBATCHTAXES

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
	name = "INVBTX_ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "INVBTX_INVBATCHGROUPID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "INVBTX_TAXTYPEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVBTX_TAXID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVBTX_PERCENT"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "INVBTX_FIXEDAMT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "INVBTX_DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INVBTX_EFFECTIVESTART"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVBTX_EFFECTIVEEND"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVBTX_HCPCS"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "INVBTX_DESC"
	type = "VARCHAR(100)"
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

