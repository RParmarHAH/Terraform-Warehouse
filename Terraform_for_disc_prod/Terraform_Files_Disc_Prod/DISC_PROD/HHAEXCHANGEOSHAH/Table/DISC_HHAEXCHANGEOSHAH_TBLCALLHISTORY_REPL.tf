resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_TBLCALLHISTORY_REPL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "TBLCALLHISTORY_REPL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.TBLCALLHISTORY_REPL

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
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "CALLHISTORYID"
	type = "NUMBER(19,0)"
	nullable = false
}


column {
	name = "VISITID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "ASSIGNMENTID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CALLTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALLDURATION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CALLSTATUS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TASKSPERFORMED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CALLERID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LINKEDBY"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "LINKEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EVVTYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EVVSOURCE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LONGITUDE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LATITUDE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "EVVPATIENTID"
	type = "NUMBER(19,0)"
	nullable = true
}


column {
	name = "LINKEDUTCDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CAREGIVERID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "AUTOSCHEDULESERVICETYPEID"
	type = "VARCHAR(10)"
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

