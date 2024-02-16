resource "snowflake_table" "DISC_SANDATAEXCHANGE_HIST_DFIMPORT_IMPORTVISITS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAEXCHANGE"
	name = "HIST_DFIMPORT_IMPORTVISITS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAEXCHANGE.HIST_DFIMPORT_IMPORTVISITS

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
	name = "LINEID"
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
	name = "STATE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "REFNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TRACKINGID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CLIENTNO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EMPLOYEENO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CONTRACTCODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "BILLCODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PAYROLLDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "WEEKENDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OFFICENO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SUPERVISORCODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "ISIMPORTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "READTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ISVALID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "VISITCHANGETYPE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SERVICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HOURSDELTA"
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

