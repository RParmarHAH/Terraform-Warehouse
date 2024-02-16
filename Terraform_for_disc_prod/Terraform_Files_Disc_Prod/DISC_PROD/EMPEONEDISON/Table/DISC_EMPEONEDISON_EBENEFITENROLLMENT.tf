resource "snowflake_table" "DISC_EMPEONEDISON_EBENEFITENROLLMENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	name = "EBENEFITENROLLMENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONEDISON.EBENEFITENROLLMENT

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
	name = "BENEFITENROLLMENTID"
	type = "VARCHAR(36)"
	nullable = false
}


column {
	name = "BENEFITPLANID"
	type = "VARCHAR(36)"
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
	name = "STARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "EVENTDETAIL"
	type = "VARCHAR(256)"
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
	name = "EVENT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COVERAGELEVELOVERRIDE"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "ARREAR"
	type = "NUMBER(18,2)"
	nullable = true
}


column {
	name = "DEPENDENTID"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "TERMINATIONEVENT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TERMINATIONEVENTDETAIL"
	type = "VARCHAR(256)"
	nullable = true
}


column {
	name = "LASTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ARREARCAP"
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

