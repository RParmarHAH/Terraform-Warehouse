resource "snowflake_table" "DISC_AXXESS_AXXESS_HOMEHEALTH_INSURANCEPAYERLIST" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_HOMEHEALTH_INSURANCEPAYERLIST"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_HOMEHEALTH_INSURANCEPAYERLIST

    -- Purpose : Discovery Data Population

    -- Project : AXXESS

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "INSURANCE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "DISPLAY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYER_CLASS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TYPE_OF_BILL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILL_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(6,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

