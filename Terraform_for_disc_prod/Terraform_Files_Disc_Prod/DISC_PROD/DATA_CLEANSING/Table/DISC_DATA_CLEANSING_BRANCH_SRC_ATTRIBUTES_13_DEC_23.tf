resource "snowflake_table" "DISC_DATA_CLEANSING_BRANCH_SRC_ATTRIBUTES_13_DEC_23" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "DATA_CLEANSING"
	name = "BRANCH_SRC_ATTRIBUTES_13_DEC_23"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.DATA_CLEANSING.BRANCH_SRC_ATTRIBUTES_13_DEC_23

    -- Purpose : Discovery Data Population

    -- Project : DATA_CLEANSING

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "SOURCE_SYSTEM_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYSTEM_CODE"
	type = "VARCHAR(30)"
	nullable = true
}


column {
	name = "OFFICE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OFFICE_CODE"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "OFFICE_NAME"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SRC_BRANCH_ADDRESS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SRC_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SRC_STATE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SRC_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SRC_BRANCH_ADDRESS_PROCESSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SRC_BRANCH_ADDRESS_SUCCESSFULLY_CLEANSED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

