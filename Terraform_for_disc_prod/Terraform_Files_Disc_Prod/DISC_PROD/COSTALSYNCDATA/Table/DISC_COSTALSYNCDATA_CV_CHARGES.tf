resource "snowflake_table" "DISC_COSTALSYNCDATA_CV_CHARGES" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "CV_CHARGES"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.CV_CHARGES

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
	type = "VARCHAR(128)"
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
	name = "SERVICE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "BILL_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "SEQUENCE_NUMBER"
	type = "NUMBER(19,5)"
	nullable = true
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
	name = "JOURNAL_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "DDL_CHARGE_SELECT_NOSV"
	type = "NUMBER(5,0)"
	nullable = true
}


column {
	name = "LAST_POST_DATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "DDL_CHARGE_SOURCE"
	type = "NUMBER(5,0)"
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

