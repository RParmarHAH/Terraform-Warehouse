resource "snowflake_table" "DISC_GENERATIONSALLIANCE_TELEPHONYCALLS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "TELEPHONYCALLS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.TELEPHONYCALLS

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
	name = "CALLSID"
	type = "VARCHAR(150)"
	nullable = false
}


column {
	name = "ACCOUNTSID"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "VERSION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CFROM"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CTO"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DIRECTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CALLERNAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "FCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FSTATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FZIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "FCOUNTRY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TOCITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TOSTATE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TOZIP"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TOCOUNTRY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DURATION"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "COSTPERMINUTE"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "BILLABLEMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALLEXPENSE"
	type = "NUMBER(5,2)"
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

