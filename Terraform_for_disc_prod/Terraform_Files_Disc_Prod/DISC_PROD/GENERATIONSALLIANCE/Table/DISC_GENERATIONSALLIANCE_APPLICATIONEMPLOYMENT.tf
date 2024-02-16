resource "snowflake_table" "DISC_GENERATIONSALLIANCE_APPLICATIONEMPLOYMENT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "APPLICATIONEMPLOYMENT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.APPLICATIONEMPLOYMENT

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
	name = "APPID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "COMPANY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DATEFROM"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "DATETO"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "JOBTITLE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "REASONLEFT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "DUTIES"
	type = "VARCHAR(300)"
	nullable = true
}


column {
	name = "SUPERVISOR"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "PHONE"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "MAYCONTACT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "RELATIONSHIP"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "YEARSKNOWN"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "RPHONE"
	type = "VARCHAR(21)"
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

