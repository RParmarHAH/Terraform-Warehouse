resource "snowflake_table" "DISC_GENERATIONSALLIANCE_TMPAUTHVALIDATIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "TMPAUTHVALIDATIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.TMPAUTHVALIDATIONS

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
	name = "CLIENTID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "SRID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "AUTHORIZATIONID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "DTBEGIN"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SCHEDULED"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "ALLOWED"
	type = "NUMBER(16,2)"
	nullable = true
}


column {
	name = "MAXALLOWED"
	type = "NUMBER(16,2)"
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

