resource "snowflake_table" "DISC_GENERATIONSALLIANCE_CLEANBILLINGDETAIL" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "GENERATIONSALLIANCE"
	name = "CLEANBILLINGDETAIL"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.GENERATIONSALLIANCE.CLEANBILLINGDETAIL

    -- Purpose : Discovery Data Population

    -- Project : GENERATIONSALLIANCE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CLIENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_IN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TIME_OUT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CAREGIVER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REVENUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DOS_MONTH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RATE_OVERRIDE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTED_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CURRENT_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTED_REVENUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRO_FORMA_REVENUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTRACTED_YEAR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXTRACTED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DATE_FORMATTED"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

