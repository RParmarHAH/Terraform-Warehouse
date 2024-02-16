resource "snowflake_table" "DISC_STAGE_RISKCONNECT_HIERARCHY" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "RISKCONNECT_HIERARCHY"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.STAGE.RISKCONNECT_HIERARCHY

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
	name = "HIERARCHY_NODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_LEVEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_NODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PARENT_NODE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NODE_LEVEL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NODE_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICENO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NODE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NODE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

