resource "snowflake_table" "DISC_PUBLIC_RCM_MO_20230124" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "RCM_MO_20230124"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.RCM_MO_20230124

    -- Purpose : Discovery Data Population

    -- Project : PUBLIC

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "INVOICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTRACT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PERIOD"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMOUNT_BILLED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AMOUNT_RECEIVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LAST_PAY_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OUTSTANDING"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SUPP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "OFFICE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CONTRACT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

