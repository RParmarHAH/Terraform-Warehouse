resource "snowflake_table" "DISC_EMPEONEDISON_ERAWPUNCH" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	name = "ERAWPUNCH"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONEDISON.ERAWPUNCH

    -- Purpose : Discovery Data Population

    -- Project : EMPEONEDISON

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RAWPUNCHID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "IGNORED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLOCKNUMBER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DEVICEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CALENDARID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "SOURCE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "UTCTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ORIGUTCTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ORIGLOCALTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LATITUDE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "LONGITUDE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "ACCURACY"
	type = "FLOAT"
	nullable = true
}


column {
	name = "SHIFT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CC5"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "JOBCODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "COMMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LASTCHANGE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LASTCHANGEUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "LOCALTIME_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ORIGTIMEOFFSET"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TIMEOFFSET"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ORIGTIMEZONEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "TIMEZONEID"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PUNCHDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DRAGGEDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DRAGGEDUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ORIGTYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CUSTOM1"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CUSTOM2"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CUSTOM3"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CUSTOM4"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CUSTOM5"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CUSTOM6"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CUSTOM7"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "ISVOID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "DETCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MEALNOTTAKEN"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RATE"
	type = "NUMBER(14,6)"
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

