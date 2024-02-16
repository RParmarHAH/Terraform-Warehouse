resource "snowflake_table" "DISC_HHAEXCHANGEOSHAH_CLINICALPATHWAYACTIONTAKEN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "HHAEXCHANGEOSHAH"
	name = "CLINICALPATHWAYACTIONTAKEN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.HHAEXCHANGEOSHAH.CLINICALPATHWAYACTIONTAKEN

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
	name = "OBSERVATIONSTANDARDACTIONMASTERID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "ACTIONTAKEN"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "STATUS"
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

