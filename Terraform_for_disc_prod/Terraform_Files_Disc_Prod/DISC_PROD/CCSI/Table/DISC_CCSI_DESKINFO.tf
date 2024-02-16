resource "snowflake_table" "DISC_CCSI_DESKINFO" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "DESKINFO"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.DESKINFO

    -- Purpose : Discovery Data Population

    -- Project : CCSI

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORD_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AREA"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "DESK_DESIGNATOR"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SUPERVISOR_INITIAL"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SUPERVISOR_NAME"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(200)"
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
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(200)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

