resource "snowflake_table" "DISC_ICD_ICD10CM_ORDER_2023" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ICD"
	name = "ICD10CM_ORDER_2023"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ICD.ICD10CM_ORDER_2023

    -- Purpose : Discovery Data Population

    -- Project : ICD

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "ORDER_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ICD_10"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "HIPPA_COVERED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SHORT_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LONG_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}

}

