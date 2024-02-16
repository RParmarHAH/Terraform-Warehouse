resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_STAGE_TBLPOCDETAIL_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "STAGE_TBLPOCDETAIL_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.STAGE_TBLPOCDETAIL_REPL

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOSHAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCDETAILID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "POCHEADERID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "POCTASKID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TIMESPERWEEKMIN"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TIMESPERWEEKMAX"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "MONDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SUNDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TUESDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "WEDNESDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "THURSDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FRIDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SATURDAY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ASNEEDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TASKINSTRUCTION"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "TIMESPERWEEKMINMAX"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "DAYSOFWEEK"
	type = "VARCHAR(57)"
	nullable = true
}


column {
	name = "OFFICEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "POCPATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "PATIENTPOCMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LONGTERMREQUIRED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTMODIFIEDBY"
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

