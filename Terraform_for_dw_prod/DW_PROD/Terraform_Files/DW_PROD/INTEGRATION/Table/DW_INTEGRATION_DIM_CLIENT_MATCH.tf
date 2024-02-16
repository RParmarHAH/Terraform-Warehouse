resource "snowflake_table" "DW_INTEGRATION_DIM_CLIENT_MATCH" {
	database = "DW_${var.SF_ENVIRONMENT}"
	schema = "INTEGRATION"
	name = "DIM_CLIENT_MATCH"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DW_PROD.INTEGRATION.DIM_CLIENT_MATCH

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
	name = "ORIGINAL_RECORD_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MASTER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLUSTER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "BEGIN_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "RECORD_ORDER"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "CLIENT_FIRST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_LAST_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_MIDDLE_NAME"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLIENT_NAME"
	type = "VARCHAR(150)"
	nullable = true
}


column {
	name = "CLIENT_DOB"
	type = "DATE"
	nullable = true
}


column {
	name = "CLIENT_PID"
	type = "VARCHAR(32)"
	nullable = true
}


column {
	name = "CLIENT_CITY"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "CLIENT_ZIP"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "CLIENT_CELL_PHONE"
	type = "VARCHAR(20)"
	nullable = true
}

}

