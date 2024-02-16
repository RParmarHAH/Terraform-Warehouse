resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_PATIENTPLANS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_PATIENTPLANS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_PATIENTPLANS

    -- Purpose : Discovery Data Population

    -- Project : COSTALSYNCDATA

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "DB"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "RECSTAT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "ENTRY_USER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ENTRY_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "UPDATE_USER"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "UPDATE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PATIENT_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "SEQUENCE_NUMBER"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PLAN_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "POLICY_NUMBER"
	type = "VARCHAR(19)"
	nullable = true
}


column {
	name = "BILLTO_STATUS_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "GROUP_NUMBER"
	type = "VARCHAR(19)"
	nullable = true
}


column {
	name = "PRE_AUTHORIZATION_PATPLN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PRE_AUTHORIZATION_NUMBER"
	type = "VARCHAR(19)"
	nullable = true
}


column {
	name = "RLNSHIP__CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "GUARANTOR_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "EFFECTIVE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXPIRATION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DEDUCTIBLE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "AMOUNT_BILLED"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "AMOUNT_PAID"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LAST_BILL_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_BILL_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "LAST_BILL_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LAST_PAYMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_CHECK_NUMBER"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "LAST_PAYMENT_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LAST_TRACER_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ELECTRONIC_CLAIM_PATPLN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "ACCEPT_ASSIGNMENT_PATPLN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INSURANCE_CATEGORY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CAPITATION_FEE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "CO_PAYMENT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAYOR_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "GROUP_NAME"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CB_CLAIM_NOSV"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "COVERAGE_PAY_SOURCE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "COVERAGE_PLAN"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DDL_BILLING_CYCLE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "DEX_ROW_ID"
	type = "NUMBER(10,0)"
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
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ETL_LAST_UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "ETL_DELETED_FLAG"
	type = "BOOLEAN"
	nullable = true
}

}

