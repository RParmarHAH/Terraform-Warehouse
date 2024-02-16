resource "snowflake_table" "DISC_AXXESS_HIST_AXXESS_HH_AGENCYINFO" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "HIST_AXXESS_HH_AGENCYINFO"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.HIST_AXXESS_HH_AGENCYINFO

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
	name = "AGENCY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CREATE_TIMESTAMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UPDATE_TIMESTAMP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TAX_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NATIONAL_PROVIDER_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICARE_PROVIDER_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MEDICAID_PROVIDER_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "UNIQUE_AGENCY_OASIS_ID"
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

