resource "snowflake_table" "DISC_ASR_ASR_SERVICE_TYPE_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "ASR_SERVICE_TYPE_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.ASR_SERVICE_TYPE_MAPPING

    -- Purpose : Discovery Data Population

    -- Project : ASR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SERVICE_TYPE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_TYPE_NAME"
	type = "VARCHAR(64)"
	nullable = true
}


column {
	name = "BASE_RATE"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "UNIT_RATE_15_MINS"
	type = "NUMBER(38,2)"
	nullable = true
}


column {
	name = "IS_FIXED_RATE"
	type = "BOOLEAN"
	nullable = true
}

}

