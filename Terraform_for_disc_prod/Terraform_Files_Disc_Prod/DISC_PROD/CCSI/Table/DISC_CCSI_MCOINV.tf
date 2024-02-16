resource "snowflake_table" "DISC_CCSI_MCOINV" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "MCOINV"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.MCOINV

    -- Purpose : Discovery Data Population

    -- Project : CCSI

    -- Source Data update Frequency : 60 min

    --

    -- DEVELOPMENT LOG:

    -- DATE        AUTHOR                NOTES:

    -- ----------  -------------------   -----------------------------------------------------------------------------------------------

    -- 2024-02-14  Terraform            Initial Development(from Terraform GitHub Action Deployment)

    --*****************************************************************************************************************************
            "

column {
	name = "RECORD_NUMBER"
	type = "NUMBER(38,0)"
	nullable = true
}


column {
	name = "MCO_COMPANY"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CCSI_OFFICE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CLIENT_SERVICED"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CLIENT_ID"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "SERVICE_TYPE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "SERVICE_MONTH"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "PART"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UNITS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "DOLLAR_AMOUNT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "C_CHECK_NO_1"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "AMOUNT_1"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "P_PAYMENT_DATE_1"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "C_CHECK_NO_2"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "AMOUNT_2"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "P_PAYMENT_DATE_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "C_CHECK_NO_3"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "AMOUNT_3"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "P_PAYMENT_DATE_3"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "BALANCE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "RECOUPED_FIELD"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "INTEREST_PMT_1"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ADJUSTMENT"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ADJUSTMENT_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "COMMENTS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "ADJUSTMENT_RECLASS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SOURCE"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "DENIED"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "REBILLED"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "SEARCH_FLAG"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "RATE_BILLED"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "RATE_PAID"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "PAID_UNITS"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "C_CHECK_NO_4"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "AMOUNT_NO_4"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "P_PAY_DATE_NO_4"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CSV_POSTED_NOTES"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "INTEREST_PMT_4"
	type = "VARCHAR(1000)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_DATE_2"
	type = "VARCHAR(100)"
	nullable = true
}


column {
	name = "UPDATED_BY_2"
	type = "VARCHAR(100)"
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

