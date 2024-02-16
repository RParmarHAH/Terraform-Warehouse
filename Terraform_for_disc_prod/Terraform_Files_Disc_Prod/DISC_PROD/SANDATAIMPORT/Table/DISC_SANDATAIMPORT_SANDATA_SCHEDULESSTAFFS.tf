resource "snowflake_table" "DISC_SANDATAIMPORT_SANDATA_SCHEDULESSTAFFS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "SANDATAIMPORT"
	name = "SANDATA_SCHEDULESSTAFFS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.SANDATAIMPORT.SANDATA_SCHEDULESSTAFFS

    -- Purpose : Discovery Data Population

    -- Project : SANDATAIMPORT

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
	nullable = true
}


column {
	name = "AGENCYID"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "SCHEDULEID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STAFFSCHEDHDRID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STAFFSCHEDDTLID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "STAFFID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "EVENTID"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "AUTHORIZATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "UNITTYPE"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(6)"
	nullable = true
}


column {
	name = "RATE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "DURATION"
	type = "NUMBER(5,2)"
	nullable = true
}


column {
	name = "SEDUNITS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CREATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDAT"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "HASHEDROWVALUES"
	type = "VARCHAR(250)"
	nullable = true
}


column {
	name = "BATCHID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "OVERTIME"
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
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

