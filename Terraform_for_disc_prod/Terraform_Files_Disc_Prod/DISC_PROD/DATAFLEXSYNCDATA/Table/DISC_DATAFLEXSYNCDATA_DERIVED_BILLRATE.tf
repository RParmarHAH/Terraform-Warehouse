resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_DERIVED_BILLRATE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "DERIVED_BILLRATE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.DERIVED_BILLRATE

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
	name = "DBNAME"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "BILL_CODE"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "BILL_RATE"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "EFFECTIVE_FROM_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EFFECTIVE_TO_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "BILL_RATE_LEVEL"
	type = "VARCHAR(12)"
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

