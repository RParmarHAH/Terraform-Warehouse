resource "snowflake_table" "DISC_PUBLIC_DFTIMESHEETHOURS_FULLLOAD_20230901" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "DFTIMESHEETHOURS_FULLLOAD_20230901"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.DFTIMESHEETHOURS_FULLLOAD_20230901

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
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "REFERENCENO"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WEEKENDDATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SERVICEDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SERVICEDAYOFWEEK"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SERVICEHOURS"
	type = "NUMBER(12,5)"
	nullable = true
}


column {
	name = "BILLED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "STARTTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ENDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CREATEDDATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATEBATCH"
	type = "VARCHAR(36)"
	nullable = true
}


column {
	name = "UPDATEDTIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAID"
	type = "BOOLEAN"
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
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

