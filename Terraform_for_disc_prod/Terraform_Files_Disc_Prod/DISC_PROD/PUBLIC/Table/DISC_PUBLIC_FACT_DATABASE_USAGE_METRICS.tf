resource "snowflake_table" "DISC_PUBLIC_FACT_DATABASE_USAGE_METRICS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "FACT_DATABASE_USAGE_METRICS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.FACT_DATABASE_USAGE_METRICS

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
	name = "DATABASE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "USAGE_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DB_SIZE_GB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FAILSAFE_SIZE_GB"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

