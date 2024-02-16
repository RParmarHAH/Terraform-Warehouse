resource "snowflake_table" "DISC_GENERATIONSALLIANCE_TIMESHEETHISTORY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "TIMESHEETHISTORY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.TIMESHEETHISTORY

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
	name = "ID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PAYPERIODID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DATETIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FUNCTION"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "USERNAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "REC_ADDED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REC_UPDATED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REC_DELETED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CHKBILLEPAID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CHKRECVD"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TOTALPROCESSED"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CHKCONFIRMEDONLY"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CHKINCAVAILABLESHIFT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CHKSPLITMIDNIGHT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "REC_EXPENSECOUNT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REC_COUNTBILLEDORPAID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "REC_DELETEDEXPENSECOUNT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(1)"
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

