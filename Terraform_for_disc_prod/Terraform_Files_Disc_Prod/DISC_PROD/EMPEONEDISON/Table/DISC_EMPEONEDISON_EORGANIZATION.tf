resource "snowflake_table" "DISC_EMPEONEDISON_EORGANIZATION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONEDISON"
	name = "EORGANIZATION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONEDISON.EORGANIZATION

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
	name = "ORGANIZATIONID"
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
	name = "STARTDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "ENDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DEPARTMENT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "DIVISION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "POSITION"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FLOORUNIT"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MAILSTOP"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "MANAGER"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REASON"
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
	name = "CLASS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "TEAM"
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

