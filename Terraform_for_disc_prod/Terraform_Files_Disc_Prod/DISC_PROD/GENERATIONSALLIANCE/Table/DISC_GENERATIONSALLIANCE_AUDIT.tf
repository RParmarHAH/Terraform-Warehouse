resource "snowflake_table" "DISC_GENERATIONSALLIANCE_AUDIT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "AUDIT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.AUDIT

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
	name = "TYPE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "TABLENAME"
	type = "VARCHAR(500)"
	nullable = false
}


column {
	name = "PK"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "FIELDNAME"
	type = "VARCHAR(500)"
	nullable = false
}


column {
	name = "OLDVALUE"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "NEWVALUE"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "UPDATEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "USERNAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "DISPLAYNAME"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "AUDITID"
	type = "VARCHAR(15)"
	nullable = false
}


column {
	name = "AREATYPE"
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

