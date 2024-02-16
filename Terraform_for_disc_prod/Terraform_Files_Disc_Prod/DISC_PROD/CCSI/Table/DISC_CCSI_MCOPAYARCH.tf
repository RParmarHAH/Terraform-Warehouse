resource "snowflake_table" "DISC_CCSI_MCOPAYARCH" {
	database = "DISC_${var.SF_ENVIRONMENT}"
	schema = "CCSI"
	name = "MCOPAYARCH"
	change_tracking = false
	comment = " 
    --*****************************************************************************************************************************

    -- NAME :  DISC_PROD.CCSI.MCOPAYARCH

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
	name = "SERVICE_TYPE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "MEMBER_ID"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CHECK_NUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLIENT_NAME"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "SERVICE_MONTH"
	type = "VARCHAR(7)"
	nullable = true
}


column {
	name = "PART_A_OR_B"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "UNITS"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "AMOUNT_BILLED"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "NET_PAYMENT_AMOUNT"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "INTEREST"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "TOTAL_PAYOUT"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CLIENT_IDOA"
	type = "VARCHAR(1)"
	nullable = true
}


column {
	name = "POSTED_DATE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "POSTING_ERROR"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "ORIGINAL_CHECK_NUMBER"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CSV_POSTED_NOTES"
	type = "VARCHAR(50)"
	nullable = true
}


column {
	name = "AREA_OFFICE"
	type = "VARCHAR(10)"
	nullable = true
}


column {
	name = "CREATED_DATE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "CREATED_BY"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "UPDATED_DATE"
	type = "VARCHAR(20)"
	nullable = true
}


column {
	name = "UPDATED_BY"
	type = "VARCHAR(20)"
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

