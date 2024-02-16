resource "snowflake_table" "DISC_AXXESS_AXXESS_FINANCIALTRANSACTIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_FINANCIALTRANSACTIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_FINANCIALTRANSACTIONS

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
	name = "BRANCH_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ACCOUNT_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_FIRST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_LAST_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_MIDDLE_INITIAL"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_DOB"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ADDRESS1"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ADDRESS2"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_STATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_CITY"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_ZIP"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_REFERRAL_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_DIAGNOSIS_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENT_DIAGNOSIS_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_INSURANCE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRANSACTION_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRANSACTION_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "TRANSACTION_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLED_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTMENT_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYMENT_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_STARTDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_ENDDATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSIONISDEPRECATED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_STATE_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ZIP_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLIENTISDEPRECATED"
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

