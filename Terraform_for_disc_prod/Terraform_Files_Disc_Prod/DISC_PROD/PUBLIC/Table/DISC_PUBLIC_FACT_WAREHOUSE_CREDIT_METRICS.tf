resource "snowflake_table" "DISC_PUBLIC_FACT_WAREHOUSE_CREDIT_METRICS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "PUBLIC"
	name = "FACT_WAREHOUSE_CREDIT_METRICS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.PUBLIC.FACT_WAREHOUSE_CREDIT_METRICS

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
	name = "WAREHOUSE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREDIT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_CREDITS_USED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_CREDITS_USED_COMPUTE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TOTAL_CREDITS_USED_CLOUD_SERVICES"
	type = "VARCHAR(16777216)"
	nullable = true
}

}

