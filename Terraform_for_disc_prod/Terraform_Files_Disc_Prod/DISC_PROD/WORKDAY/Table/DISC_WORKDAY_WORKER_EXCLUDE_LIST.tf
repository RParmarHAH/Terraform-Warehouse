resource "snowflake_table" "DISC_WORKDAY_WORKER_EXCLUDE_LIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "WORKDAY"
	name = "WORKER_EXCLUDE_LIST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.WORKDAY.WORKER_EXCLUDE_LIST

    -- Purpose : Discovery Data Population

    -- Project : WORKDAY

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "Action Event"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Date And Time Completed"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Effective Date"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Business Process Type"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "Worker"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CFI INT005 Worker ID LRV"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACTIONS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKER_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RECORD_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

