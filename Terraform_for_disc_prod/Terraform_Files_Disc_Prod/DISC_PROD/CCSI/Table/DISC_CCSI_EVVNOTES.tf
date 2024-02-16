resource "snowflake_table" "DISC_CCSI_EVVNOTES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "EVVNOTES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.EVVNOTES

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
	name = "DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "TIME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "WORKER_NO"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "WORKER_NAME"
	type = "VARCHAR(500)"
	nullable = true
}


column {
	name = "NOTE_1"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "NOTE_2"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "NOTE_3"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "NOTE_4"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "FOLLOW_UP"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DESK"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PRINTED"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PUNCH_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PUNCH_TIME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PUNCH_IN_OUT"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "HCA_HAS_SMARTPHONE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CALLER_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SHARED_CODE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(10)"
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

