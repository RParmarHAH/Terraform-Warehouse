resource "snowflake_table" "DISC_EMPEONPREFERRED_ENOTE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "EMPEONPREFERRED"
	name = "ENOTE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.EMPEONPREFERRED.ENOTE

    -- Purpose : Discovery Data Population

    -- Project : EMPEONPREFERRED

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "NOTEID"
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
	name = "TEXT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IMPORTANT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CREATEDBY"
	type = "VARCHAR(450)"
	nullable = true
}


column {
	name = "CREATEDON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEDON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DUEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RESOLVED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "RESOLVEDON"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RESOLVEDBY"
	type = "VARCHAR(450)"
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
	name = "CREATEDBYID"
	type = "VARCHAR(450)"
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

