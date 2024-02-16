resource "snowflake_table" "DISC_STAGE_COASTAL_OFFICE_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "COASTAL_OFFICE_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.STAGE.COASTAL_OFFICE_MAPPING

    -- Purpose : Discovery Data Population

    -- Project : STAGE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "COASTAL_PARENT_OFFICE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HAH_OFFICE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HAH_OFFICE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

