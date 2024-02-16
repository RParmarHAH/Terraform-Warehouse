resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_MDCHGTRN" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_MDCHGTRN"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_MDCHGTRN

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
	type = "VARCHAR(25)"
	nullable = false
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
	name = "CRLF"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PATIENT_NUMBER"
	type = "VARCHAR(9)"
	nullable = false
}


column {
	name = "SERVICE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = false
}


column {
	name = "BILL_NUMBER"
	type = "VARCHAR(7)"
	nullable = false
}


column {
	name = "SEQUENCE_NUMBER"
	type = "NUMBER(19,5)"
	nullable = false
}


column {
	name = "SERVICE_THRU_DATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "PROCCODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "NUMBER_OF_UNIT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "UNIT_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "EXTENDED_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PLACE_OF_SERVICE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "FACILITY_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "TYPE_OF_SERVICE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MODIFIER1"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MODIFIER2"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "MODIFIER3"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "DIAGNOSTIC_REFERENCE1"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DIAGNOSTIC_REFERENCE2"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DIAGNOSTIC_REFERENCE3"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "DIAGNOSTIC_REFERENCE4"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "REMARK_20"
	type = "VARCHAR(81)"
	nullable = true
}


column {
	name = "ACCEPT_ASSIGNMENT_BLANK"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "APPROVED_AMOUNT10_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "BALANCE10_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PATIENT_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PLAN_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "BILLTO_AT_POST"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PLAN_AT_POST"
	type = "VARCHAR(7)"
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
	name = "CLAIM_COUNT"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "STATEMENT_COUNT"
	type = "VARCHAR(3)"
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
	name = "POST_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BILL_TYPE"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "FAMILY_PLAN"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "EMERGENCY"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "COORDINATION__BENEFITS"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "JOURNAL_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PATIENT_BALANCE12_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PLAN_BALANCE12_2"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DDL_CHARGE_SELECT_NOSV"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "EQUIPMENT_TRAN_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "RX_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "RECLAIM_STATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "LAST_POST_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "START_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "END_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TIME_UNIT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "EMERGENCY_UNIT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PHYSICAL_UNIT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "POSTING_STATUS"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "USE_APPROVED"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "APPROVED_AMOUNT82"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "CHARGE_ADJUSTMENT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "CHARGE_AMOUNT82"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PPR_PAYMENT_METHOD"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "PAYMENT_AMOUNT82"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "LOCATION_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PANEL_CODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "DEPARTMENT__CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "NUMBER_OF_VISIT"
	type = "NUMBER(10,0)"
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
	name = "DISCOUNT_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "UNIT_DISCOUNTED_FEE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DISCOUNTED_FEE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "UNIT_COST"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "COST"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "UNIT_PROFESSIONAL_FEE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PROFESSIONAL_FEE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "UNIT_MAXIMUM_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "MAXIMUM_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "UNIT_CO_PAYMENT_CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "CO_PAYMENT__CHARGE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "BILL_ADJUSTMENT_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "CB_SECONDARY_CLAIM"
	type = "NUMBER(3,0)"
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
	name = "DEBIT_BILL_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DEBIT_BILL_NUMBER_SEQ"
	type = "NUMBER(19,5)"
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
	name = "CB_NON_COVERED_CHARGES"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "UNIT_OF_MEASURE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "NUMBER_OF_DAYS_HOURS"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "DDL_BILL_TYPE"
	type = "NUMBER(5,0)"
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
	name = "SCHEDULE_TIME"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "DURATION"
	type = "VARCHAR(5)"
	nullable = true
}


column {
	name = "REFERRING_SOURCE_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "LAST_PAYMENT_POST_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CERT_TRAN_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "BATCH_NUMBER"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "ADMISSION_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "BILL_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FIRST_PAYMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FIRST_PAYMENT_POST_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TRANSACTION_SERVICE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "TRANSACTION_POST_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FIRST_TRAN_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "FIRST_TRAN_POST_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MAX_TRAN_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MAX_TRAN_POST_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "MODIFIER4"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SOURCE_SERIAL"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "SOURCE_SEQUENCE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NDC_NUMBER"
	type = "VARCHAR(15)"
	nullable = true
}


column {
	name = "UNIT_PRICE"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NDC_UNIT_MEASURE"
	type = "VARCHAR(11)"
	nullable = true
}


column {
	name = "UNIT_QUANTITY"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PRESCRIPTION_NUMBER"
	type = "VARCHAR(21)"
	nullable = true
}


column {
	name = "MDS_NUMBER"
	type = "VARCHAR(15)"
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

