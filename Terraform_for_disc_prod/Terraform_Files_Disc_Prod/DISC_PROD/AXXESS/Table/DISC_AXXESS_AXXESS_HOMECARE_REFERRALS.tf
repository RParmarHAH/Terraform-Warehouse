resource "snowflake_table" "DISC_AXXESS_AXXESS_HOMECARE_REFERRALS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_HOMECARE_REFERRALS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_HOMECARE_REFERRALS

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
	name = "REFERRAL_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "AGENCY_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_DOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_GENDER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "REFERRAL_IS_NONMEDICAL"
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

