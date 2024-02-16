resource "snowflake_table" "DISC_CLEARCARE_RECEIVABLES_INVOICE" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "RECEIVABLES_INVOICE"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.RECEIVABLES_INVOICE

    -- Purpose : Discovery Data Population

    -- Project : CLEARCARE

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "TRANSACTION_PTR_ID"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "DUE_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "PAID"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "INVOICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "INTEREST_CHARGES_ADDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "QB_INVOICE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SENT_BY_EMAIL"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "EMAIL_SENT_TIMESTAMP"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "OUTSTANDING_BALANCE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PREVIOUS_BALANCE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "NEW_BALANCE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "INTEREST_CHARGED_UNTIL"
	type = "DATE"
	nullable = true
}


column {
	name = "START_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "END_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "SUBTOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "CARELOGS_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "ITEMS_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "PAYMENTS_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TAX_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "COMPOUND_TAX_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "AUTHORIZATION_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "PAYER_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "CHARGE_TAX"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TAX_CARELOGS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TAX_EXPENSES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TAX_MILEAGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ROYALTY_PERCENTAGE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "AUTOPAY_RULE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "IS_ADJUSTMENT"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SCHEDULED_FOR_AUTO_PAY"
	type = "DATE"
	nullable = true
}


column {
	name = "PREPAYMENTS_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "SCHEDULED_START"
	type = "DATE"
	nullable = true
}


column {
	name = "SCHEDULED_END"
	type = "DATE"
	nullable = true
}


column {
	name = "ICD9"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "CCI_CARE_SUMMARY"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CCI_PREPAY_SUMMARY"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ROYALTY_REPORTING_FLAG"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ECLAIM_STATUS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "ADD_SURCHARGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SURCHARGE_APPLY_TO_CREDITS"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SURCHARGE_APPLY_TO_EXPENSES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SURCHARGE_APPLY_TO_INTEREST"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SURCHARGE_APPLY_TO_MILEAGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SURCHARGE_APPLY_TO_VISIT_NOTES"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "SURCHARGE_LABEL"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SURCHARGE_RATE"
	type = "FLOAT"
	nullable = true
}


column {
	name = "SURCHARGE_TYPE"
	type = "NUMBER(32,0)"
	nullable = true
}


column {
	name = "TAX_SURCHARGE"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "IS_ECLAIM"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ECLAIM_VOIDED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "ECLAIM_TXN_STATUS"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "SERVICE_TAXES"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "TAXABLE_CARELOGS_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "FRANCHISOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_VERSION"
	type = "NUMBER(18,0)"
	nullable = true
}


column {
	name = "SYS_CHANGE_OPERATION"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ETL_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_TASK_KEY"
	type = "NUMBER(38,0)"
	nullable = false
}


column {
	name = "ETL_INSERTED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_INSERTED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = false
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = false
}

}

