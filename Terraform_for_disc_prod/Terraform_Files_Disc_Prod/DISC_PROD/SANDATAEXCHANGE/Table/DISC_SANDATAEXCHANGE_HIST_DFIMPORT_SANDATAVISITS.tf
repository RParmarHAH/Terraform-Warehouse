resource "snowflake_table" "DISC_SANDATAEXCHANGE_HIST_DFIMPORT_SANDATAVISITS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAEXCHANGE"
	name = "HIST_DFIMPORT_SANDATAVISITS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAEXCHANGE.HIST_DFIMPORT_SANDATAVISITS

    -- Purpose : Discovery Data Population

    -- Project : SANDATAEXCHANGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "IMPORTVISITLINEID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "VISITKEY"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "IMPORTTASKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TIMESHEETID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "VISITID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENTNAME"
	type = "VARCHAR(75)"
	nullable = true
}


column {
	name = "CLIENTLOCATION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYEENAME"
	type = "VARCHAR(75)"
	nullable = true
}


column {
	name = "ADMISSIONTYPEID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EVENTID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TIMEIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMEOUT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIMEZONE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STATUSCODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "IMPORTBATCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CHANGEDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HOURS"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "IMPORTEDTODF"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ALLOWFUTUREIMPORT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "UPDATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATETASKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ARCHIVETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "READTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "IMPORTKEY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ORIGINALHOURS"
	type = "NUMBER(18,5)"
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

