resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_BILLINGTRANSACTIONS" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_BILLINGTRANSACTIONS"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_BILLINGTRANSACTIONS

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
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ENTRY_DATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "BILL_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "BILL_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BATCH_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "SUPER_BILL_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PROVIDER_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "BILLTO_STATUS_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PLAN_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "REFERRING_SOURCE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "LOCATION_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "CB_PRE_AUTHORIZED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PRE_AUTHORIZATION_NUMBER"
	type = "VARCHAR(19)"
	nullable = true
}


column {
	name = "PRE_AUTHORIZATION_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CB_CONV_AUTH_TO_BILL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DIAGNOSIS1"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DIAGNOSIS2"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DIAGNOSIS3"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DIAGNOSIS4"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DIAGNOSIS5"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DIAGNOSIS6"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "EXTENDED_DIAGNOSIS1"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "EXTENDED_DIAGNOSIS2"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "EXTENDED_DIAGNOSIS3"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "EXTENDED_DIAGNOSIS4"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "EXTENDED_DIAGNOSIS5"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "EXTENDED_DIAGNOSIS6"
	type = "VARCHAR(31)"
	nullable = true
}


column {
	name = "BILL_NOTE1"
	type = "VARCHAR(51)"
	nullable = true
}


column {
	name = "BILL_NOTE2"
	type = "VARCHAR(51)"
	nullable = true
}


column {
	name = "BILL_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAYMENT_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "ADJUSTMENT_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PLAN_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PATIENT_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LAST_PAYMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_ADJUSTMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_BILLTO_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_STATEMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "LAST_CLAIM_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CLAIM_STATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "STATEMENT_STATUS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "BILL_TYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "JOURNAL_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "RESUBMISSION"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "RESUBMISSION_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "FACILITY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "NUMBER_OF_VISIT"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "CO_PAYMENT__CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "ADMISSION_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "GROUP_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CB_ASSIGNMENT_COMPLETE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DEPARTMENT__CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SEQUENCE_NUMBER"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "POSTING_STATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CONTRACTUAL_PMT_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "POST_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SALES_TAX"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "CB_HOLD_BILL"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_USE_BILL_PROV_FOR_CLM"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CB_EXCLUDE_MANAGEMENT_FE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "SCHEDULE_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "TRANSFER_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "BILL_ADJUSTMENT_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CB_CO_PAY_TRANSFER"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_CHARGE_SOURCE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CREDIT_BILL_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DEBIT_BILL_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "TRANSACTION_NUMBER"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "UNIFIED_TRANSACTION_NUM"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CHARGE_ADJUSTMENT_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "BILL_CLASSIFICATION_CODE"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REFERRING_PHYSICIAN_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DDL_BILL_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "CERTIFICATION_CODE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "BILL_COUNT"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PROGRAM_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CB_DELETED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "INTERFACE_BILL_NUMBER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "REFERRAL_IN_NUMBER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "SALES_ORDER_NUMBER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "RENTAL_ORDER_NUMBER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "CERT_TRAN_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "CP_CLINICAL_NOTE_NUMBER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "ILLNESS_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "SIMILAR_SYMPTOM_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CB_EMPLOYMENT_RELATED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "DDL_ACCIDENT_TYPE"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "ACCIDENT_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "ACCIDENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "ACCIDENT_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "STATE_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DISABLED_FROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISABLED_THRU"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DISABILITY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PARTIAL_DISABILITY_FROM"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PARTIAL_DISABILITY"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "RETURN_TO_WORK"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "OUTSIDE_LAB_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PROCCODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "OUTSIDE_LAB_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "CHARGE_SOURCE_ID"
	type = "VARCHAR(41)"
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

