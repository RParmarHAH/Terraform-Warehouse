resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_HIST_IL_INVDTLOL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "HIST_IL_INVDTLOL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.HIST_IL_INVDTLOL

    -- Purpose : Discovery Data Population

    -- Project : DATAFLEXSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORD_NUMBER"
	type = "NUMBER(12,0)"
	nullable = false
}


column {
	name = "INVOICE_NO"
	type = "NUMBER(12,0)"
	nullable = true
}


column {
	name = "DATEFROM"
	type = "DATE"
	nullable = true
}


column {
	name = "DATETO"
	type = "DATE"
	nullable = true
}


column {
	name = "HOURS"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "AMOUNT_PAID"
	type = "NUMBER(8,2)"
	nullable = true
}


column {
	name = "BILLCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILLING_NUMBER"
	type = "NUMBER(12,0)"
	nullable = true
}


column {
	name = "OLDRECNUM"
	type = "NUMBER(12,0)"
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

