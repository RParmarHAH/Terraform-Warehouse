resource "snowflake_table" "DISC_AXXESS_AXXESS_INSURANCEFEESCHEDULE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_INSURANCEFEESCHEDULE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_INSURANCEFEESCHEDULE

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
	name = "INSURANCE_FEE_SCHEDULE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHARGE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EXPECTED_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PREFERRED_DESCRIPTION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REVENUE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAXONOMY_CODE"
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

