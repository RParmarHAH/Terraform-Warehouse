resource "snowflake_table" "DISC_COSTALSYNCDATA_HIST_CV_BILLINGDATA" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "COSTALSYNCDATA"
	name = "HIST_CV_BILLINGDATA"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.COSTALSYNCDATA.HIST_CV_BILLINGDATA

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
	name = "BILL_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PATIENT_NUMBER"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "BILL_DATE"
	type = "TIMESTAMP_NTZ(9)"
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
	name = "BILLTO_STATUS_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PROVIDER_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "LOCATION_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PLAN_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "BILL_RECSTAT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "BILL_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "SEQUENCE_NUMBER"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PROCCODE"
	type = "VARCHAR(9)"
	nullable = true
}


column {
	name = "CHARGE_PLAN_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "TYPE_OF_SERVICE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "SERVICE_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "EXTENDED_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "CHARGE_ADJUSTMENT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "UNIT_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "NUMBER_OF_UNIT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "CHARGE_POST_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "CHARGE_RECSTAT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "CHARGE_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "PAY_RECSTAT"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "PAYMENT_NUMBER"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PAYMENT_PLAN_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PAID_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAYMENT_POST_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "PAYMENT_CODE"
	type = "VARCHAR(3)"
	nullable = true
}


column {
	name = "PAYMENT_DATE"
	type = "TIMESTAMP_NTZ(9)"
	nullable = true
}


column {
	name = "APPROVED_WRITEOFF_AMOUNT"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "PAYMENT_CHARGE_ADJUSTMENT"
	type = "NUMBER(3,0)"
	nullable = true
}


column {
	name = "PAY_ROW_ID"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "TIME_TRANSLATION_CODE"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "HOUR_TO_UNIT_FACTOR"
	type = "NUMBER(10,0)"
	nullable = true
}


column {
	name = "NUMBER_OF_HOUR"
	type = "NUMBER(19,5)"
	nullable = true
}


column {
	name = "ROWID"
	type = "NUMBER(10,0)"
	nullable = false
}


column {
	name = "CLAIM_STATUS"
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

