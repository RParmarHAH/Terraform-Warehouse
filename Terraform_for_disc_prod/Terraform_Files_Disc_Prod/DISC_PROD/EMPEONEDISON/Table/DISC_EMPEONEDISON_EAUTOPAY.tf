resource "snowflake_table" "DISC_EMPEONEDISON_EAUTOPAY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	name = "EAUTOPAY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONEDISON.EAUTOPAY

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
	name = "ID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "STARTDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "HOURS"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "RATE"
	type = "NUMBER(14,6)"
	nullable = true
}


column {
	name = "RATECODE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "NUMBER(14,2)"
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
	name = "OTC1"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OTC2"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OTC3"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "OTC4"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "GOAL"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "PAIDTOWARDSGOAL"
	type = "NUMBER(14,2)"
	nullable = true
}


column {
	name = "FREQUENCY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LASTDATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "LASTCHANGEUSER"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SEQUENCE"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DEFAULTCHECKATTRIBUTES"
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

