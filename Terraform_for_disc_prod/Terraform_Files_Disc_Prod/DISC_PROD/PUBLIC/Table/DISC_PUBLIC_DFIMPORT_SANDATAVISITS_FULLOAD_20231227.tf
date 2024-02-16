resource "snowflake_table" "DISC_PUBLIC_DFIMPORT_SANDATAVISITS_FULLOAD_20231227" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "DFIMPORT_SANDATAVISITS_FULLOAD_20231227"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.DFIMPORT_SANDATAVISITS_FULLOAD_20231227

    -- Purpose : Discovery Data Population

    -- Project : PUBLIC

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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITKEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IMPORTTASKID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMESHEETID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGENCYID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISITID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENTNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENTLOCATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEENAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSIONTYPEID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICECODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVENTID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMEIN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMEOUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIMEZONE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUSCODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IMPORTBATCHID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHANGEDTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IMPORTEDTODF"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ALLOWFUTUREIMPORT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATETIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATETASKID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ARCHIVETIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "READTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IMPORTKEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORIGINALHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

