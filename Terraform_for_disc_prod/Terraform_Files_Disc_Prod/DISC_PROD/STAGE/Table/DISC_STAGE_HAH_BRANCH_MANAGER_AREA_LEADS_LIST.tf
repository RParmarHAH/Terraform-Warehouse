resource "snowflake_table" "DISC_STAGE_HAH_BRANCH_MANAGER_AREA_LEADS_LIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "HAH_BRANCH_MANAGER_AREA_LEADS_LIST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.STAGE.HAH_BRANCH_MANAGER_AREA_LEADS_LIST

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
	name = "OFFICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_MANAGER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHONE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AREA_LEADER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AREA_LEADER_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE_LEADERSHIP_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE_LEADERSHIP_EMAIL"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

