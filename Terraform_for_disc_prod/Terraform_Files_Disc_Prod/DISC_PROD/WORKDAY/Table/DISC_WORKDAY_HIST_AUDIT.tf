resource "snowflake_table" "DISC_WORKDAY_HIST_AUDIT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "WORKDAY"
	name = "HIST_AUDIT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.WORKDAY.HIST_AUDIT

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
	name = "VERSION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIOR_ENTRY_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT_ENTRY_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIOR_EFFECTIVE_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT_EFFECTIVE_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FULL_FILE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "DOCUMENT_RETENTION_POLICY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKER_COUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LANDING_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LANDING_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FILE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROCESSED_TIMESTAMP"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

