resource "snowflake_table" "DISC_GENERATIONSALLIANCE_BADGES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "BADGES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.BADGES

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
	name = "BADGEID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CUSTOMLABEL1"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CUST1CUSTFIELD"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "CUST1CUSTTEXT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CUST1CUSTFIELD2"
	type = "VARCHAR(25)"
	nullable = true
}


column {
	name = "CUST1CUSTTEXT2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CUSTOMLABEL2"
	type = "NUMBER(3,0)"
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

