resource "snowflake_table" "DISC_UTIL_GP_PAYCODES_MAP_TO_SERVICE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "UTIL"
	name = "GP_PAYCODES_MAP_TO_SERVICE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.UTIL.GP_PAYCODES_MAP_TO_SERVICE

    -- Purpose : Discovery Data Population

    -- Project : UTIL

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
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PAY_CODE"
	type = "VARCHAR(12)"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "IS_CODE_ACTIVE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_OVERTIME_CODE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_SERVICE_DELIVERY_CODE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SERVICE_CODE"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICE_DESCRIPTION"
	type = "VARCHAR(1024)"
	nullable = true
}

}

