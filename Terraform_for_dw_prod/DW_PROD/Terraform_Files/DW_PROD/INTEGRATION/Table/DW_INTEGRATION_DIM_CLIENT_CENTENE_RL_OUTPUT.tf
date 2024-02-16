resource "snowflake_table" "DW_INTEGRATION_DIM_CLIENT_CENTENE_RL_OUTPUT" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "DIM_CLIENT_CENTENE_RL_OUTPUT"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.DIM_CLIENT_CENTENE_RL_OUTPUT

    -- Purpose : Business Integration Data Population

    -- Project : INTEGRATION

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-16  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_KEY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_DOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FIRST_NAME_FIRST_PART"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_MIDDLE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_NAME_FIRST_PART"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAID_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SOURCE_SYSTEM_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLUSTER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RULE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DEDUPE_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

