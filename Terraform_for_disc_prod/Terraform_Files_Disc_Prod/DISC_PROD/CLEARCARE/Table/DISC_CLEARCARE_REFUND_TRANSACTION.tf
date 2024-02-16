resource "snowflake_table" "DISC_CLEARCARE_REFUND_TRANSACTION" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CLEARCARE"
	name = "REFUND_TRANSACTION"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CLEARCARE.REFUND_TRANSACTION

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
	name = "PAYEE_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REFUND_METHOD"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AGENCY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "REFUND_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "TRANSACTION_DATE"
	type = "DATE"
	nullable = true
}


column {
	name = "DESCRIPTION"
	type = "VARCHAR(16383)"
	nullable = true
}


column {
	name = "CREATED_TIMESTAMP"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "MODIFIED_TIMESTAMP"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "AMOUNT"
	type = "FLOAT"
	nullable = true
}


column {
	name = "QB_QUEUED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "QB_EXPORTED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "LOCKED"
	type = "BOOLEAN"
	nullable = true
}


column {
	name = "TAXES_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "MILEAGE_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "VISIT_NOTES_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "EXPENSES_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "TRAVEL_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "SPLITS_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "BULK_ADDED_EXPENSE_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "INTEREST_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "CREATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "UPDATED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "DELETED"
	type = "TIMESTAMP_TZ(9)"
	nullable = true
}


column {
	name = "ORIGINATOR_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "LAST_UPDATED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "DELETED_BY_ID"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "AB_ESTIMATES_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "AB_ADJUSTMENTS_TOTAL"
	type = "FLOAT"
	nullable = true
}


column {
	name = "DATE_DELETED"
	type = "TIMESTAMP_TZ(9)"
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

