resource "snowflake_table" "DISC_ZENDESK_UPDATE_LOG" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ZENDESK"
	name = "UPDATE_LOG"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ZENDESK.UPDATE_LOG

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
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CODERUN_START"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CODERUN_END"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MAX_CREATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TYPE"
	type = "VARCHAR(10)"
	nullable = true
}

}

