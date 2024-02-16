resource "snowflake_table" "DISC_GENERATIONSALLIANCE_HHAXLOG" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "HHAXLOG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.HHAXLOG

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
	name = "HHAXLOGID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "LOGDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ERRORS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RECORDID"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DETAILS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOGFILENAME"
	type = "VARCHAR(60)"
	nullable = true
}


column {
	name = "HHAXSTATECODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "PAYORID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MEDRECNUM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICEALTDESC"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SCHEDULESTARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULEENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATUSRETRYCOUNT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EVVMSID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "TRANSACTIONID"
	type = "VARCHAR(40)"
	nullable = true
}


column {
	name = "UNITSPERHOUR"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "APISTATUSCODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "APIRESPONSE"
	type = "VARCHAR(16777216)"
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

