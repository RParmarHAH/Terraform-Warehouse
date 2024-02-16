resource "snowflake_table" "DISC_GENERATIONSALLIANCE_ARAUTHENTICARELOG" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "ARAUTHENTICARELOG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.ARAUTHENTICARELOG

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
	name = "ARLOGID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "LOGDATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "INVOICEID"
	type = "VARCHAR(56)"
	nullable = true
}


column {
	name = "INVOICEGROUPID"
	type = "VARCHAR(56)"
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
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EXPORTEDBY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "EXPORTEDON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "APIREQUEST"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "APIRESPONSE"
	type = "VARCHAR(2000)"
	nullable = true
}


column {
	name = "STATECODE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "AUTHBATCHID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SFTPERRORDATA"
	type = "VARCHAR(2000)"
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

