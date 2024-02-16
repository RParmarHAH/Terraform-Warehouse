resource "snowflake_table" "DISC_GENERATIONSALLIANCE_TMPQBINVJOB" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "TMPQBINVJOB"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.TMPQBINVJOB

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
	name = "EMPLOYEE"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "SUMTOTALHOURS"
	type = "NUMBER(9,2)"
	nullable = true
}


column {
	name = "CLIENT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TSDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "MODIFIER"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "CLIENT_QUICKBOOKSID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICES_QUICKBOOKSID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "RECEIVEDTIMECARD"
	type = "BOOLEAN"
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
	name = "BILLABLE"
	type = "NUMBER(9,2)"
	nullable = true
}


column {
	name = "QBFULLNAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CLASSNAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "FLATRATE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AUTHNUMBER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CASEMANAGER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "COST"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "LOCATIONID"
	type = "VARCHAR(3)"
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

