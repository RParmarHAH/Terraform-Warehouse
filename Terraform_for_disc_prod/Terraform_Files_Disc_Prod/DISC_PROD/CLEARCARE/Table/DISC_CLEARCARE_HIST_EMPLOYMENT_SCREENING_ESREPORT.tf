resource "snowflake_table" "DISC_CLEARCARE_HIST_EMPLOYMENT_SCREENING_ESREPORT" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "HIST_EMPLOYMENT_SCREENING_ESREPORT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.HIST_EMPLOYMENT_SCREENING_ESREPORT

    -- Purpose : Discovery Data Population

    -- Project : CLEARCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "CREATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "UPDATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "ORIGINATOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAST_UPDATED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DELETED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REPORT_ID"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CANDIDATE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "VENDOR"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "STATUS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ADJUDICATION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "PACKAGE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "DUE_DATE"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "COMPLETED_AT"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "REPORT_DATA"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "REQUESTED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAST_EVENT_TYPE"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "LAST_EVENT_RECEIVED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "FRANCHISOR_ID"
	type = "NUMBER(38,0)"
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

