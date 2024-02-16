resource "snowflake_table" "DISC_STAGE_MATRIXCARE_OFFICE_MAPPING" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "STAGE"
	name = "MATRIXCARE_OFFICE_MAPPING"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.STAGE.MATRIXCARE_OFFICE_MAPPING

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
	name = "BR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "OFFICE_STATE"
	type = "VARCHAR(2)"
	nullable = true
}


column {
	name = "HAH_OFFICE_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}

}

