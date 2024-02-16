resource "snowflake_table" "DISC_AXXESS_HIST_AXXESS_TRANSACTIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "HIST_AXXESS_TRANSACTIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.HIST_AXXESS_TRANSACTIONS

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
	name = "BRANCH_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FACT_AR_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_REMITTANCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_MANUAL_PAYMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_ADJUSTMENT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYMENT_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYMENT_POST_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTMENT_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTMENT_POST_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CHECK_RA"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EFT_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
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

