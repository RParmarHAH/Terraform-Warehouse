resource "snowflake_table" "DISC_ASR_HIST_ASR_LOCATIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "HIST_ASR_LOCATIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.HIST_ASR_LOCATIONS

    -- Purpose : Discovery Data Population

    -- Project : ASR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "LOCATIONID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONNAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NOTIFICATIONEMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_AUTHETNICATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EVV_USES_UAT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROVIDER_MEDICAID_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATIONNUMBER"
	type = "VARCHAR(16777216)"
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
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

