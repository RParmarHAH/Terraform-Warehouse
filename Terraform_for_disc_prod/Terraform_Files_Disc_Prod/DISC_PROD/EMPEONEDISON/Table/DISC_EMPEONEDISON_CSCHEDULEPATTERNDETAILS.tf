resource "snowflake_table" "DISC_EMPEONEDISON_CSCHEDULEPATTERNDETAILS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	name = "CSCHEDULEPATTERNDETAILS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONEDISON.CSCHEDULEPATTERNDETAILS

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
	name = "PATTERNDETAILID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "CO"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CSCHEDULEPATTERNID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "ESCHEDULEPATTERNID"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "DAYOFWEEK"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "WEEKNUMBER"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SYSTEMHOLIDAY"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "COMPANYHOLIDAY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "START_DATE"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "END_DATE"
	type = "VARCHAR(4000)"
	nullable = true
}


column {
	name = "DURATION"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MARGINBEFORE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "MARGINAFTER"
	type = "NUMBER(18,2)"
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
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SHIFT"
	type = "VARCHAR(10)"
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
	name = "GRACEAFTER"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "GRACEBEFORE"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "LUNCH"
	type = "NUMBER(18,2)"
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

