resource "snowflake_table" "DISC_STAGE_ADAPTIVE_CONTRACTCODE_MAPPING_MI" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "ADAPTIVE_CONTRACTCODE_MAPPING_MI"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.STAGE.ADAPTIVE_CONTRACTCODE_MAPPING_MI

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
	name = "PAYOR_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "SERVICE_CODE"
	type = "VARCHAR(10)"
	nullable = false
}


column {
	name = "STATE"
	type = "VARCHAR(2)"
	nullable = false
}


column {
	name = "CONTRACT_CODE"
	type = "VARCHAR(10)"
	nullable = true
}

}

