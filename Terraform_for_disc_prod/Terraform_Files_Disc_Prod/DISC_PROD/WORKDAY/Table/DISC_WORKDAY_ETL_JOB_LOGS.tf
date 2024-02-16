resource "snowflake_table" "DISC_WORKDAY_ETL_JOB_LOGS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "WORKDAY"
	name = "ETL_JOB_LOGS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.WORKDAY.ETL_JOB_LOGS

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
	name = "MULESOFT_JOB_START_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MULESOFT_JOB_END_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MULESOFT_PROCESSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "MULESOFT_RECORDS_PROCESSED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DW_JOB_START_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DW_JOB_END_TIME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DW_PROCESSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

