resource "snowflake_table" "DISC_ASR_ASR_P&R2022" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "ASR"
	name = "ASR_P&R2022"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.ASR.ASR_P&R2022

    -- Purpose : Discovery Data Population

    -- Project : ASR

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "CUSTOMER_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "CUSTOMER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "EMPLOYEE_ID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PROGRAM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "SERVICE_TYPE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYER_SOURCE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLING_CODE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "LOCATION"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "VISIT_STATUS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "POS_HOURS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYABLE_OR_BILLIABLE_HRS"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAY_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "PAYABLE_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "IS_PAID"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLING_RATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLING_PREMIUM"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLING_PREMIUM_TAG"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLING_AMOUNT"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLING_TRAN_ID_NUMBER"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLING_DATE"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "BILLING_MEMO"
	type = "VARCHAR(16777216)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(1,0)"
	nullable = true
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(1,0)"
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

