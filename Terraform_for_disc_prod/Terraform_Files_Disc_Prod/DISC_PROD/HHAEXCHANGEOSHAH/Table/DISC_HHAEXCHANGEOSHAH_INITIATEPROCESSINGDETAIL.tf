resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_INITIATEPROCESSINGDETAIL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "INITIATEPROCESSINGDETAIL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.INITIATEPROCESSINGDETAIL

    -- Purpose : Discovery Data Population

    -- Project : HHAEXCHANGEOSHAH

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "AGENCYID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "AUTOPROCESSSETUPID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "PROCESSNAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "LASTEXECUTED"
	type = "VARCHAR(16)"
	nullable = true
}


column {
	name = "USERNAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "DURATION"
	type = "VARCHAR(8)"
	nullable = true
}


column {
	name = "PROCESSINFO"
	type = "VARCHAR(8000)"
	nullable = true
}


column {
	name = "OFFICES"
	type = "VARCHAR(8000)"
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

