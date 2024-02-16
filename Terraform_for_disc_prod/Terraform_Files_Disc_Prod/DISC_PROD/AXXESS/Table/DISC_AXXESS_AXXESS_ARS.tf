resource "snowflake_table" "DISC_AXXESS_AXXESS_ARS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "AXXESS"
	name = "AXXESS_ARS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.AXXESS.AXXESS_ARS

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
	name = "ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BRANCH_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_ID"
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
	name = "MRN"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PRIMARY_INSURANCE_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ASSESSMENT_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CLAIM_END_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CASH_RECEIVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RAP_BILL_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_FIRST_BILLABLE_VISIT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_CLASS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYOR_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ORIGINAL_HIPPS_REVENUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PATIENT_FULL_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADJUSTED_REVENUE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FINAL_OR_MANAGEDCARE_BILL_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FINAL_OR_MANAGEDCARE_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "GROSS_AR"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NET_ADJUSTMENTS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "NET_RECEIVABLE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RAP_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FINAL_OR_MANAGEDCARE_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RAP_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_END_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EPISODE_START_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_SOE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ADMISSION_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLING_PERIOD_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FINAL_CLAIM_PAYMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "MANAGED_CLAIM_PAYMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RAP_CLAIM_PAYMENT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "FINAL_CLAIM_CASH_RECEIVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "RAP_CASH_RECEIVED"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PHYSICIAN_NAME"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "INSURANCE_ID"
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

