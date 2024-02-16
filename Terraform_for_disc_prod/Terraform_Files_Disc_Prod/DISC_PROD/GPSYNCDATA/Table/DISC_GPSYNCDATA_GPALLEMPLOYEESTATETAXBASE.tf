resource "snowflake_table" "DISC_GPSYNCDATA_GPALLEMPLOYEESTATETAXBASE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GPSYNCDATA"
	name = "GPALLEMPLOYEESTATETAXBASE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GPSYNCDATA.GPALLEMPLOYEESTATETAXBASE

    -- Purpose : Discovery Data Population

    -- Project : GPSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "EXEMPT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "WITHHOLDING"
	type = "NUMBER(18,5)"
	nullable = true
}


column {
	name = "FILINGSTATUS"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "FILINGSTATUSTEXT"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "INACTIVE"
	type = "NUMBER(10,0)"
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

