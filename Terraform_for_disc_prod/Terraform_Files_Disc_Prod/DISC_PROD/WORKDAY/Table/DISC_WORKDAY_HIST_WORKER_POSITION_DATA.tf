resource "snowflake_table" "DISC_WORKDAY_HIST_WORKER_POSITION_DATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "WORKDAY"
	name = "HIST_WORKER_POSITION_DATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.WORKDAY.HIST_WORKER_POSITION_DATA

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
	name = "EMPLOYEE_ID"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "OPERATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSITION_ID"
	type = "VARCHAR(16777216)"
	nullable = false
}


column {
	name = "POSITION_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BUSINESS_TITLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "WORKER_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POSITION_TIME_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_EXEMPT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "PAY_RATE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_PROFILE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "JOB_FAMILY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BUSINESS_SITE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BUSINESS_SITE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BUSINESS_SITE_ADDRESS_LINE_DATA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BUSINESS_SITE_ADDRESS_LINE_DATA_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BUSINESS_SITE_MUNICIPALITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BUSINESS_SITE_REGION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BUSINESS_SITE_SUBREGION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BUSINESS_SITE_SUBREGION_2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BUSINESS_SITE_POSTAL_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BUSINESS_SITE_COUNTRY"
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
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "FILE"
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

