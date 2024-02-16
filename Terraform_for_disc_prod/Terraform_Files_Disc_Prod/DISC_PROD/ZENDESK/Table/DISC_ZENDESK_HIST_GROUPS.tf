resource "snowflake_table" "DISC_ZENDESK_HIST_GROUPS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ZENDESK"
	name = "HIST_GROUPS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ZENDESK.HIST_GROUPS

    -- Purpose : Discovery Data Population

    -- Project : ZENDESK

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SOURCE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "JSON_DATA"
	type = "VARIANT"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(9,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(9,0)"
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

