resource "snowflake_table" "DISC_AXXESS_AXXESS_VISIT_STATUS_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_VISIT_STATUS_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_VISIT_STATUS_MAPPING

    -- Purpose : Discovery Data Population

    -- Project : AXXESS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "REVENUE_CATEGORY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SCHEDULED_TASK_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATUS_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

