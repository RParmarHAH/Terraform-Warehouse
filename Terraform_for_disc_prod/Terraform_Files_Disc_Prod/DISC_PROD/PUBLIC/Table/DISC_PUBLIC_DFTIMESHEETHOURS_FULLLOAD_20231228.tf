resource "snowflake_table" "DISC_PUBLIC_DFTIMESHEETHOURS_FULLLOAD_20231228" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "DFTIMESHEETHOURS_FULLLOAD_20231228"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.DFTIMESHEETHOURS_FULLLOAD_20231228

    -- Purpose : Discovery Data Population

    -- Project : PUBLIC

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DBNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERENCENO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WEEKENDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEDAYOFWEEK"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICEHOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STARTTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ENDTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATEBATCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATEDTIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

