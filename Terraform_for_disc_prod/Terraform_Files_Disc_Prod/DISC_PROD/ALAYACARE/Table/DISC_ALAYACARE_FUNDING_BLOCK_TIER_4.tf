resource "snowflake_table" "DISC_ALAYACARE_FUNDING_BLOCK_TIER_4" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ALAYACARE"
	name = "FUNDING_BLOCK_TIER_4"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ALAYACARE.FUNDING_BLOCK_TIER_4

    -- Purpose : Discovery Data Population

    -- Project : ALAYACARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "FUNDING_BLOCK_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SERVICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "FUNDING_BLOCK_START_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FUNDING_BLOCK_END_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FUNDING_BLOCK_CREATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FUNDING_BLOCK_REVISION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FUNDING_QUANTITY"
	type = "FLOAT"
	nullable = true
}


column {
	name = "FUNDING_UNITS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FUNDING_COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FUNDING_FREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FUNDING_BLOCK_EXPIRY"
	type = "DATE"
	nullable = true
}


column {
	name = "MASTER"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK"
	type = "VARIANT"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_CREATE_TIME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_END_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_FREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_PPARENT_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_QUANTITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_SERVICE_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_START_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_UNITS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_UPDATE_TIME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VARIANT"
	type = "VARIANT"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_PARENT_COMMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_PARENT_CREATE_TIME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_PARENT_END_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_PARENT_FREQUENCY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_PARENT_FREQUENCY_CUSTOM_DAYS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_PARENT_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_PARENT_QUANTITY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_PARENT_SERVICE_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_PARENT_START_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_PARENT_UNITS"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "PROPERTIES_FUNDING_BLOCK_PARENT_UPDATE_TIME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "VISIT_COUNT"
	type = "NUMBER(1,0)"
	nullable = true
}

}

