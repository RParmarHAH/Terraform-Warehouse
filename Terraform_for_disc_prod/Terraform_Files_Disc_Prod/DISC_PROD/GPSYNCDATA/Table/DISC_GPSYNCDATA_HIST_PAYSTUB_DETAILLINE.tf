resource "snowflake_table" "DISC_GPSYNCDATA_HIST_PAYSTUB_DETAILLINE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "HIST_PAYSTUB_DETAILLINE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.HIST_PAYSTUB_DETAILLINE

    -- Purpose : Discovery Data Population

    -- Project : GPSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DETAILLINEID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "CHECKID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "PAYCODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CODETYPES"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "RATE"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "UNITS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "AMOUNTYTD"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "DESCRIPTIONS"
	type = "VARCHAR(1024)"
	nullable = true
}


column {
	name = "ISREIMBURSEMENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISUNIONDUE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISTAX"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISWAGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISHISTORY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ISHIDINGRATE"
	type = "NUMBER(10,0)"
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

