resource "snowflake_table" "DISC_EMPEONEDISON_CJENTRIES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	name = "CJENTRIES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONEDISON.CJENTRIES

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
	name = "CO"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "PROCESS"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "ENTRYDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "GL1"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GL2"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GL3"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GL4"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GL5"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "GL6"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CD"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DET"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DETCODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "HOURS"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "GUIDFIELD"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "LASTCHANGE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CALENDARID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "LASTCHANGEUSER"
	type = "VARCHAR(50)"
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

