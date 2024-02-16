resource "snowflake_table" "DISC_DATAFLEXSYNCDATA_CALLSFIELD" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATAFLEXSYNCDATA"
	name = "CALLSFIELD"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATAFLEXSYNCDATA.CALLSFIELD

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
	type = "VARCHAR(9999999)"
	nullable = true
}


column {
	name = "DATE_TIME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "LOG_IN_OUT"
	type = "VARCHAR(9999999)"
	nullable = true
}


column {
	name = "EMP_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CALLER_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "MINS_WORKED"
	type = "VARCHAR(9999999)"
	nullable = true
}


column {
	name = "SHARED"
	type = "VARCHAR(9999999)"
	nullable = true
}


column {
	name = "CLIENT_NAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "OFFICE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DESK"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICE_TYPE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROCESSED_MODULE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(100)"
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

