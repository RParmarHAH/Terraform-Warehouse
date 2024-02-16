resource "snowflake_table" "DISC_GPSYNCDATA_HIST_PAYSTUB_ACCOUNTLINE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "HIST_PAYSTUB_ACCOUNTLINE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.HIST_PAYSTUB_ACCOUNTLINE

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
	name = "CHECKACCOUNTID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "CHECKID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "ROUTINGNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ACCOUNTNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "ACCOUNTTYPE"
	type = "VARCHAR(50)"
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

