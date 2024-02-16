resource "snowflake_table" "DISC_GENERATIONSALLIANCE_TBL_ALERTLOG" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "TBL_ALERTLOG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.TBL_ALERTLOG

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "INT_ALERTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "DTM_SENT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STR_EMAIL"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "INT_SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STR_SUBJECT"
	type = "VARCHAR(600)"
	nullable = true
}


column {
	name = "STR_CONTENT"
	type = "VARCHAR(7000)"
	nullable = true
}


column {
	name = "BIT_STATUS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALERTTYPE"
	type = "VARCHAR(15)"
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

