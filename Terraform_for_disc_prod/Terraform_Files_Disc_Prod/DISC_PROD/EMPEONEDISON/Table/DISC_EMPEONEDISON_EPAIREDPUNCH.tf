resource "snowflake_table" "DISC_EMPEONEDISON_EPAIREDPUNCH" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	name = "EPAIREDPUNCH"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONEDISON.EPAIREDPUNCH

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
	name = "PAIREDPUNCHID"
	type = "VARCHAR(36)"
	nullable = false
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
	name = "CALENDARID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "POSTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "INRAWPUNCH"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "OUTRAWPUNCH"
	type = "VARCHAR(36)"
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
	name = "TOTALMINUTES"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "VOIDID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "VOIDEDID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "ADJUSTMENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EXCLUDEFROMPAYROLL"
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

