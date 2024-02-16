resource "snowflake_table" "DISC_MATRIXCARE_FULLLOAD_HIST_STVHC_T_INVOICEPROCESS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "MATRIXCARE_FULLLOAD"
	name = "HIST_STVHC_T_INVOICEPROCESS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.MATRIXCARE_FULLLOAD.HIST_STVHC_T_INVOICEPROCESS

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
	name = "INVPR_ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "INVPR_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVPR_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVPR_SPDRAFTNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVPR_SPCHECKTSNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVPR_SPFINALIZENAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVPR_SPUNBILLBATCH"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVPR_SPUNBILLINVOICE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVPR_SPREVERSEINVOICE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVPR_SPTRANSFERINVOICE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVPR_INFOCLASSID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "INVPR_CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVPR_CREATEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVPR_MODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "INVPR_MODIFIEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVPR_TS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "INVPR_DESCRIPTION"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "INVPR_SPCHECKEDITS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVPR_GROUPBY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVPR_GROUPBYAUTH"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVPR_SPGROUPINGLOGIC"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVPR_SPLATEGROUPING"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INVPR_KEYPREPARECOB"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVPR_KEYCREATECOB"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INVPR_PROCESSINGINSTRUCTIONS"
	type = "VARIANT"
	nullable = true
}


column {
	name = "INVPR_ISPPS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INVPR_BASEDRAFTTYPE"
	type = "NUMBER(3,0)"
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

